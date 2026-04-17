import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_conditions.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_date_picker.dart';

void showAddConditionSheet(BuildContext context, {required Function(String name, String date, String illustration) onAdd}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddConditionBottomSheet(onAdd: onAdd),
  );
}

class AddConditionBottomSheet extends StatefulWidget {
  final Function(String name, String date, String illustration) onAdd;
  const AddConditionBottomSheet({super.key, required this.onAdd});

  @override
  State<AddConditionBottomSheet> createState() => _AddConditionBottomSheetState();
}

class _AddConditionBottomSheetState extends State<AddConditionBottomSheet> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  late final PageController _illustrationController;
  int _selectedIllustrationIndex = 0;

  @override
  void initState() {
    super.initState();
    _illustrationController = PageController(
      viewportFraction: 0.25,
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _illustrationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumBottomSheet(
      title: 'Add Condition',
      isDark: false,
      footer: ElevatedButton(
        onPressed: () {
          if (_nameController.text.isNotEmpty) {
            HapticFeedback.mediumImpact();
            final dateStr = _selectedDate != null 
              ? 'Diagnosed • ${_selectedDate!.year}s' 
              : 'Diagnosed • early 50s'; // Fallback for demo
            
            widget.onAdd(
              _nameController.text,
              dateStr,
              AppConditions.all[_selectedIllustrationIndex],
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
          'Add',
          style: AppTypography.label1.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Illustration Selector — Snap-to-center PageView
          SizedBox(
            height: 64,
            child: PageView.builder(
              controller: _illustrationController,
              clipBehavior: Clip.none,
              itemCount: AppConditions.all.length,
              onPageChanged: (index) {
                HapticFeedback.selectionClick();
                setState(() => _selectedIllustrationIndex = index);
              },
              itemBuilder: (context, index) {
                final illustration = AppConditions.all[index];
                final isSelected = _selectedIllustrationIndex == index;

                return GestureDetector(
                  onTap: () {
                    _illustrationController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isSelected ? 1 : 0.4,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 64,
                        height: 64,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.neutral950
                                : AppColors.neutral200,
                            width: isSelected ? 1.5 : 1,
                          ),
                          color: isSelected
                              ? AppColors.white
                              : AppColors.neutral50,
                        ),
                        child: SvgPicture.asset(
                          illustration,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          PremiumTextField(
            controller: _nameController,
            label: 'Condition name',
            placeholder: 'e.g. Hypothyroidism',
            isDark: false,
            minHeight: 64,
            forceLabelInside: true,
          ),
          const SizedBox(height: 16),
          PremiumDatePicker(
            label: 'Diagnosis date',
            placeholder: 'DD/MM/YYYY',
            value: _selectedDate,
            onDateSelected: (date) {
              setState(() => _selectedDate = date);
            },
            isDark: false,
            minHeight: 64,
          ),
        ],
      ),
    );
  }
}
