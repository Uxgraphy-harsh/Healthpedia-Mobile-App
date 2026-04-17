import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/kinetic_interaction.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';

/// Shows the bottom sheet to add a custom health condition.
void showAddCustomConditionSheet(
  BuildContext context, {
  required Function(String) onAdded,
}) {
  showAppModalBottomSheet(
    context: context,
    builder: (context) => AddCustomConditionBottomSheet(onAdded: onAdded),
  );
}

class AddCustomConditionBottomSheet extends StatefulWidget {
  final Function(String) onAdded;
  const AddCustomConditionBottomSheet({super.key, required this.onAdded});

  @override
  State<AddCustomConditionBottomSheet> createState() =>
      _AddCustomConditionBottomSheetState();
}

class _AddCustomConditionBottomSheetState
    extends State<AddCustomConditionBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isValid = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.space24,
        left: 20,
        right: 20,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Back',
                    style: AppTypography.label1.copyWith(
                      color: AppColors.blue600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Text(
                'Custom',
                style: AppTypography.h6.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'CUSTOM FIELD',
              style: AppTypography.label1.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
          PremiumTextField(
            controller: _controller,
            placeholder: 'Type to add a disease...',
            isDark: false,
            prefix: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.neutral400,
              size: 20,
            ),
          ),

          const SizedBox(height: 32),

          // Add Button
          KineticInteraction(
            onTap: _isValid
                ? () {
                    widget.onAdded(_controller.text.trim());
                    Navigator.pop(context);
                  }
                : null,
            child: Container(
              width: double.infinity,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isValid ? AppColors.neutral950 : AppColors.neutral200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Add Condition',
                style: AppTypography.label1.copyWith(
                  color: _isValid ? AppColors.white : AppColors.neutral500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
