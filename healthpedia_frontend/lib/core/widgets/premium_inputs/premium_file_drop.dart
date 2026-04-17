import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';
import 'premium_field_states.dart';

class PremiumFileDrop extends StatelessWidget {
  const PremiumFileDrop({
    super.key,
    this.label,
    this.hint,
    this.progress = 0,
    this.statusMessage,
    this.onBrowse,
    this.onAction,
    this.state = PremiumFieldState.defaultState,
    this.isDark = true,
    this.emptyTitle,
    this.emptyBrowseLabel = 'Browse files',
    this.emptyIcon,
    this.supportedFormats = const [],
    this.showEmptyBrowseButton = true,
  });

  final String? label;
  final String? hint;
  final double progress;
  final String? statusMessage;
  final VoidCallback? onBrowse;
  final VoidCallback? onAction;
  final PremiumFieldState state;
  final bool isDark;
  final String? emptyTitle;
  final String emptyBrowseLabel;
  final Widget? emptyIcon;
  final List<String> supportedFormats;
  final bool showEmptyBrowseButton;

  @override
  Widget build(BuildContext context) {
    final isUploading = progress > 0 && progress < 1;
    final isComplete = progress >= 1;
    final isError = state.isError;
    final fill = isDark ? AppColors.neutral800 : AppColors.neutral100;
    final stroke = isDark ? AppColors.neutral700 : AppColors.border;
    final textColor = isDark ? AppColors.white : AppColors.neutral700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: BaseInputContainer.labelTextStyle(
              context,
              color: isDark ? AppColors.white : AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: onBrowse,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isError ? AppColors.error : stroke,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                if (!isUploading && !isComplete && !isError) ...[
                  if (emptyIcon != null) ...[
                    emptyIcon!,
                    const SizedBox(height: 12),
                  ],
                  Text(
                    emptyTitle ?? 'Drop files here to upload...',
                    style: BaseInputContainer.contentTextStyle(context, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  if (showEmptyBrowseButton) ...[
                    const SizedBox(height: 12),
                    _buildPillButton(
                      context,
                      label: emptyBrowseLabel,
                      onTap: onBrowse,
                      isDark: isDark,
                    ),
                  ],
                  if (supportedFormats.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: supportedFormats
                          .map(
                            (format) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.neutral700
                                    : AppColors.backgroundTertiary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                format,
                                style: BaseInputContainer.labelTextStyle(
                                  context,
                                  color: isDark ? AppColors.white : AppColors.neutral500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ] else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0, 1),
                      minHeight: 6,
                      backgroundColor: isDark ? AppColors.neutral700 : AppColors.neutral200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isError ? AppColors.error : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    statusMessage ??
                        (isError
                            ? 'Upload failed'
                            : (isComplete ? 'Upload complete' : '${(progress * 100).round()}% complete')),
                    style: BaseInputContainer.contentTextStyle(context, color: textColor),
                  ),
                  const SizedBox(height: 12),
                  _buildPillButton(
                    context,
                    label: isError ? 'Try again' : (isComplete ? 'Done' : 'Cancel'),
                    onTap: onAction,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (hint != null) ...[
          const SizedBox(height: 8),
          Text(
            hint!,
            style: BaseInputContainer.contentTextStyle(
              context,
              color: isError ? AppColors.error : textColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPillButton(
    BuildContext context, {
    required String label,
    required VoidCallback? onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.neutral700 : AppColors.backgroundTertiary,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: BaseInputContainer.labelTextStyle(
            context,
            color: isDark ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
