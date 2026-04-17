import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/base_input_container.dart';

enum PremiumHeaderActionType { cancel, back, close, none }

class PremiumSheetHeader extends StatelessWidget {
  const PremiumSheetHeader({
    super.key,
    this.title,
    this.description,
    this.leading,
    this.trailing,
    this.leadingLabel,
    this.onLeadingTap,
    this.trailingLabel,
    this.onTrailingTap,
    this.actionType = PremiumHeaderActionType.none,
    this.progress,
    this.isDark = false,
    this.showDragHandle = true,
  });

  final String? title;
  final String? description;
  final bool isDark;
  final Widget? leading;
  final Widget? trailing;
  final String? leadingLabel;
  final VoidCallback? onLeadingTap;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final PremiumHeaderActionType actionType;
  final double? progress;
  final bool showDragHandle;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? AppColors.white : AppColors.black;
    final secondaryColor = isDark ? AppColors.neutral300 : AppColors.neutral600;
    final dividerColor = isDark ? AppColors.neutral700 : AppColors.border;
    final themeShowsHandle = Theme.of(context).bottomSheetTheme.showDragHandle ?? false;
    final effectiveShowDragHandle = showDragHandle && !themeShowsHandle;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (effectiveShowDragHandle) ...[
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? AppColors.neutral600 : AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: leading ?? _buildAction(context, leadingLabel, onLeadingTap, true),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            height: 28 / 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.25,
                            color: titleColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (description != null)
                        Text(
                          description!,
                          style: BaseInputContainer.contentTextStyle(
                            context,
                            color: secondaryColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: trailing ?? _buildAction(context, trailingLabel, onTrailingTap, false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (progress != null)
          Stack(
            children: [
              Container(height: 1, color: dividerColor),
              FractionallySizedBox(
                widthFactor: progress!.clamp(0, 1),
                child: Container(height: 1.5, color: AppColors.primary),
              ),
            ],
          )
        else
          Container(height: 1, color: dividerColor),
      ],
    );
  }

  Widget _buildAction(
    BuildContext context,
    String? label,
    VoidCallback? onTap,
    bool isLeading,
  ) {
    if (label == null) {
      return const SizedBox.shrink();
    }

    final child = Align(
      alignment: isLeading ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: BaseInputContainer.contentTextStyle(
            context,
            color: isLeading
                ? AppColors.blue600
                : (onTap == null
                    ? AppColors.neutral400
                    : (isDark ? AppColors.white : AppColors.black)),
          ),
        ),
      ),
    );

    if (onTap == null) {
      return child;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
