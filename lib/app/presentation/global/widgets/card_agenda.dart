import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/funciones.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class CardAgenda extends StatelessWidget {
  const CardAgenda({
    super.key,
    required this.title,
    required this.subtitle,
    required this.mes,
    required this.dia,
    required this.horaIni,
    required this.horaFin,
    required this.tiempo,
    required this.colorDescription,
    this.isSemana = false,
    this.isPorDias = false,
    this.funcion,
    this.diaFin,
    this.mesFin,
  });

  final String title, subtitle, mes, dia, horaIni, horaFin, tiempo;
  final Color colorDescription;
  final bool isSemana, isPorDias;
  final void Function()? funcion;
  final String? diaFin, mesFin;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
        top: 10,
      ),
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
      child: Row(
        children: [
          isSemana
              ? SizedBox(
                  width: responsive.widthPercent(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dia,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: isPorDias
                              ? responsive.heightPercent(1.5)
                              : responsive.heightPercent(2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        mes,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: responsive.heightPercent(1.1),
                        ),
                      ),
                      if (isPorDias)
                        Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color!,
                            fontSize: responsive.heightPercent(1.1),
                            height: 0.8,
                          ),
                        ),
                      if (isPorDias)
                        Text(
                          diaFin ?? "",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color!,
                            fontSize: responsive.heightPercent(1.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (isPorDias)
                        Text(
                          mesFin ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color!,
                            fontSize: responsive.heightPercent(1.1),
                          ),
                        ),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: isSemana ? 20 : 0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: responsive.heightPercent(1.6),
                              fontWeight: FontWeight.w500,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: funcion,
                      child: Container(
                        height: responsive.widthPercent(8),
                        width: responsive.widthPercent(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: SvgPicture.asset(
                          '${assetImgIcon}eye.svg',
                          color: Theme.of(context).primaryColor,
                          width: responsive.heightPercent(2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "${assetImgIcon}entidad2.svg",
                      color: colorDescription,
                      width: responsive.heightPercent(1.6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: responsive.heightPercent(1.3),
                          color: colorDescription,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Primer bloque: Ícono + Texto
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            isPorDias
                                ? "${assetImgIcon}calendar.svg"
                                : "${assetImgIcon}estado.svg",
                            color: colorDescription,
                            width: responsive.heightPercent(1.6),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  isPorDias
                                      ? formatDateWithDaySinHoraAndTimeLocal(
                                          horaIni,
                                        )
                                      : formatDateWithHourAndTimeLocal(horaIni),
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.3),
                                    color: colorDescription,
                                  ),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.3),
                                    color: colorDescription,
                                  ),
                                ),
                                Text(
                                  isPorDias
                                      ? formatDateWithDaySinHoraAndTimeLocal(
                                          horaFin,
                                        )
                                      : formatDateWithHourAndTimeLocal(horaFin),
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.3),
                                    color: colorDescription,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20), // Espaciado entre los bloques
                    // Segundo bloque: Ícono + Texto
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Alineación derecha
                      children: [
                        SvgPicture.asset(
                          isPorDias
                              ? "${assetImgIcon}calendarDay.svg"
                              : "${assetImgIcon}clock.svg",
                          color: colorDescription,
                          width: responsive.heightPercent(1.6),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          tiempo, // Fecha
                          style: TextStyle(
                            fontSize: responsive.heightPercent(1.3),
                            color: colorDescription,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
