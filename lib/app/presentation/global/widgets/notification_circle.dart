import 'package:flutter/material.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class NotificationCircle extends StatelessWidget {
  const NotificationCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.heightPercent(1.5),
      height: responsive.heightPercent(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xffee305e),
        border: Border.all(
          width: responsive.heightPercent(.15),
          color: Colors.white,
        ),
      ),
    );
  }
}
