import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/data/services/utils/local_providers.dart';
import 'package:gw_sms/app/domain/models/user/user_model.dart';
import 'package:gw_sms/app/presentation/global/utils/funciones.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_appbar.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_enviar_sms.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_seleccion_operadora.dart';
import 'package:gw_sms/app/presentation/global/widgets/navigation_buttons.dart';
import 'package:gw_sms/app/presentation/global/widgets/text_form_custom.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

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

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  late bool _showBottomBar;
  final _secureStorage = const FlutterSecureStorage();
  bool _hasCheckedOperadora = false;
  String _deviceInfo = 'Cargando...';
  String _operadoraSeleccionada = '';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowOperadoraModal();
    });
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

  Future<void> _checkAndShowOperadoraModal() async {
    if (_hasCheckedOperadora) return;
    _hasCheckedOperadora = true;

    final operadoraSeleccionada = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );

    if (operadoraSeleccionada == null && mounted) {
      await _showOperadoraModal();
    }
  }

  Future<void> _showOperadoraModal() async {
    final result = await showMaterialModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const ModalSeleccionOperadora();
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
          onConsultar: () {},
          onChange: _showOperadoraModal,
          onComprar: () {},
        ),
      ),
      body: Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontSize: responsive.heightPercent(
                                              1.4,
                                            ),
                                            color: chat.unreadCount > 0
                                                ? Theme.of(context).primaryColor
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
                                            padding: const EdgeInsets.symmetric(
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
                                                  : chat.unreadCount.toString(),
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
