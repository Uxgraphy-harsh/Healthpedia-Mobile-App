import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

Future<void> showFamilyFriendsAboutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.14),
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: const Alignment(0, 0.48),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 6,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'About Family & Friends',
                        style: AppTypography.label1SemiBold.copyWith(
                          color: AppColors.neutral950,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(dialogContext).pop(),
                      child: Text(
                        'Understood',
                        style: AppTypography.label2.copyWith(
                          color: AppColors.blue600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  0,
                  AppSpacing.space16,
                  AppSpacing.space16,
                ),
                child: Text(
                  'You only see what each member has chosen to share with you. Their chats, health score, and personal notes are always private.',
                  style: AppTypography.label2.copyWith(
                    color: AppColors.neutral600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
