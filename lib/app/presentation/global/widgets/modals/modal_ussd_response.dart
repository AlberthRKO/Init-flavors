import 'package:flutter/material.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';

class ModalUssdResponse extends StatelessWidget {
  const ModalUssdResponse({
    required this.response,
    this.isLoading = false,
    super.key,
  });

  final String response;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
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
            title: 'Respuesta USSD',
            subTitle: isLoading ? 'Consultando...' : 'Resultado de la consulta',
            fonsizeTitle: responsive.heightPercent(2.2),
            fonsizesubTitle: responsive.heightPercent(1.5),
            color: Theme.of(context).textTheme.bodyLarge!.color!,
            centro: true,
          ),
          SizedBox(height: responsive.heightPercent(3)),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(responsive.widthPercent(4)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                response,
                style: TextStyle(
                  fontSize: responsive.heightPercent(1.8),
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  height: 1.5,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          SizedBox(height: responsive.heightPercent(3)),
          if (!isLoading)
            CustomButtonBoxStyle(
              title: 'Cerrar',
              funcion: () => Navigator.of(context).pop(),
              color: violet,
              fontSize: responsive.heightPercent(1.4),
              sizeHeight: responsive.widthPercent(10),
              sizeWidth: responsive.widthPercent(100),
            ),
          SizedBox(height: responsive.heightPercent(2)),
        ],
      ),
    );
  }
}
