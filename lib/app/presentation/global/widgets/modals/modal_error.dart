import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/theme/padding.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';

class ModalError extends StatelessWidget {
  const ModalError({
    required this.error,
    super.key,
    this.height,
    this.funcion,
    this.isAction = false,
    this.titleAction = 'Confirmar',
  });
  final String error;
  final double? height;
  final bool? isAction;
  final void Function()? funcion;
  final String titleAction;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  '${assetImgIcon}close.svg',
                  color: deleteColor,
                  width: responsive.heightPercent(4),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    // "An error occurred: $error.",
                    error,
                    style: TextStyle(
                      fontSize: responsive.heightPercent(1.3),
                      color: deleteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (isAction ?? false)
              CustomButtonBoxStyle(
                title: titleAction,
                funcion: funcion,
                color: violet,
                iconActive: true,
                icon: 'paper.svg',
                fontSize: responsive.heightPercent(1.4),
                sizeHeight: responsive.widthPercent(10),
                sizeWidth: responsive.widthPercent(100),
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
