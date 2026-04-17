import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class PremiumAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? destructiveLabel;
  final VoidCallback? onDestructivePressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final bool isDestructive;

  const PremiumAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.destructiveLabel,
    this.onDestructivePressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTypography.label1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral950,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppTypography.label3.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.neutral950,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0.5, color: Color(0xFFC6C6C8)),
            if (destructiveLabel != null) ...[
              _AlertButton(
                label: primaryLabel,
                onPressed: () {
                  Navigator.of(context).pop();
                  onPrimaryPressed();
                },
                isBlue: true,
              ),
              const Divider(height: 0.5, color: Color(0xFFC6C6C8)),
              _AlertButton(
                label: destructiveLabel!,
                onPressed: () {
                  Navigator.of(context).pop();
                  onDestructivePressed!();
                },
                isRed: true,
              ),
              const Divider(height: 0.5, color: Color(0xFFC6C6C8)),
              _AlertButton(
                label: secondaryLabel ?? 'Cancel',
                onPressed: onSecondaryPressed ?? () => Navigator.pop(context),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: _AlertButton(
                      label: secondaryLabel ?? 'Cancel',
                      onPressed:
                          onSecondaryPressed ?? () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 44,
                    color: const Color(0xFFC6C6C8),
                  ),
                  Expanded(
                    child: _AlertButton(
                      label: primaryLabel,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPrimaryPressed();
                      },
                      isBlue: !isDestructive,
                      isRed: isDestructive,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AlertButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isBlue;
  final bool isRed;
  final bool isBold;

  const _AlertButton({
    required this.label,
    required this.onPressed,
    this.isBlue = false,
    this.isRed = false,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.label1.copyWith(
              color: isRed
                  ? AppColors.red600
                  : (isBlue ? AppColors.blue600 : AppColors.blue600),
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              fontSize: 17,
              letterSpacing: -0.41,
            ),
          ),
        ),
      ),
    );
  }
}
