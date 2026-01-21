import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gw_sms/app/presentation/global/controllers/theme_controller.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class CustomButtonBox extends StatelessWidget {
  const CustomButtonBox({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: primary.withOpacity(0.7),
        color: primary,
        borderRadius: BorderRadius.circular(17.5),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.8),
            spreadRadius: 0.0,
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: textWhite,
        ),
      ),
    );
  }
}

class CustomButtonBoxDelete extends StatelessWidget {
  const CustomButtonBoxDelete({
    super.key,
    required this.title,
    this.typeCancel = true,
  });

  final String title;
  final bool typeCancel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .3,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: typeCancel ? textWhite : deleteColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10.0),
        border: typeCancel
            ? Border.all(color: deleteColor.withOpacity(.7), width: 1)
            : null,
        boxShadow: [
          typeCancel
              ? const BoxShadow()
              : BoxShadow(
                  color: deleteColor.withOpacity(0.5),
                  spreadRadius: 0.0,
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: typeCancel ? deleteColor : textWhite,
        ),
      ),
    );
  }
}

class CustomButtonBoxCrud extends StatelessWidget {
  const CustomButtonBoxCrud({
    super.key,
    required this.title,
    this.color = textWhite,
    this.typeCancel = true,
    this.titleColor = textWhite,
    this.option = false,
    this.sizeWidth = 0,
    this.icon = "eye.svg",
    this.iconActive = false,
  });

  final String title;
  final Color color;
  final bool typeCancel;
  final Color titleColor;
  final bool option;
  final double sizeWidth;
  final bool iconActive;
  final String icon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: sizeWidth == 0 ? size.width * .4 : sizeWidth,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: typeCancel ? textWhite : color.withOpacity(1),
        borderRadius: BorderRadius.circular(10.0),
        border: typeCancel
            ? Border.all(color: deleteColor.withOpacity(.7), width: 1)
            : option
            ? Border.all(color: titleColor.withOpacity(.7), width: 1)
            : null,
        boxShadow: [
          typeCancel
              ? const BoxShadow()
              : BoxShadow(
                  color: color.withOpacity(0.5),
                  spreadRadius: 0.0,
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconActive == false
              ? Container()
              : SvgPicture.asset(
                  '$assetImgIcon$icon',
                  color: textWhite,
                  width: 18.0,
                ),
          iconActive == false
              ? Container()
              : const SizedBox(
                  width: 10,
                ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: typeCancel ? deleteColor : titleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonBoxStyle extends StatelessWidget {
  const CustomButtonBoxStyle({
    super.key,
    required this.title,
    this.color = primary,
    this.typeCancel = true,
    this.titleColor = textWhite,
    this.option = false,
    this.sizeWidth = 0,
    this.sizeHeight = 40,
    this.icon = "eye.svg",
    this.iconColor = textWhite,
    this.iconActive = false,
    this.funcion,
    this.fontSize,
    this.cancel = false,
    this.fontWeight = FontWeight.w600,
    this.isBorder = false,
    this.colorBorder = primary,
    this.isLoading = false,
    this.reverse = false,
    this.isShadowCustom = false,
    this.isShadow = false,
  });
  final bool reverse;
  final bool isBorder;
  final String title;
  final Color color;
  final bool typeCancel;
  final Color titleColor;
  final bool option;
  final double? fontSize;
  final double sizeWidth;
  final double sizeHeight;
  final bool iconActive;
  final String icon;
  final Color iconColor;
  final Color colorBorder;
  final bool cancel;
  final FontWeight fontWeight;
  final void Function()? funcion;
  final bool isLoading;
  final bool isShadowCustom;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final ThemeController themeController = context.watch();
    bool darkMode = themeController.darkMode;
    return InkWell(
      onTap: funcion,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: sizeWidth == 0 ? responsive.width * .4 : sizeWidth,
        height: sizeHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cancel ? Theme.of(context).cardColor : color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: cancel
                ? 1
                : isBorder
                ? 1
                : 0,
            color: cancel
                ? deleteColor
                : isBorder
                ? colorBorder
                : color,
          ),
          boxShadow: isShadow
              ? null
              : isShadowCustom
              ? [
                  BoxShadow(
                    color: darkMode
                        ? Theme.of(context).primaryColor.withOpacity(0.15)
                        : Theme.of(context).primaryColor.withOpacity(0.25),
                    blurRadius: 15.0,
                    offset: const Offset(0, 7),
                  ),
                ]
              : [
                  BoxShadow(
                    color: cancel
                        ? deleteColor.withOpacity(0.1)
                        : color.withOpacity(0.5),
                    spreadRadius: 0.0,
                    blurRadius: 6.0,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconActive == false
                ? Container()
                : isLoading
                ? CircularProgressIndicator(
                    color: titleColor,
                    strokeWidth: 2.0,
                    strokeAlign: -7,
                  ) // Muestra el loader
                : SvgPicture.asset(
                    '$assetImgIcon$icon',
                    color: cancel ? deleteColor : titleColor,
                    width: fontSize == null
                        ? responsive.heightPercent(2)
                        : fontSize! + 2,
                  ),
            iconActive == false
                ? Container()
                : const SizedBox(
                    width: 10,
                  ),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize ?? responsive.heightPercent(1.7),
                fontWeight: fontWeight,
                color: cancel ? deleteColor : titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
