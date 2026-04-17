import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class Country {
  const Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.dialCode,
  });

  final String name;
  final String code;
  final String flag;
  final String dialCode;
}

const List<Country> countries = [
  Country(name: 'India', code: 'IN', flag: 'IN', dialCode: '+91'),
  Country(name: 'United States', code: 'US', flag: 'US', dialCode: '+1'),
  Country(name: 'United Kingdom', code: 'GB', flag: 'GB', dialCode: '+44'),
  Country(name: 'Canada', code: 'CA', flag: 'CA', dialCode: '+1'),
  Country(name: 'Australia', code: 'AU', flag: 'AU', dialCode: '+61'),
];

class PremiumCountryField extends StatefulWidget {
  const PremiumCountryField({
    super.key,
    this.label,
    this.hint,
    this.initialCountry = const Country(name: 'India', code: 'IN', flag: 'IN', dialCode: '+91'),
    this.controller,
    this.onCountryChanged,
    this.state = PremiumFieldState.defaultState,
    this.isDark = true,
  });

  final String? label;
  final String? hint;
  final Country initialCountry;
  final TextEditingController? controller;
  final ValueChanged<Country>? onCountryChanged;
  final PremiumFieldState state;
  final bool isDark;

  @override
  State<PremiumCountryField> createState() => _PremiumCountryFieldState();
}

class _PremiumCountryFieldState extends State<PremiumCountryField> {
  late Country _selectedCountry;
  late final FocusNode _focusNode;
  TextEditingController? _internalController;

  TextEditingController get _effectiveController {
    return widget.controller ?? (_internalController ??= TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  Future<void> _showCountryPicker() async {
    final country = await showModalBottomSheet<Country>(
      context: context,
      backgroundColor: widget.isDark ? AppColors.neutral900 : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: countries.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: widget.isDark ? AppColors.neutral700 : AppColors.neutral200,
            ),
            itemBuilder: (context, index) {
              final country = countries[index];
              return ListTile(
                title: Text(
                  country.name,
                  style: BaseInputContainer.contentTextStyle(
                    context,
                    color: widget.isDark ? AppColors.white : AppColors.black,
                  ),
                ),
                subtitle: Text(
                  country.dialCode,
                  style: BaseInputContainer.contentTextStyle(
                    context,
                    color: widget.isDark ? AppColors.neutral300 : AppColors.neutral600,
                  ),
                ),
                trailing: Text(
                  country.flag,
                  style: BaseInputContainer.labelTextStyle(
                    context,
                    color: widget.isDark ? AppColors.white : AppColors.black,
                  ),
                ),
                onTap: () => Navigator.pop(context, country),
              );
            },
          ),
        );
      },
    );
    if (country != null && mounted) {
      setState(() => _selectedCountry = country);
      widget.onCountryChanged?.call(country);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.white : AppColors.black;
    final mutedColor = widget.isDark ? AppColors.neutral300 : AppColors.neutral600;

    if (!widget.isDark) {
      return PremiumTextField(
        label: widget.label,
        hint: widget.hint,
        controller: _effectiveController,
        state: widget.state,
        isDark: false,
        keyboardType: TextInputType.phone,
        backgroundColor: AppColors.white,
        borderRadius: 16,
        minHeight: 56,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        placeholder: '00000 00000',
        prefix: GestureDetector(
          onTap: _showCountryPicker,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedCountry.flag,
                style: BaseInputContainer.contentTextStyle(
                  context,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _selectedCountry.dialCode,
                style: BaseInputContainer.contentTextStyle(
                  context,
                  color: mutedColor,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: mutedColor,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: BaseInputContainer.labelTextStyle(
              context,
              color: widget.isDark ? AppColors.white : AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            SizedBox(
              width: 76,
              child: BaseInputContainer(
                state: widget.state,
                isDark: widget.isDark,
                onTap: _showCountryPicker,
                minHeight: 36,
                fillWidth: true,
                borderRadius: 4,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedCountry.flag,
                      style: BaseInputContainer.contentTextStyle(
                        context,
                        color: textColor,
                      ).copyWith(fontSize: 12, height: 20 / 12),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: mutedColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BaseInputContainer(
                state: widget.state,
                isFocused: _focusNode.hasFocus,
                isDark: widget.isDark,
                minHeight: 36,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      _selectedCountry.dialCode,
                      style: BaseInputContainer.contentTextStyle(
                        context,
                        color: mutedColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _effectiveController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.phone,
                        style: BaseInputContainer.contentTextStyle(
                          context,
                          color: textColor,
                        ),
                        cursorColor: AppColors.primary,
                        decoration: InputDecoration(
                          hintText: '(999) 999-9999',
                          hintStyle: BaseInputContainer.contentTextStyle(
                            context,
                            color: mutedColor,
                          ),
                          isDense: true,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.hint!,
            style: BaseInputContainer.contentTextStyle(
              context,
              color: mutedColor,
            ),
          ),
        ],
      ],
    );
  }
}
