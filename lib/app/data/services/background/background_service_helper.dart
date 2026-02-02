import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gw_sms/app/data/services/background/background_sms_service.dart';
import 'package:gw_sms/app/domain/services/sms_service.dart';

class BackgroundServiceHelper {
  factory BackgroundServiceHelper() => _instance;

  BackgroundServiceHelper._internal();
  static final BackgroundServiceHelper _instance =
      BackgroundServiceHelper._internal();

  final FlutterBackgroundService _service = FlutterBackgroundService();
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  StreamSubscription<dynamic>? _statusSubscription;
  StreamSubscription<dynamic>? _smsStatusSubscription;
  StreamSubscription<dynamic>? _smsRequestSubscription;

  /// Inicializa el servicio de background
  Future<bool> initializeService() async {
    try {
      // Inicializar notificaciones
      await _initializeNotifications();

      // Configurar el servicio de background
      await _service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: false,
          isForegroundMode: true,
          notificationChannelId: 'gw_sms_background',
          initialNotificationTitle: 'Servicio SMS Activo',
          initialNotificationContent: 'Esperando mensajes...',
          foregroundServiceNotificationId: 888,
          foregroundServiceTypes: [AndroidForegroundType.dataSync],
        ),
        iosConfiguration: IosConfiguration(
          autoStart: false,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
      );

      print('✅ Servicio de background inicializado correctamente');
      return true;
    } catch (e) {
      print('❌ Error al inicializar servicio de background: $e');
      return false;
    }
  }

  /// Inicia el servicio de background
  Future<bool> startService() async {
    try {
      final isRunning = await _service.isRunning();
      if (isRunning) {
        print('ℹ️ El servicio ya está ejecutándose');
        return true;
      }

      final started = await _service.startService();
      if (started) {
        print('✅ Servicio de background iniciado');
        _setupListeners();
      } else {
        print('❌ No se pudo iniciar el servicio');
      }
      return started;
    } catch (e) {
      print('❌ Error al iniciar servicio: $e');
      return false;
    }
  }

  /// Detiene el servicio de background
  Future<void> stopService() async {
    try {
      final isRunning = await _service.isRunning();
      if (!isRunning) {
        print('ℹ️ El servicio no está ejecutándose');
        return;
      }

      _service.invoke('stopService');
      _statusSubscription?.cancel();
      _smsStatusSubscription?.cancel();
      _smsRequestSubscription?.cancel();
      print('✅ Servicio de background detenido');
    } catch (e) {
      print('❌ Error al detener servicio: $e');
    }
  }

  /// Actualiza la operadora y SIM slot en el servicio
  Future<void> updateOperadora(String operadora, int simSlot) async {
    try {
      _service.invoke('updateOperadora', {
        'operadora': operadora,
        'simSlot': simSlot,
      });
      print('✅ Operadora actualizada en servicio: $operadora (SIM $simSlot)');
    } catch (e) {
      print('❌ Error al actualizar operadora: $e');
    }
  }

  /// Verifica si el servicio está corriendo
  Future<bool> isServiceRunning() async {
    return _service.isRunning();
  }

  /// Proporciona acceso al servicio para listeners externos
  FlutterBackgroundService get service => _service;

  /// Muestra una notificación de éxito desde el UI
  Future<void> showSuccessNotification(String message) async {
    await _showNotification('✅ SMS Enviado', message);
  }

  /// Muestra una notificación de error desde el UI
  Future<void> showErrorNotification(String message) async {
    await _showNotification('❌ Error al Enviar SMS', message);
  }

  /// Configura listeners para recibir actualizaciones del servicio
  void _setupListeners() {
    _statusSubscription = _service.on('update').listen((event) {
      if (event != null) {
        print('📊 Estado del servicio: $event');
        // Aquí puedes actualizar el UI si es necesario
      }
    });

    // Escuchar solicitudes de envío de SMS desde el servicio de background
    _smsRequestSubscription = _service.on('sendSmsRequest').listen((
      event,
    ) async {
      if (event != null) {
        print('📨 Solicitud de SMS recibida desde background: $event');
        final phoneNumber = event['phoneNumber'] as String?;
        final message = event['message'] as String?;
        final simSlot = event['simSlot'] as int? ?? 0;

        if (phoneNumber != null && message != null) {
          try {
            // Enviar el SMS desde el contexto del UI (con Activity disponible)
            final sent = await SmsService.sendSms(
              phoneNumber: phoneNumber,
              message: message,
              simSlot: simSlot,
            );

            if (sent) {
              print(
                '✅ SMS enviado exitosamente desde primer plano por solicitud de background',
              );
              await _showNotification(
                '✅ SMS Enviado',
                'SMS Enviado a $phoneNumber',
              );

              // Notificar éxito con los datos del mensaje
              _service.invoke('smsSentSuccess', {
                'phoneNumber': phoneNumber,
                'message': message,
                'simSlot': simSlot,
              });
            } else {
              print('❌ Error al enviar SMS solicitado por background');
              await _showNotification(
                '❌ Error al Enviar SMS',
                'No se pudo enviar el mensaje a $phoneNumber',
              );

              // Notificar fallo
              _service.invoke('smsSentFailed', {
                'phoneNumber': phoneNumber,
                'message': message,
              });
            }
          } catch (e) {
            print('❌ Error al procesar solicitud de SMS: $e');
            await _showNotification(
              '❌ Error al Enviar SMS',
              'Error: $e',
            );
          }
        }
      }
    });

    _smsStatusSubscription = _service.on('smsStatus').listen((event) {
      if (event != null) {
        print('📱 Estado SMS: $event');
        final status = event['status'] as String?;
        if (status == 'sent') {
          _showNotification(
            'SMS Enviado',
            'Mensaje enviado exitosamente',
          );
        } else if (status == 'failed' || status == 'error') {
          _showNotification(
            'Error al Enviar SMS',
            'No se pudo enviar el mensaje',
          );
        }
      }
    });
  }

  /// Inicializa el sistema de notificaciones
  Future<void> _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
    );

    // Crear canal de notificaciones para Android
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'gw_sms_background',
        'Servicio SMS Background',
        description: 'Notificaciones del servicio de SMS en segundo plano',
        importance: Importance.low,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  /// Muestra una notificación
  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'gw_sms_notifications',
      'SMS Notifications',
      channelDescription: 'Notificaciones de estado de SMS',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}

/// Callback para iOS background
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}
