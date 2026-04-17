import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumDatePicker extends StatelessWidget {
  const PremiumDatePicker({
    super.key,
    this.label,
    this.hint,
    this.placeholder = 'Select date',
    this.value,
    required this.onDateSelected,
    this.state = PremiumFieldState.defaultState,
    this.isDark = true,
    this.minHeight = 55,
  });

  final String? label;
  final String? hint;
  final String? placeholder;
  final DateTime? value;
  final ValueChanged<DateTime> onDateSelected;
  final PremiumFieldState state;
  final bool isDark;
  final double minHeight;

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        final baseTheme = Theme.of(context);
        return Theme(
          data: baseTheme.copyWith(
            colorScheme: (isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
              primary: AppColors.primary,
              onPrimary: AppColors.black,
              surface: isDark ? AppColors.neutral900 : AppColors.white,
              onSurface: isDark ? AppColors.white : AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = value != null ? DateFormat('dd MMM, yyyy').format(value!) : null;
    return PremiumTextField(
      label: label,
      hint: hint,
      placeholder: placeholder,
      valueText: dateStr,
      state: state,
      readOnly: true,
      isDark: isDark,
      minHeight: minHeight,
      forceLabelInside: true,
      onTap: () => _pickDate(context),
      prefixIcon: Icons.calendar_month_rounded,
    );
  }
}
