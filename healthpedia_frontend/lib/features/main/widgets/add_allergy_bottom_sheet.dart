import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';
import 'severity_switch.dart';

import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';

void showAddAllergySheet(BuildContext context, {required Function(String name, String reaction, String type, AllergySeverity severity) onAdd}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddAllergyBottomSheet(onAdd: onAdd),
  );
}

class AddAllergyBottomSheet extends StatefulWidget {
  final Function(String name, String reaction, String type, AllergySeverity severity) onAdd;
  const AddAllergyBottomSheet({super.key, required this.onAdd});

  @override
  State<AddAllergyBottomSheet> createState() => _AddAllergyBottomSheetState();
}

class _AddAllergyBottomSheetState extends State<AddAllergyBottomSheet> {
  final _nameController = TextEditingController();
  final _reactionController = TextEditingController();
  String _selectedType = 'Food';
  AllergySeverity _severity = AllergySeverity.mild;

  final List<String> _types = ['Drug', 'Food', 'Environmental', 'Other'];

  @override
  void dispose() {
    _nameController.dispose();
    _reactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumBottomSheet(
      title: 'Add allergy',
      isDark: false,
      footer: ElevatedButton(
        onPressed: () {
          if (_nameController.text.isNotEmpty) {
            HapticFeedback.mediumImpact();
            widget.onAdd(
              _nameController.text,
              _reactionController.text,
              _selectedType,
              _severity,
            );
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neutral950,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          elevation: 0,
        ),
        child: Text(
          'Save Allergy',
          style: AppTypography.label1.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumTextField(
            controller: _nameController,
            label: 'Allergy name*',
            placeholder: 'e.g. Penicillin',
            isDark: false,
            minHeight: 64,
            forceLabelInside: true,
          ),
          const SizedBox(height: 16),
          PremiumTextField(
            controller: _reactionController,
            label: 'Reaction',
            placeholder: 'Describe what happens',
            isDark: false,
            maxLines: 3,
            minHeight: 100,
            forceLabelInside: true,
          ),
          const SizedBox(height: 24),
          _buildTypeSection(),
          const SizedBox(height: 24),
          _buildSeveritySection(),
        ],
      ),
    );
  }

  Widget _buildTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TYPE*',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _types.map((type) {
            final isSelected = _selectedType == type;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedType = type);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue600 : AppColors.white,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                    color: isSelected ? AppColors.blue600 : AppColors.neutral200,
                  ),
                ),
                child: Text(
                  type,
                  style: AppTypography.label2.copyWith(
                    color: isSelected ? AppColors.white : AppColors.neutral500,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSeveritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SEVERITY',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SeveritySwitch(
          selectedSeverity: _severity,
          onChanged: (val) => setState(() => _severity = val),
        ),
      ],
    );
  }
}
