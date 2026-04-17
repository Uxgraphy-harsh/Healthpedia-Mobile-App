import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_button.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';

class ProfileInfoSheetScaffold extends StatelessWidget {
  const ProfileInfoSheetScaffold({
    super.key,
    required this.title,
    required this.child,
    required this.primaryLabel,
    required this.onPrimaryTap,
    this.leadingLabel = 'Cancel',
    this.onLeadingTap,
    this.trailingLabel,
    this.onTrailingTap,
    this.primaryEnabled = true,
    this.primaryColor,
    this.primaryChild,
    this.bottomSpacing = 16,
  });

  final String title;
  final Widget child;
  final String primaryLabel;
  final VoidCallback onPrimaryTap;
  final String leadingLabel;
  final VoidCallback? onLeadingTap;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final bool primaryEnabled;
  final Color? primaryColor;
  final Widget? primaryChild;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return PremiumBottomSheet(
      title: title,
      leadingLabel: leadingLabel,
      onLeadingTap: onLeadingTap ?? () => Navigator.pop(context),
      trailingLabel: trailingLabel,
      onTrailingTap: onTrailingTap,
      footer: primaryChild != null
          ? SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: primaryEnabled
                      ? (primaryColor ?? AppColors.neutral950)
                      : AppColors.neutral200,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: primaryEnabled
                        ? () {
                            HapticFeedback.mediumImpact();
                            onPrimaryTap();
                          }
                        : null,
                    borderRadius: BorderRadius.circular(99),
                    child: Center(child: primaryChild),
                  ),
                ),
              ),
            )
          : PremiumButton(
              label: primaryLabel,
              size: PremiumButtonSize.docked,
              variant: primaryColor == AppColors.red500
                  ? PremiumButtonVariant.destructive
                  : PremiumButtonVariant.primary,
              onPressed: primaryEnabled
                  ? () {
                      HapticFeedback.mediumImpact();
                      onPrimaryTap();
                    }
                  : null,
            ),
      child: child,
    );
  }
}

class ProfileInfoFieldCard extends StatelessWidget {
  const ProfileInfoFieldCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children
            .asMap()
            .entries
            .map(
              (entry) => _ProfileInfoFieldRowShell(
                isLast: entry.key == children.length - 1,
                child: entry.value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProfileInfoFieldRow extends StatelessWidget {
  const ProfileInfoFieldRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTypography.label1.copyWith(
            color: AppColors.neutral700,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child:
                trailing ??
                Text(
                  value,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ],
    );
  }
}

class ProfileInfoOtpSlots extends StatelessWidget {
  const ProfileInfoOtpSlots({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.status,
    required this.onChanged,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final ProfileInfoOtpStatus status;
  final void Function(int index, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(controllers.length, (index) => _buildSlot(index)),
    );
  }

  Widget _buildSlot(int index) {
    Color borderColor = AppColors.neutral200;
    if (status == ProfileInfoOtpStatus.error) {
      borderColor = AppColors.red300;
    } else if (status == ProfileInfoOtpStatus.success) {
      borderColor = AppColors.green400;
    }

    return SizedBox(
      width: 50,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) => onChanged(index, value),
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w400,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: '',
            ),
            cursorColor: AppColors.neutral950,
          ),
        ),
      ),
    );
  }
}

enum ProfileInfoOtpStatus { none, data, error, success }

class _ProfileInfoFieldRowShell extends StatelessWidget {
  const _ProfileInfoFieldRowShell({required this.child, required this.isLast});

  final Widget child;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: child,
    );
  }
}
