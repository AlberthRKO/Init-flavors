import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/theme/padding.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class CustomCardSession extends StatelessWidget {
  const CustomCardSession({
    super.key,
    required this.image,
    this.dispositivo,
    required this.state,
    required this.aplicacion,
    required this.ip,
    required this.fechaCreacion,
    required this.fechaCaducidad,
    required this.ciudadania,
    this.sistema,
    this.porcentaje = 0,
    this.colorIcon = primary,
    this.colorState = textSucces,
    this.isActual = false,
    this.navegador,
    this.onCerrarSesion,
  });

  final String image, state, aplicacion, ip, fechaCreacion, fechaCaducidad;
  final String? sistema, dispositivo, navegador;
  final int ciudadania;
  final double porcentaje;
  final Color colorIcon;
  final Color colorState;
  final bool isActual;
  final VoidCallback? onCerrarSesion;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: responsive.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: textBlack.withOpacity(0.05),
                blurRadius: 15.0,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Container(
                      width: responsive.width * .13,
                      height: responsive.width * .13,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorIcon.withOpacity(.1),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: SvgPicture.asset(
                        assetImgIcon + image,
                        color: colorIcon,
                        width: 25,
                      ),
                    ),
                    const SizedBox(
                      width: miniSpacer,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  dispositivo ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ciudadania == 1
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorTelegram.withOpacity(
                                              .1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              100.0,
                                            ),
                                            border: Border.all(
                                              color: colorTelegram,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Text(
                                            "CD",
                                            style: TextStyle(
                                              color: colorTelegram,
                                              fontSize: responsive
                                                  .heightPercent(1.2),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  if (state != 'Otro') ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorState.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(
                                          100.0,
                                        ),
                                        border: Border.all(
                                          color: colorState,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text(
                                        state,
                                        style: TextStyle(
                                          color: colorState,
                                          fontSize: responsive.heightPercent(
                                            1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          if (sistema != "" || navegador != "")
                            SizedBox(
                              height: 4,
                            ),
                          if (sistema != "" || navegador != "")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sistema ?? "",
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.3),
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                Text(
                                  navegador ?? "",
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.3),
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Ícono en color verde
                              SvgPicture.asset(
                                "${assetImgIcon}desktop.svg",
                                color: Theme.of(
                                  context,
                                ).primaryColor, // Color verde para el ícono
                                width: responsive.heightPercent(1.6),
                              ),
                              const SizedBox(width: 5),
                              // Título y descripción
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Sistema: ", // Título en verde
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.3,
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                        ),
                                      ),
                                      TextSpan(
                                        text: aplicacion, // Descripción
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.3,
                                          ),
                                          color: Theme.of(context).hintColor,
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Ícono en color verde
                              SvgPicture.asset(
                                "${assetImgIcon}calendar.svg",
                                color: Theme.of(
                                  context,
                                ).primaryColor, // Color verde para el ícono
                                width: responsive.heightPercent(1.6),
                              ),
                              const SizedBox(width: 5),
                              // Título y descripción
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Iniciado el: ", // Título en verde
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.3,
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                        ),
                                      ),
                                      TextSpan(
                                        text: fechaCreacion, // Descripción
                                        style: TextStyle(
                                          fontSize: responsive.heightPercent(
                                            1.3,
                                          ),
                                          color: Theme.of(context).hintColor,
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                        ),
                                      ),
                                    ],
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
        ),
        if (onCerrarSesion != null)
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: onCerrarSesion,
              child: Container(
                width: responsive.heightPercent(3.5),
                height: responsive.heightPercent(3.5),
                decoration: BoxDecoration(
                  color: deleteColor.withOpacity(.9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "${assetImgIcon}logout.svg",
                    color: textWhite,
                    width: responsive.heightPercent(1.6),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
