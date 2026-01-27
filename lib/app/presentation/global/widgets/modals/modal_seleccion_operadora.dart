import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gw_sms/app/presentation/global/theme/colors.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_button_box.dart';
import 'package:gw_sms/app/presentation/global/widgets/custom_heading.dart';

class ModalSeleccionOperadora extends StatefulWidget {
  const ModalSeleccionOperadora({
    this.availableSimCards = const [],
    super.key,
  });

  final List<Map<String, dynamic>> availableSimCards;

  @override
  State<ModalSeleccionOperadora> createState() =>
      _ModalSeleccionOperadoraState();
}

class _ModalSeleccionOperadoraState extends State<ModalSeleccionOperadora> {
  String? _selectedOperadora;
  final _secureStorage = const FlutterSecureStorage();

  // Mapeo de nombres de operadoras a imágenes
  final Map<String, String> _operadoraImages = {
    'entel': 'assets/images/entel.png',
    'viva': 'assets/images/viva.png',
    'tigo': 'assets/images/tigo.png',
    'default': 'assets/images/chipDefault.png',
  };

  List<Map<String, String>> _operadoras = [];

  @override
  void initState() {
    super.initState();
    _buildOperadorasList();
    _loadSelectedOperadora();
  }

  void _buildOperadorasList() {
    if (widget.availableSimCards.isEmpty) {
      // Si no hay SIMs detectados, mostrar todas las operadoras
      _operadoras = [
        {'name': 'entel', 'image': 'assets/images/entel.png'},
        {'name': 'viva', 'image': 'assets/images/viva.png'},
        {'name': 'tigo', 'image': 'assets/images/tigo.png'},
        {'name': 'default', 'image': 'assets/images/chipDefault.png'},
      ];
    } else {
      // Crear lista desde SIMs detectados
      final detectedOperadoras = <Map<String, String>>[];

      for (final sim in widget.availableSimCards) {
        final carrierName =
            (sim['carrierName'] as String?)?.toLowerCase() ?? '';
        final displayName =
            (sim['displayName'] as String?)?.toLowerCase() ?? '';

        // Detectar la operadora por el nombre
        String? operadoraName;
        String imagePath = 'assets/images/entel.png'; // Default

        if (carrierName.contains('entel') || displayName.contains('entel')) {
          operadoraName = 'entel';
          imagePath = _operadoraImages['entel']!;
        } else if (carrierName.contains('vivas') ||
            displayName.contains('viva')) {
          operadoraName = 'viva';
          imagePath = _operadoraImages['viva']!;
        } else if (carrierName.contains('tigo') ||
            displayName.contains('tigo')) {
          operadoraName = 'tigo';
          imagePath = _operadoraImages['tigo']!;
        } else {
          // Si no se reconoce, usar el nombre del carrier
          operadoraName = carrierName.isNotEmpty ? carrierName : 'desconocido';
          imagePath = _operadoraImages['default']!;
        }

        // Evitar duplicados
        if (!detectedOperadoras.any((op) => op['name'] == operadoraName)) {
          detectedOperadoras.add({
            'name': operadoraName,
            'image': imagePath,
            'displayName': sim['displayName'] as String? ?? operadoraName,
            'slotIndex': sim['slotIndex'].toString(),
          });
        }
      }

      _operadoras = detectedOperadoras.isEmpty
          ? [
              {'name': 'entel', 'image': 'assets/images/entel.png'},
              {'name': 'viva', 'image': 'assets/images/viva.png'},
              {'name': 'tigo', 'image': 'assets/images/tigo.png'},
            ]
          : detectedOperadoras;
    }
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
              title: widget.availableSimCards.isEmpty
                  ? 'Selecciona tu Operadora'
                  : 'SIMs Detectados',
              subTitle: widget.availableSimCards.isEmpty
                  ? 'Elige la línea que deseas usar'
                  : '${widget.availableSimCards.length} tarjeta${widget.availableSimCards.length > 1 ? 's' : ''} SIM encontrada${widget.availableSimCards.length > 1 ? 's' : ''}',
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
                                flex: 3,
                                child: Image.asset(
                                  operadora['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: responsive.heightPercent(0.5)),
                              // Mostrar nombre adicional si existe
                              if (operadora['displayName'] != null &&
                                  operadora['displayName'] != operadora['name'])
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: responsive.widthPercent(1),
                                  ),
                                  child: Text(
                                    operadora['displayName']!,
                                    style: TextStyle(
                                      fontSize: responsive.heightPercent(1.2),
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              if (operadora['slotIndex'] != null)
                                Text(
                                  'SIM ${int.parse(operadora['slotIndex']!) + 1}',
                                  style: TextStyle(
                                    fontSize: responsive.heightPercent(1.1),
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (isSelected) ...[
                                SizedBox(height: responsive.heightPercent(0.5)),
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: responsive.heightPercent(2.5),
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
