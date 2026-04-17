import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';
import 'package:healthpedia_frontend/core/widgets/premium_switch.dart';

Future<void> showShareAccessBottomSheet(
  BuildContext context, {
  required String name,
  required String phoneNumber,
  required String imagePath,
  required Color backgroundColor,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ShareAccessBottomSheet(
      name: name,
      phoneNumber: phoneNumber,
      imagePath: imagePath,
      backgroundColor: backgroundColor,
    ),
  );
}

class ShareAccessBottomSheet extends StatefulWidget {
  const ShareAccessBottomSheet({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String name;
  final String phoneNumber;
  final String imagePath;
  final Color backgroundColor;

  @override
  State<ShareAccessBottomSheet> createState() => _ShareAccessBottomSheetState();
}

class _ShareAccessBottomSheetState extends State<ShareAccessBottomSheet> {
  late final List<_AccessOption> _options;

  @override
  void initState() {
    super.initState();
    _options = [
      const _AccessOption(
        label: 'Conditions',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Conditions/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFFF43F5E),
        enabled: true,
      ),
      const _AccessOption(
        label: 'Prescriptions',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Prescriptions/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFFA855F7),
      ),
      const _AccessOption(
        label: 'Allergies',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Allergies/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFFF97316),
      ),
      const _AccessOption(
        label: 'Reports',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Reports/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFF06B6D4),
      ),
      const _AccessOption(
        label: 'Symptoms',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Symptoms/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFF22C55E),
      ),
      const _AccessOption(
        label: 'Family History',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Family History/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFF6366F1),
      ),
      const _AccessOption(
        label: 'Insurance',
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Insurance/share access bottom sheet.svg',
        fallbackBackgroundColor: Color(0xFF14B8A6),
        enabled: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTypography.label2.copyWith(
                      color: AppColors.blue600,
                    ),
                  ),
                ),
                Text(
                  'Share Access',
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 48), // Spacer for balance
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ShareTargetHeader(
                  name: widget.name,
                  phoneNumber: widget.phoneNumber,
                  imagePath: widget.imagePath,
                  backgroundColor: widget.backgroundColor,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: List.generate(_options.length, (index) {
                      final option = _options[index];
                      return _AccessOptionRow(
                        option: option,
                        showDivider: index < _options.length - 1,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _options[index] = option.copyWith(
                              enabled: value,
                            );
                          });
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.blue400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Grant Access',
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      height: 24,
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class _ShareTargetHeader extends StatelessWidget {
  const _ShareTargetHeader({
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String name;
  final String phoneNumber;
  final String imagePath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(4.7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neutral300, width: 1.3),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTypography.label1.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          phoneNumber,
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _AccessOptionRow extends StatelessWidget {
  const _AccessOptionRow({
    required this.option,
    required this.showDivider,
    required this.onChanged,
  });

  final _AccessOption option;
  final bool showDivider;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            option.iconPath,
            width: 32,
            height: 32,
            placeholderBuilder: (_) => Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: option.fallbackBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                right: 16,
                top: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                border: showDivider
                    ? const Border(
                        bottom: BorderSide(color: AppColors.neutral200),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.label,
                      style: AppTypography.label1.copyWith(
                        color: AppColors.neutral950,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  PremiumSwitch(value: option.enabled, onChanged: onChanged),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessOption {
  const _AccessOption({
    required this.label,
    required this.iconPath,
    this.fallbackBackgroundColor = AppColors.neutral200,
    this.enabled = false,
  });

  final String label;
  final String iconPath;
  final Color fallbackBackgroundColor;
  final bool enabled;

  _AccessOption copyWith({bool? enabled}) {
    return _AccessOption(
      label: label,
      iconPath: iconPath,
      fallbackBackgroundColor: fallbackBackgroundColor,
      enabled: enabled ?? this.enabled,
    );
  }
}

