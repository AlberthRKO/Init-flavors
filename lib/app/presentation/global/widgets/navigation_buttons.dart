import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/circle_button.dart';

const _duration = Duration(milliseconds: 400);
const double _bottomBarHide = -100;
const double _bottomBarShow = 5;

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    this.showBar = true,
    this.onGuardar,
    this.isLoadingGuardar = false,
  });

  // damos valor por defecto de true para que se visualize el navbar
  final bool showBar;
  final void Function()? onGuardar;
  final bool isLoadingGuardar;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return AnimatedPositioned(
      duration: _duration,
      // si es true mostramos el navbar y si no lo ocultamos con las posiciones
      bottom: showBar
          ? responsive.widthPercent(_bottomBarShow)
          : _bottomBarHide,
      right: responsive.widthPercent(5),
      // Contenido del navbar
      child: CircleButton(
        width: responsive.widthPercent(15),
        height: responsive.widthPercent(15),
        callback: onGuardar,
        icon: SvgPicture.asset(
          '${assetImgUssd}message.svg',
          color: Colors.white,
          height: responsive.heightPercent(3.5),
        ),
        background: primary,
        borderRadius: 20,
      ),
    );
  }

  Widget isLoadingWidget(Responsive responsive, BuildContext context) {
    return SizedBox(
      width: responsive.widthPercent(20),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
