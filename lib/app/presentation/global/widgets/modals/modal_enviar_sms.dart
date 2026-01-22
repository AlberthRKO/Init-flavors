import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gw_sms/app/presentation/global/controllers/theme_controller.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/theme/padding.dart';
import 'package:gw_sms/app/presentation/global/utils/complemento.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/circle_button.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';
import 'package:gw_sms/app/presentation/global/widgets/text_form_custom.dart';
import 'package:provider/provider.dart';

class ModalEnviarSMS extends StatefulWidget {
  const ModalEnviarSMS({
    super.key,
  });

  @override
  State<ModalEnviarSMS> createState() => _ModalEnviarSMSState();
}

class _ModalEnviarSMSState extends State<ModalEnviarSMS> {
  bool fetching = false;

  String message = '';
  String numero = '';
  String countryCode = '+591';
  TimeOfDay? hora;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    final bool darkMode = themeController.darkMode;
    final responsive = Responsive.of(context);
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      child: Builder(
        builder: (context) {
          return AbsorbPointer(
            absorbing: fetching,
            child: Container(
              padding: const EdgeInsets.all(appPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHeading(
                          title: 'Enviar SMS',
                          subTitle:
                              'Envia mensaje al numero de contacto registrado',
                          fonsizeTitle: responsive.heightPercent(2.2),
                          fonsizesubTitle: responsive.heightPercent(1.5),
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                        CircleButton(
                          callback: () {
                            context.pop();
                          },
                          width: responsive.widthPercent(8),
                          height: responsive.widthPercent(8),
                          icon: SvgPicture.asset(
                            '${assetImgIcon}close.svg',
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color,
                            height: responsive.heightPercent(2.3),
                          ),
                          color: Theme.of(context).hintColor,
                          background: Colors.transparent,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormCustom(
                          onChanged: (text) {
                            setState(() {
                              numero = text;
                            });
                          },
                          prefixIcon: 'phone.svg',
                          iconColor: Theme.of(context).primaryColor,
                          labelText: 'Número',
                          isNumber: true,
                          isPhoneField: true,
                          onCountryChanged: (country) {
                            setState(() {
                              countryCode = country.dialCode;
                            });
                            print(
                              'País seleccionado: ${country.name} ${country.dialCode}',
                            );
                          },
                          validator: (text) {
                            text = text?.trim() ?? '';
                            if (text.isEmpty) {
                              return 'Número vacío';
                            }
                            if (text.length < 8) {
                              return 'El número debe tener al menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormCustom(
                          onChanged: (text) {
                            setState(() {
                              message = text;
                            });
                          },
                          prefixIcon: 'contrato.svg',
                          iconColor: Theme.of(context).primaryColor,
                          labelText: 'Mensaje',
                          maxLine: 3,
                          validator: (text) {
                            text = text?.trim() ?? '';
                            if (text.isEmpty) {
                              return 'Mensaje vacío';
                            }
                            if (text.length < 10) {
                              return 'El mensaje debe tener menos de 10 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSpacer,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButtonBoxStyle(
                          title: 'Enviar SMS',
                          funcion: () {
                            final isValid = Form.of(context).validate();
                            if (isValid) {}
                          },
                          color: violet,
                          iconActive: true,
                          icon: 'paper.svg',
                          fontSize: responsive.heightPercent(1.4),
                          sizeHeight: responsive.widthPercent(10),
                          sizeWidth: responsive.widthPercent(35),
                          isLoading: fetching,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSpacer,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /* Future<void> _submit(
    BuildContext context,
    PermisoRepository repository,
  ) async {
    // listen true solo se usa en la vista con build o calllback de builder
    setState(() {
      fetching = true;
    });

    final result = await repository.justificarOmision(
        widget.omision.id ?? 0, "$horaSelection:00", message);

    // Condicion si no se renderizo la vista

    result.when(
      left: (failure) {
        // print(failure.toString());
        showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
            return ModalError(
              error: "Error: ${failure.message}",
            );
          },
        );
        setState(() {
          fetching = false;
        });
      },
      right: (response) async {
        showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            });
            return ModalSuccessAnimation(
              messsage: "Justificación registrada",
              lottie: "check.json",
            );
          },
        );
        setState(() {
          fetching = false;
        });
      },
    );
  } */
}
