// ignore_for_file: inference_failure_on_function_invocation, discarded_futures

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/data/services/background/background_service_helper.dart';
import 'package:gw_sms/app/data/services/utils/local_providers.dart';
import 'package:gw_sms/app/domain/either/either.dart';
import 'package:gw_sms/app/domain/models/error/error_model.dart';
import 'package:gw_sms/app/domain/models/message/message_model.dart';
import 'package:gw_sms/app/domain/models/user/user_model.dart';
import 'package:gw_sms/app/domain/repositories/ms_sms_repository.dart';
import 'package:gw_sms/app/domain/services/ussd_command_service.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/funciones.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_appbar.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_enviar_sms.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_error.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_seleccion_operadora.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_ussd_response.dart';
import 'package:gw_sms/app/presentation/global/widgets/navigation_buttons.dart';
import 'package:gw_sms/app/presentation/global/widgets/text_form_custom.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ussd_launcher/ussd_launcher.dart';

class SmsChat {
  SmsChat({
    required this.phoneNumber,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isTyping = false,
  });
  final String phoneNumber;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isTyping;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  late bool _showBottomBar;
  final _secureStorage = const FlutterSecureStorage();
  bool _hasCheckedOperadora = false;
  String _deviceInfo = 'Cargando...';
  String _operadoraSeleccionada = '';
  bool _isWaitingForAccessibility = false;
  bool _hasRequestedPhonePermission = false;
  List<Map<String, dynamic>> _availableSimCards = [];

  // Servicio de background (siempre activo)
  final _backgroundService = BackgroundServiceHelper();
  bool _isWebSocketConnected = false;
  bool _isServiceRunning = false;
  StreamSubscription<dynamic>? _backgroundSmsSuccessSubscription;
  StreamSubscription<dynamic>? _backgroundSmsFailedSubscription;
  StreamSubscription<dynamic>? _newMessageSubscription;
  StreamSubscription<dynamic>? _serviceStatusSubscription;
  StreamSubscription<dynamic>? _messageStatusUpdateSubscription;

  MsSmsRepository get _smsRespository => context.read();
  bool _hasMore = true;
  int page = 2;
  bool isLoadingChat = false;
  final List<MessageModel> listMensajes = [];
  String? search;

