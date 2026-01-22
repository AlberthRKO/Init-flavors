import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gw_sms/app/presentation/global/utils/responsive.dart';

class CountryCode {
  CountryCode({
    required this.name,
    required this.dialCode,
    required this.code,
    required this.flag,
  });
  final String name;
  final String dialCode;
  final String code;
  final String flag;
}

class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({
    required this.onChanged,
    super.key,
    this.selectedCountry,
  });

  final void Function(CountryCode) onChanged;
  final CountryCode? selectedCountry;

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  final TextEditingController _searchController = TextEditingController();
  CountryCode? _selectedCountry;

  final List<CountryCode> countries = [
    CountryCode(name: 'Bolivia', dialCode: '+591', code: 'BO', flag: '🇧🇴'),
    CountryCode(
      name: 'Argentina',
      dialCode: '+54',
      code: 'AR',
      flag: '🇦🇷',
    ),
    CountryCode(name: 'Brasil', dialCode: '+55', code: 'BR', flag: '🇧🇷'),
    CountryCode(name: 'Chile', dialCode: '+56', code: 'CL', flag: '🇨🇱'),
    CountryCode(name: 'Colombia', dialCode: '+57', code: 'CO', flag: '🇨🇴'),
    CountryCode(name: 'Ecuador', dialCode: '+593', code: 'EC', flag: '🇪🇨'),
    CountryCode(name: 'Paraguay', dialCode: '+595', code: 'PY', flag: '🇵🇾'),
    CountryCode(name: 'Perú', dialCode: '+51', code: 'PE', flag: '🇵🇪'),
    CountryCode(name: 'Uruguay', dialCode: '+598', code: 'UY', flag: '🇺🇾'),
    CountryCode(name: 'Venezuela', dialCode: '+58', code: 'VE', flag: '🇻🇪'),
    CountryCode(name: 'México', dialCode: '+52', code: 'MX', flag: '🇲🇽'),
    CountryCode(name: 'España', dialCode: '+34', code: 'ES', flag: '🇪🇸'),
    CountryCode(
      name: 'Estados Unidos',
      dialCode: '+1',
      code: 'US',
      flag: '🇺🇸',
    ),
    CountryCode(name: 'Canadá', dialCode: '+1', code: 'CA', flag: '🇨🇦'),
    CountryCode(
      name: 'Reino Unido',
      dialCode: '+44',
      code: 'GB',
      flag: '🇬🇧',
    ),
    CountryCode(name: 'Francia', dialCode: '+33', code: 'FR', flag: '🇫🇷'),
    CountryCode(name: 'Alemania', dialCode: '+49', code: 'DE', flag: '🇩🇪'),
    CountryCode(name: 'Italia', dialCode: '+39', code: 'IT', flag: '🇮🇹'),
    CountryCode(name: 'Portugal', dialCode: '+351', code: 'PT', flag: '🇵🇹'),
    CountryCode(name: 'China', dialCode: '+86', code: 'CN', flag: '🇨🇳'),
    CountryCode(name: 'Japón', dialCode: '+81', code: 'JP', flag: '🇯🇵'),
    CountryCode(
      name: 'Corea del Sur',
      dialCode: '+82',
      code: 'KR',
      flag: '🇰🇷',
    ),
    CountryCode(name: 'India', dialCode: '+91', code: 'IN', flag: '🇮🇳'),
    CountryCode(name: 'Rusia', dialCode: '+7', code: 'RU', flag: '🇷🇺'),
    CountryCode(name: 'Australia', dialCode: '+61', code: 'AU', flag: '🇦🇺'),
  ];

  @override
  void initState() {
    super.initState();
    // Bolivia por defecto
    _selectedCountry =
        widget.selectedCountry ?? countries.firstWhere((c) => c.code == 'BO');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<CountryCode>(
        isExpanded: true,
        customButton: _selectedCountry != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedCountry!.flag,
                      style: TextStyle(fontSize: responsive.heightPercent(2.2)),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _selectedCountry!.dialCode,
                      style: TextStyle(
                        fontSize: responsive.heightPercent(1.4),
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        hint: Text(
          'Seleccionar',
          style: TextStyle(
            fontSize: responsive.heightPercent(1.4),
            color: Theme.of(context).hintColor,
          ),
        ),
        items: countries
            .map(
              (country) => DropdownMenuItem<CountryCode>(
                value: country,
                child: Row(
                  children: [
                    Text(
                      country.flag,
                      style: TextStyle(fontSize: responsive.heightPercent(2)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '(${country.dialCode}) - ${country.name}',
                        style: TextStyle(
                          fontSize: responsive.heightPercent(1.4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        value: _selectedCountry,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedCountry = value;
            });
            widget.onChanged(value);
          }
        },
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.zero,
          height: responsive.widthPercent(10),
          width: responsive.widthPercent(20),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: responsive.heightPercent(40),
          width: responsive.widthPercent(65),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: responsive.heightPercent(5),
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: _searchController,
          searchInnerWidgetHeight: responsive.heightPercent(7),
          searchInnerWidget: Container(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _searchController,
              style: TextStyle(
                fontSize: responsive.heightPercent(1.4),
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Buscar país...',
                hintStyle: TextStyle(
                  fontSize: responsive.heightPercent(1.4),
                  color: Theme.of(context).hintColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            final country = item.value!;
            return country.name.toLowerCase().contains(
                  searchValue.toLowerCase(),
                ) ||
                country.dialCode.contains(searchValue);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            _searchController.clear();
          }
        },
      ),
    );
  }
}
