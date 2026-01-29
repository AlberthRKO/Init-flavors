// ignore_for_file: inference_failure_on_function_invocation

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/data/services/utils/local_providers.dart';
import 'package:gw_sms/app/domain/models/user/user_model.dart';
import 'package:gw_sms/app/domain/services/ussd_command_service.dart';
import 'package:gw_sms/app/presentation/global/utils/funciones.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_appbar.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadInitialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
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

  List<SmsChat> _getFakeChats() {
    return [
      SmsChat(
        phoneNumber: '+591 71234567',
        lastMessage: 'Hola, ¿cómo estás? Espero que todo vaya bien.',
        time: '9:24 AM',
        unreadCount: 2,
      ),
      SmsChat(
        phoneNumber: '+591 78901234',
        lastMessage: 'La reunión es mañana a las 10:00',
        time: '9:24 AM',
        isTyping: true,
      ),
      SmsChat(
        phoneNumber: '+591 65432109',
        lastMessage: 'Gracias por tu ayuda con el proyecto',
        time: '9:24 AM',
      ),
      SmsChat(
        phoneNumber: '+591 72345678',
        lastMessage: 'Te envío los documentos que necesitas',
        time: '8:45 AM',
        unreadCount: 3,
      ),
      SmsChat(
        phoneNumber: '+591 78901234',
        lastMessage: 'La reunión es mañana a las 10:00',
        time: '9:24 AM',
        isTyping: true,
      ),
      SmsChat(
        phoneNumber: '+591 65432109',
        lastMessage: 'Gracias por tu ayuda con el proyecto',
        time: '9:24 AM',
      ),
      SmsChat(
        phoneNumber: '+591 72345678',
        lastMessage: 'Te envío los documentos que necesitas',
        time: '8:45 AM',
        unreadCount: 3,
      ),
      SmsChat(
        phoneNumber: '+591 69876543',
        lastMessage: 'Confirmado para el viernes',
        time: '9:26 AM',
        unreadCount: 1,
      ),
      SmsChat(
        phoneNumber: '+591 73456789',
        lastMessage: 'Perfecto, nos vemos entonces',
        time: '9:24 AM',
      ),
      SmsChat(
        phoneNumber: '+591 61234567',
        lastMessage: 'No olvides revisar el correo que te envié',
        time: '8:30 PM',
      ),
      SmsChat(
        phoneNumber: '+591 72345678',
        lastMessage: 'Te envío los documentos que necesitas',
        time: '8:45 AM',
        unreadCount: 3,
      ),
      SmsChat(
        phoneNumber: '+591 69876543',
        lastMessage: 'Confirmado para el viernes',
        time: '9:26 AM',
        unreadCount: 1,
      ),
      SmsChat(
        phoneNumber: '+591 73456789',
        lastMessage: 'Perfecto, nos vemos entonces',
        time: '9:24 AM',
      ),
      SmsChat(
        phoneNumber: '+591 61234567',
        lastMessage: 'No olvides revisar el correo que te envié',
        time: '8:30 PM',
      ),
    ];
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
    final chats = _getFakeChats();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
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
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: chats.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        indent: 80,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return InkWell(
                          onTap: () {
                            // Navegar al chat individual
                            print('Abrir chat con ${chat.phoneNumber}');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                // Avatar con iniciales del número
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
                                    child: SvgPicture.asset(
                                      'assets/images/icons/user_icon.svg',
                                      width: responsive.heightPercent(3),
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
                                              chat.phoneNumber,
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
                                            chat.time,
                                            style: TextStyle(
                                              fontSize: responsive
                                                  .heightPercent(
                                                    1.4,
                                                  ),
                                              color: chat.unreadCount > 0
                                                  ? Theme.of(
                                                      context,
                                                    ).primaryColor
                                                  : Colors.grey,
                                              fontWeight: chat.unreadCount > 0
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              chat.lastMessage,
                                              style: TextStyle(
                                                fontSize: responsive
                                                    .heightPercent(1.4),
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (chat.unreadCount > 0) ...[
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
                                          ],
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
                  CustomFloatingButton(
                    showBar: bottomBarState.showBottomBar,
                    onGuardar: () async {
                      await showMaterialModalBottomSheet<bool>(
                        context: context,
                        isDismissible: false,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const ModalEnviarSMS();
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
