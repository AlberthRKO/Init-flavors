import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/theme/padding.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class ModalError extends StatelessWidget {
  final String error;
  final double? height;

  const ModalError({
    super.key,
    required this.error,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
