import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gw_sms/app/domain/models/message/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Solo para Android, establece como servicio foreground
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Inicializar el servicio de SMS en background
  final smsService = BackgroundSmsService(service);
  await smsService.initialize();
  await smsService.start();
}

class BackgroundSmsService {
  BackgroundSmsService(this.service);

  final ServiceInstance service;
  IO.Socket? _socket;
  final _secureStorage = const FlutterSecureStorage();
  String? _operadoraSeleccionada;
  int _simSlot = 0;
  Timer? _keepAliveTimer;

  // Plugin de notificaciones
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Inicializar notificaciones
    await _initializeNotifications();

    // Cargar la operadora seleccionada
    _operadoraSeleccionada = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );

    // Determinar el SIM slot basado en la operadora
    if (_operadoraSeleccionada != null && _operadoraSeleccionada!.isNotEmpty) {
      // Aquí podrías implementar lógica para determinar el slot
      // Por ahora usamos slot 0 por defecto
      _simSlot = 0;
      print('📱 Operadora seleccionada: $_operadoraSeleccionada');
      print('📡 Usando SIM slot: $_simSlot');
    }

    // Configurar listeners para actualizar la operadora desde el UI
    service.on('updateOperadora').listen((event) {
      if (event != null) {
        _operadoraSeleccionada = event['operadora'] as String?;
        _simSlot = event['simSlot'] as int? ?? 0;
        print('🔄 Operadora actualizada: $_operadoraSeleccionada');
        print('🔄 SIM slot actualizado: $_simSlot');
      }
    });
  }

  Future<void> start() async {
    print('🚀 Iniciando servicio de SMS en background...');

    // Conectar al WebSocket
    await _connectWebSocket();

    // Configurar un timer para mantener el servicio vivo
    _keepAliveTimer = Timer.periodic(
      const Duration(minutes: 5),
      (timer) {
        print('💓 Servicio de background activo...');
        _sendStatusUpdate();
      },
    );
  }

  Future<void> _connectWebSocket() async {
    try {
      const chatId = '66cf26df7fc0dfd1aebeee4d';
      const ususarioId = 790;
      const token =
          // ignore: lines_longer_than_80_chars
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZnoyYldMY1Q4NGZUQm9aU0ZkbkVJSFVqUW03eWRDZFR1dDk4K3Vkd0p4OXRTY1dFZEY4VGExajQ0c0g3RWxyYWFrdWtHYnRFVzJIeUt4cEk5NnJ6QVpHZDVVYU8vRU9HdjlUVXB5VEFKTTc3S3dXMkdQUHVVN0lNbm53K1VCK3YxdDJ0aFYrWU5RTUtsVU1OR2ZuWnUvUEpJdlpOMFBLbCttc0FZMThuUks2TFlRUHpGTjUxVEk4L1JhRndZOWdnckZtWExZZWZSeTk3TXpBQStwekE4VkYwU0szamd0ZGpKUFRNTFl3ZGUrQXEyNW5EL0hSaXZqSHNLaGFvbjZmZG5FcnRIdisvQ21CQXR6TGRPS2RCZmUrMm5UWnpBbjhXMStvWEt5YTEwN3ZvKzFNZjI5ZElvV2dzSlF1bDcxOXRDdnoyN0hCUzQxOCt2TW9jcEZ2bmx6S3A5Y05JdkExdEdIMVlxdXlKOTJlQlJqZ1MvMGIyanc2a0k2dGo2Q3UwaUpCNU5uUVgvNnVpc3QyemZ5dGdRT2crYmZlTDY0VW5ZTFRITlNDQitRbFhsTVY3bWNNYzVHT2RKSGIwbUFaeElxSTdKdkxtck1lZkpGRDVkRk5CczlCRFNucnBrMndIT0ZCdlRjY1MxTFNhV09TWjdNM3ljdHQ0WFl0UDFHWGZqbzZNeXJpVGFMbzhNbGhUOW14T1BDM0JMQ1MxR2FzbHVySGRNbWp6Z3c3WE9QWmlFWG9GdG5VWWVmSWI1eTV5QWlpNnZLODYzSFVqRDh6RlQ5cVVGaEhpUC94OUwyaW8wZ0tXRHY4RHJVQmRaTkw2Ritma3ZnckVoTGxLQzFwc2tvbHd3MEYzdHltM0hSdFRlK1pVUT09IiwiaXYiOiIwaXN6WGVKM0p6K0xlczhQY0VKbGFBPT0iLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzcwMDQ1OTIyLCJleHAiOjE3NzAxMzIzMjJ9.CeoJ_LnbW0UdstmaAO1U6Z3HTgNCGIMByRUzWpKy5BQ';

      //const url = 'https://r05290mh-3515.brs.devtunnels.ms';
      const url = 'ws://ms-sms-v2.mp.gob.bo';

      _socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build(), // ← SIN headers, SIN auth, SIN queries
      );

      _socket!.onConnect((_) {
        print('✅ WebSocket conectado en background');
        _socket!.emit('joinRoom', chatId);
        _sendStatusUpdate(isConnected: true);
      });

      _socket!.on('receiveMessage', (data) async {
        print('📨 Mensaje recibido en background: $data');
        await _handleIncomingMessage(data);
      });
      // Escuchar NUEVOS mensajes (cuando se crea)
      _socket!.on('send-message', (data) async {
        print('📨 Nuevo mensaje: $data');
        //await _handleIncomingMessage(data);
      });

      // Escuchar ACTUALIZACIONES de estado
      _socket!.on('send-message-status', (data) {
        print('📊 Estado actualizado: $data');
        _handleStatusUpdate(data);
      });

      _socket!.onDisconnect((_) {
        print('❌ WebSocket desconectado en background');
        _sendStatusUpdate(isConnected: false);

        // Intentar reconectar después de 10 segundos
        Future.delayed(const Duration(seconds: 10), () {
          if (_socket != null) {
            print('🔄 Intentando reconectar WebSocket...');
            _socket!.connect();
          }
        });
      });

      _socket!.onError((error) {
        print('⚠️ Error en WebSocket: $error');
        _sendStatusUpdate(isConnected: false, error: error.toString());
      });

      _socket!.onConnectError((data) {
        print('⚠️ Error de conexión WebSocket: $data');
        _sendStatusUpdate(isConnected: false, error: data.toString());
      });

      _socket!.connect();
    } catch (e) {
      print('❌ Error al conectar WebSocket: $e');
      _sendStatusUpdate(isConnected: false, error: e.toString());
    }
  }

  Future<void> _handleIncomingMessage(dynamic data) async {
    try {
      print('🔄 Procesando mensaje recibido...');

      // Extraer el mensaje del objeto data
      final dataMap = data as Map<String, dynamic>;
      final message = MessageModel.fromJson(dataMap);

      // Obtener el CI del sender y el mensaje
      final senderCI = message.user?.ci;
      final messageText = message.message;

      // Validar CI (convertir a String si es necesario)
      if (senderCI == null) {
        print('⚠️ Mensaje sin CI del remitente');
        return;
      }

      // Convertir CI a String (puede venir como int o String del JSON)
      final ciString = senderCI;
      if (ciString.isEmpty) {
        print('⚠️ CI del remitente vacío');
        return;
      }

      if (messageText == null || messageText.isEmpty) {
        print('⚠️ Mensaje sin texto');
        return;
      }

      // Número de teléfono del mensaje
      final phoneNumber = message.phone;

      if (phoneNumber == null || phoneNumber.isEmpty) {
        print('⚠️ Mensaje sin número de teléfono');
        return;
      }

      print('📱 Preparando envío de SMS...');
      print('   Message ID: ${message.messageId}');
      print('   Destinatario CI: $ciString');
      print('   Número: $phoneNumber');
      print('   Mensaje: $messageText');
      print('   Tipo: ${message.messageType}');
      print('   SIM slot: $_simSlot');

      // Notificar al UI que llegó un nuevo mensaje (para actualizar la lista)
      service.invoke('newMessage', {
        'message': message.toJson(),
      });

      // Notificar al UI principal para que envíe el SMS
      // Ya que no podemos enviar SMS directamente desde background
      service.invoke('sendSmsRequest', {
        'messageId': message.messageId,
        'phoneNumber': phoneNumber,
        'message': messageText,
        'messageType': message.messageType,
        'simSlot': _simSlot,
        'ci': ciString,
      });

      print('✅ Solicitud de SMS enviada a primer plano');

      // No mostrar notificación aquí, se mostrará cuando se envíe realmente
      _sendSmsStatusUpdate(
        status: 'requested',
        phoneNumber: phoneNumber,
        message: messageText,
      );
    } catch (e) {
      print('❌ Error al procesar mensaje: $e');

      _sendSmsStatusUpdate(
        status: 'error',
        error: e.toString(),
      );

      // Mostrar notificación de error
      await _showNotification(
        '⚠️ Error en Servicio SMS',
        'Error al procesar mensaje',
      );
    }
  }

  void _sendStatusUpdate({bool? isConnected, String? error}) {
    service.invoke(
      'update',
      {
        'timestamp': DateTime.now().toIso8601String(),
        'isConnected': isConnected ?? false,
        'operadora': _operadoraSeleccionada,
        'simSlot': _simSlot,
        'error': error,
      },
    );
  }

  void _sendSmsStatusUpdate({
    required String status,
    String? phoneNumber,
    String? message,
    String? error,
  }) {
    service.invoke(
      'smsStatus',
      {
        'status': status,
        'timestamp': DateTime.now().toIso8601String(),
        'phoneNumber': phoneNumber,
        'message': message,
        'error': error,
      },
    );
  }

  /// Maneja las actualizaciones de estado de mensajes desde el WebSocket
  void _handleStatusUpdate(dynamic data) {
    try {
      print('🔄 Procesando actualización de estado...');

      final dataMap = data as Map<String, dynamic>;
      final messageId = dataMap['messageId'] as String?;
      final status = dataMap['status'] as int?;
      final chatId = dataMap['chatId'] as String?;

      if (messageId == null || status == null) {
        print('⚠️ Actualización de estado sin messageId o status');
        return;
      }

      print('📱 Estado actualizado:');
      print('   Message ID: $messageId');
      print('   Nuevo estado: $status');
      print('   Chat ID: $chatId');

      // Notificar al UI del cambio de estado
      service.invoke('messageStatusUpdate', {
        'messageId': messageId,
        'status': status,
        'chatId': chatId,
        'timestamp': DateTime.now().toIso8601String(),
      });

      print('✅ Notificación de estado enviada a UI');
    } catch (e) {
      print('❌ Error al procesar actualización de estado: $e');
    }
  }

  void stop() {
    print('🛑 Deteniendo servicio de SMS en background...');
    _keepAliveTimer?.cancel();
    _socket?.disconnect();
    _socket?.dispose();
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
    const channel = AndroidNotificationChannel(
      'gw_sms_notifications',
      'SMS Notifications',
      description: 'Notificaciones de estado de SMS',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
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
