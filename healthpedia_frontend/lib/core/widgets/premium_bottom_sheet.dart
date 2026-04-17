import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

class PremiumBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? footer;
  final bool isDark;
  final Widget? leading;
  final Widget? trailing;
  final String? leadingLabel;
  final VoidCallback? onLeadingTap;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final EdgeInsets? padding;

  const PremiumBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.footer,
    this.isDark = false,
    this.leading,
    this.trailing,
    this.leadingLabel,
    this.onLeadingTap,
    this.trailingLabel,
    this.onTrailingTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark ? const Color(0xFF171717) : AppColors.white;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final contentPadding =
        padding ??
        EdgeInsets.fromLTRB(
          AppResponsive.sheetHorizontalPadding(context),
          16,
          AppResponsive.sheetHorizontalPadding(context),
          16,
        );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(
        maxHeight: AppResponsive.sheetMaxHeight(context),
      ),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PremiumSheetHeader(
            title: title,
            isDark: isDark,
            leading: leading,
            trailing: trailing,
            leadingLabel: leadingLabel ?? 'Cancel',
            onLeadingTap: onLeadingTap ?? () => Navigator.pop(context),
            trailingLabel: trailingLabel,
            onTrailingTap: onTrailingTap,
            showDragHandle: true,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              padding: contentPadding,
              physics: const BouncingScrollPhysics(),
              child: child,
            ),
          ),
          if (footer != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                contentPadding.left,
                8,
                contentPadding.right,
                24,
              ),
              child: SafeArea(top: false, child: footer!),
            ),
        ],
      ),
    );
  }
}
