import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class PremiumInfoDialog extends StatelessWidget {
  const PremiumInfoDialog({
    super.key,
    required this.title,
    required this.description,
    this.closeLabel = 'Understood',
    this.onClose,
    this.primaryLabel,
    this.onPrimaryPressed,
    this.primaryColor = AppColors.blue500,
  });

  final String title;
  final String description;
  final String closeLabel;
  final VoidCallback? onClose;
  final String? primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.label1.copyWith(
                      color: AppColors.neutral950,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onClose?.call();
                  },
                  child: Text(
                    closeLabel,
                    style: AppTypography.label1.copyWith(
                      color: AppColors.blue600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTypography.label2.copyWith(
                color: AppColors.neutral600,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (primaryLabel != null && onPrimaryPressed != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPrimaryPressed!.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  child: Text(
                    primaryLabel!,
                    style: AppTypography.label1.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<T?> showPremiumInfoDialog<T>(
  BuildContext context, {
  required String title,
  required String description,
  String closeLabel = 'Understood',
  VoidCallback? onClose,
  String? primaryLabel,
  VoidCallback? onPrimaryPressed,
  Color primaryColor = AppColors.blue500,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => PremiumInfoDialog(
      title: title,
      description: description,
      closeLabel: closeLabel,
      onClose: onClose,
      primaryLabel: primaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      primaryColor: primaryColor,
    ),
  );
}
