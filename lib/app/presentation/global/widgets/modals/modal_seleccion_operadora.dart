import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';

class ModalSeleccionOperadora extends StatefulWidget {
  const ModalSeleccionOperadora({super.key});

  @override
  State<ModalSeleccionOperadora> createState() =>
      _ModalSeleccionOperadoraState();
}

class _ModalSeleccionOperadoraState extends State<ModalSeleccionOperadora> {
  String? _selectedOperadora;
  final _secureStorage = const FlutterSecureStorage();

  final List<Map<String, String>> _operadoras = [
    {'name': 'entel', 'image': 'assets/images/entel.png'},
    {'name': 'viva', 'image': 'assets/images/viva.png'},
    {'name': 'tigo', 'image': 'assets/images/tigo.png'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedOperadora();
  }

  Future<void> _loadSelectedOperadora() async {
    final operadora = await _secureStorage.read(
      key: 'operadora_seleccionada',
    );
    if (mounted && operadora != null) {
      setState(() {
        _selectedOperadora = operadora;
      });
    }
  }

  Future<void> _selectOperadora(String operadora) async {
    await _secureStorage.write(key: 'operadora_seleccionada', value: operadora);
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return PopScope(
      canPop: false,
      child: Container(
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
              title: 'Selecciona tu Operadora',
              subTitle: 'Elige la línea que deseas usar',
              fonsizeTitle: responsive.heightPercent(2.2),
              fonsizesubTitle: responsive.heightPercent(1.5),
              color: Theme.of(context).textTheme.bodyLarge!.color!,
              centro: true,
            ),
            SizedBox(height: responsive.heightPercent(3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _operadoras.map((operadora) {
                final isSelected = _selectedOperadora == operadora['name'];
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.widthPercent(1.5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOperadora = operadora['name'];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey.withOpacity(0.3),
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        padding: EdgeInsets.all(responsive.widthPercent(3)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  operadora['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: responsive.heightPercent(1)),
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: responsive.heightPercent(3),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: responsive.heightPercent(3)),

            CustomButtonBoxStyle(
              title: 'Confirmar',
              funcion: _selectedOperadora == null
                  ? null
                  : () => _selectOperadora(_selectedOperadora!),
              color: _selectedOperadora != null
                  ? violet
                  : const Color(0xffD8DDE2),
              iconActive: true,
              icon: 'save.svg',
              fontSize: responsive.heightPercent(1.4),
              sizeHeight: responsive.widthPercent(10),
              sizeWidth: responsive.widthPercent(100),
            ),
            SizedBox(height: responsive.heightPercent(2)),
          ],
        ),
      ),
    );
  }
}
