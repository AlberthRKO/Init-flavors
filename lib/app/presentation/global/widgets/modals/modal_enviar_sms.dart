import 'package:flutter/material.dart';
import 'package:flutter_background_messenger/flutter_background_messenger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:gw_sms/app/presentation/global/widgets/modals/modal_success.dart';
import 'package:gw_sms/app/presentation/global/widgets/text_form_custom.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sms_sender/sms_sender.dart';

class ModalEnviarSMS extends StatefulWidget {
  const ModalEnviarSMS({
    this.availableSimCards = const [],
    super.key,
  });

  final List<Map<String, dynamic>> availableSimCards;

  @override
  State<ModalEnviarSMS> createState() => _ModalEnviarSMSState();
}

class _ModalEnviarSMSState extends State<ModalEnviarSMS> {
  bool fetching = false;

  String message = '';
  String numero = '';
  String countryCode = '+591';
  TimeOfDay? hora;
  int? selectedSimSlot; // 0 = SIM 1, 1 = SIM 2

  final _messenger = FlutterBackgroundMessenger();
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();
  String _status = '';

  @override
  void initState() {
    super.initState();
    _loadOperadoraAndSim();
  }

  Future<void> _loadOperadoraAndSim() async {
    final operadora = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );

    if (operadora != null && widget.availableSimCards.isNotEmpty) {
      // Buscar la SIM que corresponde a la operadora seleccionada
      for (final sim in widget.availableSimCards) {
        final carrierName =
            (sim['carrierName'] as String?)?.toLowerCase() ?? '';
        final displayName =
            (sim['displayName'] as String?)?.toLowerCase() ?? '';

        // Detectar si es la operadora seleccionada
        if (_detectOperador(carrierName, displayName) == operadora) {
          final slotIndex = sim['slotIndex'] as int?;
          if (slotIndex != null && mounted) {
            setState(() {
              selectedSimSlot = slotIndex;
            });
          }
          break;
        }
      }
    }

    // Si no se encontró la SIM específica, usar 0 por defecto
    if (selectedSimSlot == null) {
      if (mounted) {
        setState(() {
          selectedSimSlot = 0;
        });
      }
    }
  }

  String _detectOperador(String carrierName, String displayName) {
    final carrier = carrierName.toLowerCase();
    final display = displayName.toLowerCase();

    if (carrier.contains('entel') || display.contains('entel')) {
      return 'entel';
    }

    if (carrier.contains('viva') ||
        carrier.contains('vivas') ||
        display.contains('viva') ||
        display.contains('vivas')) {
      return 'viva';
    }

    if (carrier.contains('tigo') || display.contains('tigo')) {
      return 'tigo';
    }

    return carrier.isNotEmpty ? carrier : 'desconocido';
  }

  Future<void> _sendSMS() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      fetching = true;
    });

    try {
      // Usar sms_sender para envío con SIM específico
      await SmsSender.sendSms(
        phoneNumber: _phoneController.text,
        message: _messageController.text,
        simSlot: selectedSimSlot ?? 0,
      );

      setState(() {
        _status = 'SMS sent successfully!';
      });

      // Limpiar campos después de enviar
      _phoneController.clear();
      _messageController.clear();
      setState(() {
        numero = '';
        message = '';
      });

      // Mostrar modal de éxito
      if (mounted) {
        showMaterialModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                Navigator.pop(context);
                Navigator.pop(context, true);
              }
            });
            return const ModalSuccessAnimation(
              messsage: 'SMS enviado correctamente',
              lottie: 'check.json',
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    } finally {
      setState(() {
        fetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    final bool darkMode = themeController.darkMode;
    final responsive = Responsive.of(context);
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: _formKey,
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
                        // Selector de SIM
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<int>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            value: selectedSimSlot,
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedSimSlot = newValue;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('SIM 1'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('SIM 2'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormCustom(
                          controller: _phoneController,
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
                          controller: _messageController,
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
                    CustomButtonBoxStyle(
                      title: 'Enviar SMS',
                      funcion: _sendSMS,
                      color: violet,
                      iconActive: true,
                      icon: 'paper.svg',
                      fontSize: responsive.heightPercent(1.4),
                      sizeHeight: responsive.widthPercent(10),
                      sizeWidth: responsive.widthPercent(100),
                      isLoading: fetching,
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

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
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
