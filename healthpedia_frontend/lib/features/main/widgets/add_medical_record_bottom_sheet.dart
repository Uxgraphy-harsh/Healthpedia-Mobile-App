import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';

import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';

void showAddMedicalRecordSheet(
  BuildContext context, {
  required Function(String hpid, List<Map<String, String>> conditions) onAdd,
  String? initialHpid,
  List<Map<String, String>>? initialConditions,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddMedicalRecordBottomSheet(
      onAdd: onAdd,
      initialHpid: initialHpid,
      initialConditions: initialConditions,
    ),
  );
}

class AddMedicalRecordBottomSheet extends StatefulWidget {
  final Function(String hpid, List<Map<String, String>> conditions) onAdd;
  final String? initialHpid;
  final List<Map<String, String>>? initialConditions;

  const AddMedicalRecordBottomSheet({
    super.key, 
    required this.onAdd,
    this.initialHpid,
    this.initialConditions,
  });

  @override
  State<AddMedicalRecordBottomSheet> createState() => _AddMedicalRecordBottomSheetState();
}

class _AddMedicalRecordBottomSheetState extends State<AddMedicalRecordBottomSheet> {
  late final TextEditingController _hpidController;
  final List<_ConditionInput> _conditions = [];

  @override
  void initState() {
    super.initState();
    _hpidController = TextEditingController(text: widget.initialHpid);
    
    if (widget.initialConditions != null && widget.initialConditions!.isNotEmpty) {
      for (var c in widget.initialConditions!) {
        _conditions.add(_ConditionInput(
          name: TextEditingController(text: c['name']),
          date: TextEditingController(text: c['date']?.replaceAll('Diagnosed • ', '')),
        ));
      }
    } else {
      _conditions.add(_ConditionInput(name: TextEditingController(), date: TextEditingController()));
    }
  }

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
    return PremiumBottomSheet(
      title: widget.initialHpid != null ? 'Edit Medical Record' : 'Add a Medical Record',
      isDark: false,
      footer: Row(
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
              onPressed: () { 
                if (_hpidController.text.isNotEmpty && _conditions.every((c) => c.name.text.isNotEmpty)) {
                  HapticFeedback.mediumImpact(); 
                  final conditionsData = _conditions.map((c) => {
                    'name': c.name.text,
                    'date': 'Diagnosed • ${c.date.text.isEmpty ? "early 50s" : c.date.text}',
                  }).toList();
                  
                  widget.onAdd(_hpidController.text, conditionsData);
                  Navigator.pop(context); 
                }
              },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumTextField(
            controller: _hpidController,
            label: 'Healthpedia ID*',
            placeholder: '#000000000000',
            isDark: false,
            minHeight: 64,
            forceLabelInside: true,
          ),
          const SizedBox(height: 24),
          ..._conditions.asMap().entries.map((entry) => _buildConditionForm(entry.key, entry.value)),
        ],
      ),
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
          PremiumTextField(
            controller: input.name,
            label: 'Condition name*',
            placeholder: 'e.g. Hypothyroidism',
            isDark: false,
            minHeight: 64,
            forceLabelInside: true,
          ),
          const SizedBox(height: 16),
          PremiumTextField(
            controller: input.date,
            label: 'Diagnosis date',
            placeholder: 'e.g. late 40s',
            isDark: false,
            minHeight: 64,
            forceLabelInside: true,
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
