import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gw_sms/app/presentation/global/controllers/theme_controller.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/theme/padding.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';
import 'package:provider/provider.dart';

class ModalOption2 extends StatelessWidget {
  const ModalOption2({
    super.key,
    required this.title,
    required this.subtitle,
    this.sancion = "",
    this.titleButton = "Confirmar",
    this.icon = "paper.svg",
    this.funcion,
    this.colorText = textSucces,
  });
  final String title, subtitle, sancion, titleButton, icon;
  final void Function()? funcion;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    bool darkMode = themeController.darkMode;
    final responsive = Responsive.of(context);
    return Form(
      child: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    '${assetImgIcon}check.svg',
                    color: textSucces,
                    width: 35.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomHeading(
                    title: title,
                    subTitle: subtitle,
                    fonsizeTitle: responsive.heightPercent(1.5),
                    fonsizesubTitle: responsive.heightPercent(1.5),
                    color: colorText,
                    centro: true,
                  ),
                  const SizedBox(
                    height: smallSpacer,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButtonBoxStyle(
                        title: "Seguir editando",
                        funcion: () {
                          context.pop(false);
                        },
                        color: darkMode
                            ? Theme.of(context).scaffoldBackgroundColor
                            : const Color(0xffD8DDE2),
                        titleColor: Theme.of(context).hintColor,
                        iconColor: Theme.of(context).hintColor,
                        iconActive: true,
                        icon: "contrato.svg",
                        fontSize: responsive.heightPercent(1.4),
                        sizeHeight: responsive.widthPercent(10),
                        sizeWidth: responsive.widthPercent(40),
                      ),
                      CustomButtonBoxStyle(
                        title: titleButton,
                        funcion: funcion,
                        color: violet,
                        titleColor: textWhite,
                        iconColor: textWhite,
                        iconActive: true,
                        icon: icon,
                        fontSize: responsive.heightPercent(1.4),
                        sizeHeight: responsive.widthPercent(10),
                        sizeWidth: responsive.widthPercent(40),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: smallSpacer,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
