import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

void showAddMedicalRecordSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const AddMedicalRecordBottomSheet(),
  );
}

class AddMedicalRecordBottomSheet extends StatefulWidget {
  const AddMedicalRecordBottomSheet({super.key});

  @override
  State<AddMedicalRecordBottomSheet> createState() => _AddMedicalRecordBottomSheetState();
}

class _AddMedicalRecordBottomSheetState extends State<AddMedicalRecordBottomSheet> {
  final _hpidController = TextEditingController();
  final List<_ConditionInput> _conditions = [
    _ConditionInput(name: TextEditingController(), date: TextEditingController()),
  ];

  @override
  void dispose() {
    _hpidController.dispose();
    for (var c in _conditions) {
      c.name.dispose();
      c.date.dispose();
    }
    super.dispose();
  }

  void _addCondition() {
    HapticFeedback.lightImpact();
    setState(() {
      _conditions.add(_ConditionInput(name: TextEditingController(), date: TextEditingController()));
    });
  }

  void _removeCondition(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _conditions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.space24,
        left: 16,
        right: 16,
        top: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppColors.neutral200, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 32),
            TextField(
              controller: _hpidController,
              decoration: _inputDecoration('Healthpedia ID*', '#000000000000'),
            ),
            const SizedBox(height: 24),
            ..._conditions.asMap().entries.map((entry) => _buildConditionForm(entry.key, entry.value)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _addCondition,
                    icon: const Icon(Icons.add, color: Color(0xFFE11D48)),
                    label: Text('Add More', style: AppTypography.label1.copyWith(color: const Color(0xFFE11D48), fontWeight: FontWeight.w500)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 56),
                      side: const BorderSide(color: Color(0xFFFFD1D5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () { HapticFeedback.mediumImpact(); Navigator.pop(context); },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neutral950,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(0, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    ),
                    child: Text('Save', style: AppTypography.label1.copyWith(fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTypography.label1.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w400)),
          ),
        ),
        Text('Add a Medical Record', style: AppTypography.h6.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildConditionForm(int index, _ConditionInput input) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('CONDITION ${index + 1}', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600)),
              if (index > 0)
                GestureDetector(
                  onTap: () => _removeCondition(index),
                  child: Text('Remove', style: AppTypography.label3.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: input.name,
            decoration: _inputDecoration('Condition name*', 'e.g. Hypothyroidism'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: input.date,
            decoration: _inputDecoration('Diagnosis date', '00/00/0000'),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
    );
  }
}

class _ConditionInput {
  final TextEditingController name;
  final TextEditingController date;
  _ConditionInput({required this.name, required this.date});
}
