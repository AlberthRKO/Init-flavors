// ignore_for_file: inference_failure_on_function_invocation

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/domain/models/user/user_model.dart';
import 'package:gw_sms/app/domain/services/ussd_command_service.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/circle_button.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_avatar.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_error.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({
    required this.user,
    super.key,
    this.isCurved = false,
    this.canFuncionario = false,
    this.canAbogado = false,
    this.canCiudadano = false,
    this.onConsultar,
    this.onComprar,
    this.onChange,
    this.isSearch = false,
    this.countNoti = 0,
    this.operadora,
    this.onComprarPaquete,
  });

  final bool isCurved;
  final UserModel user;
  final bool canFuncionario;
  final bool canAbogado;
  final bool canCiudadano;
  final bool isSearch;
  final void Function()? onConsultar;
  final void Function()? onComprar;
  final void Function(String)? onComprarPaquete;
  final void Function()? onChange;
  final String? operadora;

  final int countNoti;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  final _dropdownKey = GlobalKey<DropdownButton2State<dynamic>>();

  Future<void> _showPackagesDropdown(BuildContext context) async {
    final responsive = Responsive.of(context);

    // Obtener operador
    final operador = widget.operadora ?? '';
    if (operador.isEmpty) {
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

    // Validar si el operador está soportado
    if (!UssdCommandService.isOperadorSoportado(operador)) {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return ModalError(
            error:
                'Operador "$operador" no tiene paquetes configurados.\n'
                'Operadores disponibles: ${UssdCommandService.getOperadoresDisponibles().join(", ")}',
          );
        },
      );
      return;
    }

    // Obtener comandos de paquetes dinámicamente
    final List<Widget> packageOptions = [];
    try {
      final commands = UssdCommandService.getCategoryCommands(
        operador,
        'paquetes',
      );

      if (commands.isEmpty) {
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
              error: 'No hay paquetes disponibles para este operador',
            );
          },
        );
        return;
      }

      // Construir opciones dinámicamente
      for (final command in commands) {
        packageOptions.add(
          _buildPackageOption(
            context,
            command.title,
            command.code,
            responsive,
          ),
        );
      }
    } catch (e) {
      await showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return ModalError(
            error: 'Error: $e',
          );
        },
      );
      return;
    }

    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsive.widthPercent(5),
          vertical: responsive.heightPercent(3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomHeading(
              title: 'Paquetes',
              subTitle: operador.toUpperCase(),
              fonsizeTitle: responsive.heightPercent(2.2),
              fonsizesubTitle: responsive.heightPercent(1.5),
              color: Theme.of(context).textTheme.bodyLarge!.color!,
              centro: true,
            ),
            SizedBox(height: responsive.heightPercent(2)),
            Divider(
              height: 1,
              color: Theme.of(context).dividerColor.withOpacity(0.3),
            ),
            SizedBox(height: responsive.heightPercent(1)),
            ...packageOptions,
            SizedBox(height: responsive.heightPercent(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageOption(
    BuildContext context,
    String label,
    String ussdCode,
    Responsive responsive,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        widget.onComprarPaquete?.call(ussdCode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: responsive.heightPercent(1.5),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: responsive.heightPercent(1.5),
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      height: responsive.widthPercent(45),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: responsive.widthPercent(3),
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                CustomMSAvatar(
                                  width: responsive.widthPercent(12),
                                  height: responsive.widthPercent(12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CustomHeading2(
                                    title:
                                        widget.operadora != null &&
                                            widget.operadora!.isNotEmpty
                                        ? 'Operadora: ${widget.operadora!.toUpperCase()}'
                                        : 'Sin operadora',
                                    title2: widget.user.nombreCompleto ?? '',
                                    color2: Theme.of(
                                      context,
                                    ).textTheme.labelSmall!.color!,
                                    fonsizeTitle: responsive.heightPercent(1.4),
                                    fonsizeTitle2: responsive.heightPercent(2),
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.isSearch)
                            const SizedBox(
                              width: 5,
                            ),
                          if (widget.isSearch)
                            CircleButton(
                              callback: () {},
                              width: responsive.widthPercent(10),
                              height: responsive.widthPercent(10),
                              icon: SvgPicture.asset(
                                '${assetImgIcon}search.svg',
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.color,
                                height: responsive.heightPercent(2.8),
                              ),
                              color: Theme.of(context).hintColor,
                              background: Colors.transparent,
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              key: _dropdownKey,
                              customButton: CircleButton(
                                callback: () {
                                  print('Abriendo dropdown');
                                  _dropdownKey.currentState?.callTap();
                                },
                                width: responsive.widthPercent(10),
                                height: responsive.widthPercent(10),
                                icon: SvgPicture.asset(
                                  '${assetImgIcon}ellipsisH.svg',
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.color,
                                  height: responsive.heightPercent(2.8),
                                ),
                                color: Theme.of(context).hintColor,
                                background: Colors.transparent,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'consultar',
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        '${assetImgUssd}saldo.svg',

                                        width: responsive.heightPercent(
                                          2.5,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Consulta de Saldo',
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'comprar',
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        '${assetImgUssd}paquetes.svg',
                                        width: responsive.heightPercent(
                                          2.5,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Comprar Paquetes',
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.onChange != null)
                                  DropdownMenuItem(
                                    value: 'change',
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          '${assetImgUssd}chip.svg',
                                          width: responsive.heightPercent(
                                            2.5,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Cambiar línea',
                                          style: TextStyle(
                                            fontSize: responsive.heightPercent(
                                              1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                              onChanged: (value) {
                                // Manejo de las opciones seleccionadas
                                if (value == 'consultar') {
                                  widget.onConsultar?.call();
                                } else if (value == 'comprar') {
                                  // Mostrar segundo dropdown para paquetes
                                  _showPackagesDropdown(context);
                                } else if (value == 'change') {
                                  widget.onChange?.call();
                                }
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: responsive.widthPercent(45),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(
                                        context,
                                      ).canvasColor.withOpacity(.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(14),
                                  color: Theme.of(context).cardColor,
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(
                                    6,
                                  ),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para el appbar
class Appbar extends StatelessWidget {
  const Appbar({
    required this.perfil,
    super.key,
  });

  final String perfil;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.only(top: responsive.heightPercent(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            callback: () => debugPrint('Facebook'),
            icon: FittedBox(
              fit: BoxFit.none,
              child: Image.asset(
                '${assetImgIcon}perfil.png',
                width: responsive.widthPercent(9),
              ),
            ),
            background: Colors.white,
            height: responsive.widthPercent(8.5),
            width: responsive.widthPercent(8.5),
          ),
          // le damos tamaño a este widget y con expanded hacemos q los iconos ocupen todo el tamaño y empujen el avatar a la orilla
          SizedBox(
            width: responsive.widthPercent(50),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleButton(
                        callback: () => debugPrint('Search'),
                        icon: SvgPicture.asset(
                          '${assetImgIcon}home.svg',
                          color: violet,
                          height: responsive.heightPercent(2.5),
                        ),
                        background: fondoWhite,
                        width: responsive.widthPercent(8),
                        height: responsive.widthPercent(8),
                      ),
                      Stack(
                        children: [
                          CircleButton(
                            callback: () => debugPrint('Notification'),
                            icon: SvgPicture.asset(
                              '${assetImgIcon}message.svg',
                              color: violet,
                              height: responsive.heightPercent(2.5),
                            ),
                            background: fondoWhite,
                            height: responsive.widthPercent(8),
                            width: responsive.widthPercent(8),
                          ),
                          Positioned(
                            right: 5,
                            top: 4,
                            child: Container(
                              width: responsive.heightPercent(.9),
                              height: responsive.heightPercent(.9),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffee305e),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CircleButton(
                        callback: () => debugPrint('Message'),
                        icon: SvgPicture.asset(
                          '${assetImgIcon}home.svg',
                          color: violet,
                          height: responsive.heightPercent(2.5),
                        ),
                        background: fondoWhite,
                        height: responsive.widthPercent(8),
                        width: responsive.widthPercent(8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
