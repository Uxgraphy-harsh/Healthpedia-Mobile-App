import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/kinetic_interaction.dart';

class PremiumConfirmationDialog extends StatelessWidget {
  const PremiumConfirmationDialog({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onAction,
    this.actionColor = AppColors.red500,
    this.closeLabel = 'Close',
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;
  final Color actionColor;
  final String closeLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 342),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 6,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: AppTypography.label1.copyWith(
                        color: AppColors.neutral950,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      closeLabel,
                      style: AppTypography.label2.copyWith(
                        color: AppColors.blue600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Action Button Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: KineticInteraction(
                onTap: () {
                  Navigator.pop(context);
                  onAction();
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: actionColor,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    actionLabel,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Utility function to show a premium confirmation dialog
Future<void> showPremiumConfirmationDialog(
  BuildContext context, {
  required String message,
  required String actionLabel,
  required VoidCallback onAction,
  Color actionColor = AppColors.red500,
  String closeLabel = 'Close',
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => PremiumConfirmationDialog(
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      actionColor: actionColor,
      closeLabel: closeLabel,
    ),
  );
}