  @override
  void initState() {
    super.initState();
    loadMessages(1, search);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !isLoadingChat &&
          _hasMore) {
        loadMessages(page++, search);
      }
    });
    WidgetsBinding.instance.addObserver(this);
    _loadInitialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
    // Inicializar servicio de background (siempre activo)
    _initializeBackgroundService();
    _setupBackgroundListeners();
  }

  // ignore: strict_raw_type
  Future loadMessages(int paginate, String? search) async {
    if (isLoadingChat) return;
    setState(() {
      isLoadingChat = true;
    });

    final Either<ErrorModel, List<MessageModel>> result = await _smsRespository
        .getMensajes(paginate, 10, search);
    result.when(
      left: (failure) {
        setState(() {
          isLoadingChat = false;
        });
        showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
            return ModalError(
              error: 'No se pudo obtener los mensajes: ${failure.message}',
            );
          },
        );
      },
      right: (response) {
        setState(() {
          isLoadingChat = false;
          if (response.isEmpty) {
            _hasMore = false;
          } else {
            if (response.length < 10) {
              // Cambiado a menor que el tamaño de la página
              _hasMore = false;
            }
            listMensajes.addAll(response);
          }
        });
      },
    );
  }

  /// Configura listeners para eventos del servicio de background
  void _setupBackgroundListeners() {
    // Escuchar cuando llega un nuevo mensaje desde el background
    _newMessageSubscription = _backgroundService.service.on('newMessage').listen((
      event,
    ) {
      if (event != null && mounted) {
        final eventData = event as Map<String, dynamic>?;
        if (eventData == null) return;

        // Extraer el mensaje del evento (viene como {message: {...}})
        final messageData = eventData['message'] as Map<String, dynamic>?;
        if (messageData == null) return;

        final newMessage = MessageModel.fromJson(messageData);

        setState(() {
          // Si el mensaje tiene datos, buscar el mensaje original y actualizarlo
          if (newMessage != null) {
            // Buscar el mensaje original por ID y actualizarlo
            final int index = listMensajes.indexWhere(
              (msg) => msg.id == newMessage.id,
            );
            if (index != -1) {
              // Actualizar el mensaje existente
              listMensajes[index] = newMessage;
              print(
                'Mensaje actualizado: ${newMessage.id} - Estado: ${newMessage.estado}',
              );
            } else {
              // Si no se encuentra, agregarlo como mensaje nuevo al inicio
              listMensajes.insert(0, newMessage);
              print(
                'Mensaje nuevo agregado: ${newMessage.id}',
              );
            }
          }
        });
      }
    });

    // Escuchar cuando un SMS se envía exitosamente desde background
    _backgroundSmsSuccessSubscription = _backgroundService.service
        .on('smsSentSuccess')
        .listen((event) {
          if (event != null && mounted) {
            final messageId = event['messageId'] as String?;
            final phoneNumber = event['phoneNumber'] as String?;
            final message = event['message'] as String?;

            print('✅ SMS enviado desde background: $phoneNumber - $message');

            // Buscar el mensaje en la lista y actualizar su estado a "Enviado"
            if (messageId != null) {
              setState(() {
                final index = listMensajes.indexWhere(
                  (msg) => msg.id == messageId,
                );
                if (index != -1) {
                  listMensajes[index] = listMensajes[index].copyWith(
                    estado: 'Enviado',
                  );
                  print('✅ Mensaje marcado como enviado en UI');
                }
              });
            }
          }
        });

    // Escuchar cuando falla el envío desde background
    _backgroundSmsFailedSubscription = _backgroundService.service
        .on('smsSentFailed')
        .listen((event) {
          if (event != null && mounted) {
            final messageId = event['messageId'] as String?;
            final message = event['message'] as String?;

            print('❌ Fallo en envío SMS desde background: $message');

            // Buscar el mensaje y actualizar su estado a "Fallido"
            if (messageId != null) {
              setState(() {
                final index = listMensajes.indexWhere(
                  (msg) => msg.id == messageId,
                );
                if (index != -1) {
                  listMensajes[index] = listMensajes[index].copyWith(
                    estado: 'Fallido',
                  );
                  print('❌ Mensaje marcado como fallido en UI');
                }
              });
            }
          }
        });

    // Escuchar actualizaciones del estado del servicio
    _serviceStatusSubscription = _backgroundService.service.on('update').listen((
      event,
    ) {
      if (event != null && mounted) {
        final isConnected = event['isConnected'] as bool? ?? false;
        setState(() {
          _isWebSocketConnected = isConnected;
        });
        print(
          '🔄 Estado WebSocket: ${isConnected ? "Conectado" : "Desconectado"}',
        );
      }
    });

    // Escuchar actualizaciones de estado de mensajes desde WebSocket
    _messageStatusUpdateSubscription = _backgroundService.service
        .on('messageStatusUpdate')
        .listen((event) {
          if (event != null && mounted) {
            final messageId = event['messageId'] as String?;
            final estado = event['estado'] as String?;

            if (messageId != null && estado != null) {
              print('🔄 Actualizando estado de mensaje $messageId a $estado');

              // Buscar el mensaje en la lista y actualizar su estado
              final index = listMensajes.indexWhere(
                (msg) => msg.id == messageId,
              );

              if (index != -1) {
                setState(() {
                  listMensajes[index] = listMensajes[index].copyWith(
                    estado: estado,
                  );
                });
                print('✅ Estado del mensaje actualizado en UI');

                // Mostrar un SnackBar indicando el cambio de estado
                final statusText = estado == 'Enviado'
                    ? 'enviado exitosamente'
                    : estado == 'Fallido'
                    ? 'falló al enviar'
                    : 'pendiente';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mensaje $statusText'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: estado == 'Enviado'
                        ? Colors.green
                        : estado == 'Fallido'
                        ? Colors.red
                        : Colors.orange,
                  ),
                );
              } else {
                print('⚠️ Mensaje no encontrado en la lista: $messageId');
              }
            }
          }
        });
  }

  /// Inicializa el servicio de background para SMS (siempre activo)
  Future<void> _initializeBackgroundService() async {
    try {
      // Configurar el repositorio en el servicio de background
      _backgroundService.setRepository(_smsRespository);

      // Inicializar el servicio (se inicia automáticamente)
      final initialized = await _backgroundService.initializeService();
      if (!initialized) {
        print('⚠️ No se pudo inicializar el servicio de background');
        return;
      }

      // Actualizar la operadora si ya está seleccionada
      if (_operadoraSeleccionada.isNotEmpty) {
        final simSlot = _getSimSlotForOperadora(_operadoraSeleccionada);
        await _backgroundService.updateOperadora(
          _operadoraSeleccionada,
          simSlot,
        );
      }

      // Verificar si está corriendo
      final isRunning = await _backgroundService.isServiceRunning();
      setState(() {
        _isServiceRunning = isRunning;
      });

      print('✅ Servicio de background inicializado y activo');
    } catch (e) {
      print('❌ Error al inicializar servicio de background: $e');
    }
  }

  /// Inicia el servicio de WebSocket manualmente
  Future<void> _startWebSocketService() async {
    try {
      final started = await _backgroundService.startService();
      if (started) {
        setState(() {
          _isServiceRunning = true;
        });

        // Actualizar la operadora
        if (_operadoraSeleccionada.isNotEmpty) {
          final simSlot = _getSimSlotForOperadora(_operadoraSeleccionada);
          await _backgroundService.updateOperadora(
            _operadoraSeleccionada,
            simSlot,
          );
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Servicio WebSocket iniciado'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('❌ Error al iniciar servicio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Detiene el servicio de WebSocket manualmente
  Future<void> _stopWebSocketService() async {
    try {
      await _backgroundService.stopService();
      setState(() {
        _isServiceRunning = false;
        _isWebSocketConnected = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🛑 Servicio WebSocket detenido'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Error al detener servicio: $e');
    }
  }

  /// Obtiene el slot de SIM basado en la operadora seleccionada
  int _getSimSlotForOperadora(String operadora) {
    if (_availableSimCards.isEmpty) return 0;

    // Buscar la SIM que coincida con la operadora
    for (var i = 0; i < _availableSimCards.length; i++) {
      final sim = _availableSimCards[i];
      final carrierName = (sim['carrierName'] as String? ?? '').toLowerCase();
      final displayName = (sim['displayName'] as String? ?? '').toLowerCase();
      final operadoraLower = operadora.toLowerCase();

      if (carrierName.contains(operadoraLower) ||
          displayName.contains(operadoraLower)) {
        return sim['slot'] as int? ?? i;
      }
    }

    return 0; // Fallback al primer slot
  }

  Future<void> _initializeApp() async {
    // Primero solicitar permiso y cargar SIMs
    await _requestPhonePermissionOnce();
    // Luego mostrar el modal con los SIMs ya detectados
    await _checkAndShowOperadoraModal();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _newMessageSubscription?.cancel();
    _backgroundSmsSuccessSubscription?.cancel();
    _backgroundSmsFailedSubscription?.cancel();
    _serviceStatusSubscription?.cancel();
    _messageStatusUpdateSubscription?.cancel();
    // El servicio de background sigue corriendo siempre
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Cuando el usuario regresa a la app después de ir a configuración
    if (state == AppLifecycleState.resumed && _isWaitingForAccessibility) {
      _isWaitingForAccessibility = false;
      // Reintentar la consulta automáticamente
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _consultarSaldo();
        }
      });
    }
  }

  Future<void> _requestPhonePermissionOnce() async {
    if (_hasRequestedPhonePermission) return;
    _hasRequestedPhonePermission = true;

    // Solicitar permisos necesarios para USSD
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.sms,
      Permission.phone,
    ].request();

    // Verificar que al menos el permiso PHONE esté concedido
    if (statuses[Permission.phone]?.isGranted ?? false) {
      await _loadAvailableSimCards();
    } else {
      print('Permiso de teléfono denegado');
    }
  }

  Future<void> _loadAvailableSimCards() async {
    try {
      final simCards = await UssdLauncher.getSimCards();
      if (mounted) {
        setState(() {
          _availableSimCards = simCards;
          log('Tarjetas SIM disponibles: $_availableSimCards');
        });
        print('SIMs detectados: ${simCards.length}');
        for (final sim in simCards) {
          print('SIM: ${sim['displayName']} - Slot: ${sim['slotIndex']}');
        }
      }
    } catch (e) {
      print('Error al obtener tarjetas SIM: $e');
    }
  }

  Future<void> _loadInitialData() async {
    final deviceInfo = await getDeviceInfo();
    final operadora = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );

    if (mounted) {
      setState(() {
        _deviceInfo = deviceInfo;
        _operadoraSeleccionada = operadora ?? '';
      });
    }
  }

  Future<bool> _requestUssdPermissions() async {
    // Solicitar todos los permisos necesarios para USSD
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
    ].request();

    // Verificar que se otorgaron los permisos
    final phoneGranted = statuses[Permission.phone]?.isGranted ?? false;

    print('Permission.phone: $phoneGranted');

    return phoneGranted;
  }

  /// Detecta el operador basado en carrierName y displayName
  /// Busca en ambos campos ya que algunos chips pueden tener nombres compuestos
  String _detectOperador(String carrierName, String displayName) {
    final carrier = carrierName.toLowerCase();
    final display = displayName.toLowerCase();

    // Detectar ENTEL (tiene prioridad)
    if (carrier.contains('entel') || display.contains('entel')) {
      return 'entel';
    }

    // Detectar VIVA (también buscar "vivas" por variaciones)
    if (carrier.contains('viva') ||
        carrier.contains('vivas') ||
        display.contains('viva') ||
        display.contains('vivas')) {
      return 'viva';
    }

    // Detectar TIGO
    if (carrier.contains('tigo') || display.contains('tigo')) {
      return 'tigo';
    }

    // Si no coincide con ninguno, retornar el carrier name o desconocido
    return carrier.isNotEmpty ? carrier : 'desconocido';
  }

  Future<void> _checkAndShowOperadoraModal() async {
    if (_hasCheckedOperadora) return;
    _hasCheckedOperadora = true;

    final operadoraSeleccionada = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );

    if (operadoraSeleccionada == null && mounted) {
      // Si solo hay 1 SIM, autoseleccionar sin mostrar modal
      if (_availableSimCards.length == 1) {
        final sim = _availableSimCards.first;
        final carrierName = (sim['carrierName'] as String?) ?? '';
        final displayName = (sim['displayName'] as String?) ?? '';

        // Detectar la operadora usando el método helper
        final operadoraName = _detectOperador(carrierName, displayName);

        await _secureStorage.write(
          key: 'operadora_seleccionada',
          value: operadoraName,
        );

        setState(() {
          _operadoraSeleccionada = operadoraName;
        });
      } else {
        // Si hay 0 o múltiples SIMs, mostrar modal
        await _showOperadoraModal();
      }
    }
  }

  Future<bool> _checkAccessibility() async {
    // Verificar si la accesibilidad está habilitada
    final isAccessibilityEnabled = await UssdLauncher.isAccessibilityEnabled();

    if (!isAccessibilityEnabled && mounted) {
      // Mostrar el diálogo con pasos
      final shouldEnable = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Accesibilidad requerida'),
          content: const Text(
            'El servicio de accesibilidad no está habilitado.\n\n'
            'Pasos:\n'
            '1. Busca "GW SMS" en la lista\n'
            '2. Activa el interruptor\n'
            '3. Acepta el permiso\n'
            '4. Regresa a la app',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ir a configuración'),
            ),
          ],
        ),
      );

      if (shouldEnable ?? false) {
        _isWaitingForAccessibility = true;
        await UssdLauncher.openAccessibilitySettings();
        return false;
      }
      return false;
    }

    return true; // Accesibilidad está habilitada
  }

  Future<void> _showOperadoraModal() async {
    final result = await showMaterialModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ModalSeleccionOperadora(
          availableSimCards: _availableSimCards,
        );
      },
    );

    if ((result ?? false) && mounted) {
      // Recargar la operadora seleccionada
      final operadora = await _secureStorage.read(
        key: 'operadora_seleccionada',
      );
      setState(() {
        _operadoraSeleccionada = operadora ?? '';
      });

      // Actualizar la operadora en el servicio de background (siempre activo)
      if (_operadoraSeleccionada.isNotEmpty) {
        final simSlot = _getSimSlotForOperadora(_operadoraSeleccionada);
        await _backgroundService.updateOperadora(
          _operadoraSeleccionada,
          simSlot,
        );
        print(
          '🔄 Operadora actualizada en servicio: $_operadoraSeleccionada (SIM $simSlot)',
        );
      }
    }
  }

  String _getUssdCodeForSaldo() {
    try {
      final commands = UssdCommandService.getCategoryCommands(
        _operadoraSeleccionada,
        'saldo',
      );
      if (commands.isNotEmpty) {
        // Retorna el primer comando de saldo (consulta básica)
        return commands.first.code;
      }
    } catch (e) {
      print('Error obteniendo comando de saldo: $e');
    }
    // Fallback si no está configurado
    return '*105#';
  }

  Future<void> _comprarPaqueteDirecto(String ussdCode) async {
    if (_operadoraSeleccionada.isEmpty) {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return const ModalError(
            error: 'Por favor, selecciona una operadora primero',
          );
        },
      );
      return;
    }

    // Solicitar permisos USSD
    final hasPermissions = await _requestUssdPermissions();
    if (!hasPermissions) {
      if (mounted) {
        await showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const ModalError(
              error: 'Por favor, selecciona una operadora primero',
              funcion: openAppSettings,
              isAction: true,
              titleAction: 'Configuración',
            );
          },
        );
      }
      return;
    }

    // Verificar accesibilidad
    final hasAccess = await _checkAccessibility();
    if (!hasAccess) {
      return;
    }

    // Ejecutar USSD
    try {
      // Usar las SIMs ya detectadas
      final simCards = _availableSimCards;

      if (simCards.isEmpty) {
        if (mounted) {
          await showMaterialModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
              return const ModalError(
                error: 'No hay tarjetas SIM disponibles',
              );
            },
          );
        }
        return;
      }

      // Buscar la SIM que corresponde a la operadora seleccionada
      Map<String, dynamic>? selectedSim;
      for (final sim in simCards) {
        final carrierName = (sim['carrierName'] as String?) ?? '';
        final displayName = (sim['displayName'] as String?) ?? '';

        // Usar el método helper para detectar operador
        if (_detectOperador(carrierName, displayName) ==
            _operadoraSeleccionada) {
          selectedSim = sim;
          break;
        }
      }

      // Si no se encontró la SIM específica, usar la primera
      selectedSim ??= simCards.first;

      // Mostrar modal de carga
      if (mounted) {
        showMaterialModalBottomSheet<void>(
          context: context,
          isDismissible: false,
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const ModalUssdResponse(
              response: '',
              isLoading: true,
            );
          },
        );
      }

      // Ejecutar el código USSD con la SIM seleccionada
      final subscriptionId = selectedSim['subscriptionId'] as int?;

      print(
        'Ejecutando USSD $ussdCode con SIM: ${selectedSim['displayName']} (subscriptionId: $subscriptionId)',
      );

      final response = await UssdLauncher.sendUssdRequest(
        ussdCode: ussdCode,
        subscriptionId: subscriptionId ?? -1,
      );

      // Cerrar modal de carga
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Mostrar respuesta
      if (mounted) {
        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: response ?? 'Operación completada',
            );
          },
        );
      }
    } on PlatformException catch (e) {
      // Cerrar modal de carga si está abierto
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (mounted) {
        // Manejar errores
        String errorMessage = 'Error al comprar paquete';
        if (e.code == 'PERMISSION_DENIED') {
          errorMessage = 'Permisos denegados';
        } else if (e.code == 'USSD_FAILED') {
          errorMessage = 'La compra falló';
        } else if (e.code == 'ACCESSIBILITY_NOT_ENABLED') {
          errorMessage =
              'Servicio de accesibilidad no habilitado correctamente';
        } else {
          errorMessage = e.message ?? 'Error desconocido';
        }

        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: errorMessage,
            );
          },
        );
      }
    } catch (e) {
      // Cerrar modal de carga si está abierto
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (mounted) {
        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: 'Error desconocido: $e',
            );
          },
        );
      }
    }
  }

  Future<void> _consultarSaldo() async {
    if (_operadoraSeleccionada.isEmpty) {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return const ModalError(
            error: 'Por favor, selecciona una operadora primero',
          );
        },
      );
      return;
    }

    // Solicitar permisos USSD
    final hasPermissions = await _requestUssdPermissions();
    if (!hasPermissions) {
      if (mounted) {
        await showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const ModalError(
              error:
                  'Se requieren los permisos de teléfono para consultar saldo',
              funcion: openAppSettings,
              isAction: true,
              titleAction: 'Configuración',
            );
          },
        );
      }
      return;
    }

    // Verificar accesibilidad
    final hasAccess = await _checkAccessibility();
    if (!hasAccess) {
      return;
    }

    // Ejecutar USSD
    try {
      // Usar las SIMs ya detectadas
      final simCards = _availableSimCards;

      if (simCards.isEmpty) {
        if (mounted) {
          await showMaterialModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
              return const ModalError(
                error: 'No se encontraron tarjetas SIM',
              );
            },
          );
        }
        return;
      }

      // Buscar la SIM que corresponde a la operadora seleccionada
      Map<String, dynamic>? selectedSim;
      for (final sim in simCards) {
        final carrierName = (sim['carrierName'] as String?) ?? '';
        final displayName = (sim['displayName'] as String?) ?? '';

        if (_detectOperador(carrierName, displayName) ==
            _operadoraSeleccionada) {
          selectedSim = sim;
          break;
        }
      }

      // Si no se encontró la SIM específica, usar la primera
      selectedSim ??= simCards.first;

      // Mostrar modal de carga
      if (mounted) {
        showMaterialModalBottomSheet<void>(
          context: context,
          isDismissible: false,
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const ModalUssdResponse(
              response: '',
              isLoading: true,
            );
          },
        );
      }

      // Ejecutar el código USSD con la SIM seleccionada
      final ussdCode = _getUssdCodeForSaldo();
      final subscriptionId = selectedSim['subscriptionId'] as int?;

      print(
        'Ejecutando USSD $ussdCode con SIM: ${selectedSim['displayName']} (subscriptionId: $subscriptionId)',
      );

      final response = await UssdLauncher.sendUssdRequest(
        ussdCode: ussdCode,
        subscriptionId: subscriptionId ?? -1,
      );

      // Cerrar modal de carga
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Mostrar respuesta
      if (mounted) {
        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: response ?? 'No se recibió respuesta',
            );
          },
        );
      }
    } on PlatformException catch (e) {
      // Cerrar modal de carga si está abierto
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (mounted) {
        // Manejar errores
        String errorMessage = 'Error al consultar saldo';
        if (e.code == 'PERMISSION_DENIED') {
          errorMessage = 'Permisos denegados';
        } else if (e.code == 'USSD_FAILED') {
          errorMessage = 'La consulta USSD falló';
        } else if (e.code == 'ACCESSIBILITY_NOT_ENABLED') {
          errorMessage =
              'Servicio de accesibilidad no habilitado correctamente';
        } else {
          errorMessage = e.message ?? 'Error desconocido';
        }

        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: errorMessage,
            );
          },
        );
      }
    } catch (e) {
      // Cerrar modal de carga si está abierto
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (mounted) {
        await showMaterialModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalUssdResponse(
              response: 'Error inesperado: $e',
            );
          },
        );
      }
    }
  }

  void _showBottombarScroll(BuildContext context) {
    final bottomBarState = Provider.of<BottomBarStateOptionsActividad>(
      context,
      listen: false,
    );
    _showBottomBar = bottomBarState.showBottomBar;

    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        _showBottomBar) {
      bottomBarState.showBottomBar = false;
    } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !_showBottomBar) {
      bottomBarState.showBottomBar = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final bottomBarState = Provider.of<BottomBarStateOptionsActividad>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      /* appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          user: UserModel(
            nombreCompleto: _deviceInfo,
          ),
          operadora: _operadoraSeleccionada,
          onConsultar: _consultarSaldo,
          onComprarPaquete: _comprarPaqueteDirecto,
          // Solo permitir cambiar línea si hay más de 1 SIM
          onChange: _availableSimCards.length > 1 ? _showOperadoraModal : null,
        ),
      ), */
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              user: UserModel(
                nombreCompleto: _deviceInfo,
              ),
              operadora: _operadoraSeleccionada,
              onConsultar: _consultarSaldo,
              onComprarPaquete: _comprarPaqueteDirecto,
              // Solo permitir cambiar línea si hay más de 1 SIM
              onChange: _availableSimCards.length > 1
                  ? _showOperadoraModal
                  : null,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isWebSocketConnected
                      ? primary.withOpacity(0.1)
                      : _isServiceRunning
                      ? lunchColor.withOpacity(0.1)
                      : deleteColor.withOpacity(0.1),
                  border: Border.all(
                    color: _isWebSocketConnected
                        ? primary
                        : _isServiceRunning
                        ? lunchColor
                        : deleteColor,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      _isWebSocketConnected
                          ? '${assetImgIcon}check.svg'
                          : _isServiceRunning
                          ? '${assetImgIcon}estado.svg'
                          : '${assetImgIcon}close.svg',
                      color: _isWebSocketConnected
                          ? primary
                          : _isServiceRunning
                          ? lunchColor
                          : deleteColor,
                      width: responsive.heightPercent(2),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _isWebSocketConnected
                                      ? 'Conectado - GW SMS activo'
                                      : _isServiceRunning
                                      ? 'Conectando al servidor...'
                                      : 'Desconectado',
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.4),
                                    color: _isWebSocketConnected
                                        ? primary
                                        : _isServiceRunning
                                        ? lunchColor
                                        : deleteColor,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomButtonBoxStyle(
                      title: _isServiceRunning ? 'Detener' : 'Iniciar',
                      funcion: _isServiceRunning
                          ? _stopWebSocketService
                          : _startWebSocketService,
                      color: _isServiceRunning ? Colors.red : primary,
                      iconActive: true,
                      icon: 'paper.svg',
                      fontSize: 12,
                      sizeHeight: 30,
                      sizeWidth: 100,
                      isShadow: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                      ),
                      child: TextFieldSearch(
                        prefixIcon: 'message.svg',
                        labelText: 'Buscar mensaje',
                        iconHeight: responsive.heightPercent(2.4),
                        iconColor: Theme.of(context).primaryColor,
                        onChanged: (text) {},
                        onTapSearch: () async {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      _showBottombarScroll(context);
                      return true;
                    },
                    child: RefreshIndicator(
                      elevation: 0,
                      onRefresh: () async {
                        setState(() {
                          listMensajes.clear();
                          _hasMore = true;
                          loadMessages(1, search);
                          page = 2;
                        });
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: listMensajes.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          indent: 80,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        itemBuilder: (context, index) {
                          final chat = listMensajes[index];
                          return InkWell(
                            onTap: () {
                              // Navegar al chat individual
                              print(
                                'Abrir chat con ${chat.origen?.usuario?.ci ?? 'Número desconocido'}',
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  // Avatar con estado de entrega
                                  Container(
                                    width: responsive.widthPercent(12),
                                    height: responsive.widthPercent(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: _getGradientColors(index),
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: chat.estado == 'Pendiente'
                                          ? SvgPicture.asset(
                                              'assets/images/icons/estado.svg',
                                              width: responsive.heightPercent(
                                                2.5,
                                              ),
                                              color: Colors.white,
                                            )
                                          : chat.estado == 'Enviado'
                                          ? SvgPicture.asset(
                                              'assets/images/icons/check.svg',
                                              width: responsive.heightPercent(
                                                2.5,
                                              ),
                                              color: Colors.white,
                                            )
                                          : chat.estado == 'Fallido'
                                          ? SvgPicture.asset(
                                              'assets/images/icons/close.svg',
                                              width: responsive.heightPercent(
                                                2.5,
                                              ),
                                              color: Colors.white,
                                            )
                                          : SvgPicture.asset(
                                              'assets/images/icons/user_icon.svg',
                                              width: responsive.heightPercent(
                                                3,
                                              ),
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Contenido del mensaje
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                chat.destino?.numero ??
                                                    'Número desconocido',
                                                style: TextStyle(
                                                  fontSize: responsive
                                                      .heightPercent(1.6),
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(
                                                    context,
                                                  ).textTheme.bodyLarge!.color,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              chat.createdAt != null
                                                  ? TimeOfDay.fromDateTime(
                                                      DateTime.parse(
                                                        chat.createdAt!,
                                                      ),
                                                    ).format(context)
                                                  : '',
                                              style: TextStyle(
                                                fontSize: responsive
                                                    .heightPercent(
                                                      1.4,
                                                    ),
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                chat.destino?.mensaje ?? '',
                                                style: TextStyle(
                                                  fontSize: responsive
                                                      .heightPercent(1.4),
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            /* if (chat.unreadCount > 0) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  chat.unreadCount > 9
                                                      ? '9+'
                                                      : chat.unreadCount
                                                            .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ], */
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  CustomFloatingButton(
                    showBar: bottomBarState.showBottomBar,
                    onGuardar: () async {
                      await showMaterialModalBottomSheet<bool>(
                        context: context,
                        isDismissible: false,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return ModalEnviarSMS(
                            availableSimCards: _availableSimCards,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientColors(int index) {
    final baseColors = [
      const Color(0xFF667eea),
      const Color(0xFFf093fb),
      const Color(0xFF4facfe),
      const Color(0xFF43e97b),
      const Color(0xFFfa709a),
      const Color(0xFF30cfd0),
    ];
    final baseColor = baseColors[index % baseColors.length];
    // Crear un gradiente sutil del mismo color (versión más oscura a más clara)
    return [
      baseColor,
      Color.lerp(baseColor, Colors.white, 0.3)!,
    ];
  }
}
