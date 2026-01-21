import 'package:flutter/material.dart';
import 'package:gw_sms/app/presentation/global/widgets/appbar.dart';
import 'package:gw_sms/app/presentation/global/widgets/card_info.dart';

class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: getAppbar(Colors.transparent),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: CardSinInter(
            isImg: true,
            img: "noInternet.svg",
            title: "Sin conexión a Internet",
            subtitle:
                "No hay conexión a Internet, conéctese a una red Wi-Fi o datos móviles.",
          ),
        ),
      ),
    );
  }
}
