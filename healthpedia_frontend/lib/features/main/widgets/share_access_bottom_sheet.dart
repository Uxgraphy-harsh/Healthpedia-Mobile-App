import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

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
        iconKind: _AccessIconKind.svg,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/diagnosis.svg',
        iconBackgroundColor: AppColors.rose500,
        enabled: true,
      ),
      const _AccessOption(
        label: 'Prescriptions',
        iconKind: _AccessIconKind.emoji,
        emoji: '💊',
        iconBackgroundColor: AppColors.purple500,
      ),
      const _AccessOption(
        label: 'Allergies',
        iconKind: _AccessIconKind.svg,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/allergy.svg',
        iconBackgroundColor: AppColors.orange500,
      ),
      const _AccessOption(
        label: 'Reports',
        iconKind: _AccessIconKind.svg,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/folder_open.svg',
        iconBackgroundColor: AppColors.cyan500,
      ),
      const _AccessOption(
        label: 'Symptoms',
        iconKind: _AccessIconKind.emoji,
        emoji: '🤒',
        iconBackgroundColor: AppColors.green500,
      ),
      const _AccessOption(
        label: 'Family History',
        iconKind: _AccessIconKind.svg,
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Family History big icon.svg',
        iconBackgroundColor: AppColors.indigo500,
      ),
      const _AccessOption(
        label: 'Insurance',
        iconKind: _AccessIconKind.svg,
        iconPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/shield_with_heart.svg',
        iconBackgroundColor: AppColors.teal500,
        enabled: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radius3xl),
              topRight: Radius.circular(AppSpacing.radius3xl),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
              ),
              SizedBox(
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space16,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: AppTypography.label2.copyWith(
                              color: AppColors.blue600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Share Access',
                      style: AppTypography.label1SemiBold.copyWith(
                        color: AppColors.neutral950,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ShareTargetHeader(
                      name: widget.name,
                      phoneNumber: widget.phoneNumber,
                      imagePath: widget.imagePath,
                      backgroundColor: widget.backgroundColor,
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral100,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radius2xl,
                        ),
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
                    const SizedBox(height: AppSpacing.space20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        child: Text(
                          'Grant Access',
                          style: AppTypography.body2Medium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          padding: const EdgeInsets.all(4.75),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neutral300, width: 1.33),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          name,
          style: AppTypography.label1.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          phoneNumber,
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
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
      padding: const EdgeInsets.only(left: AppSpacing.space16),
      child: Row(
        children: [
          _AccessIcon(option: option),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                right: AppSpacing.space16,
                top: AppSpacing.space16,
                bottom: AppSpacing.space16,
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
                  _AccessToggle(value: option.enabled, onChanged: onChanged),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessIcon extends StatelessWidget {
  const _AccessIcon({required this.option});

  final _AccessOption option;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: option.iconBackgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Center(
        child: switch (option.iconKind) {
          _AccessIconKind.svg => SvgPicture.asset(
            option.iconPath!,
            width: 24,
            height: 24,
          ),
          _AccessIconKind.emoji => Text(
            option.emoji!,
            style: const TextStyle(fontSize: 24),
          ),
        },
      ),
    );
  }
}

class _AccessToggle extends StatelessWidget {
  const _AccessToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 42,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? AppColors.blue400 : AppColors.neutral300,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: (value ? AppColors.blue400 : AppColors.black).withValues(
                alpha: value ? 0.15 : 0.08,
              ),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x38000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccessOption {
  const _AccessOption({
    required this.label,
    required this.iconKind,
    required this.iconBackgroundColor,
    this.iconPath,
    this.emoji,
    this.enabled = false,
  });

  final String label;
  final _AccessIconKind iconKind;
  final String? iconPath;
  final String? emoji;
  final Color iconBackgroundColor;
  final bool enabled;

  _AccessOption copyWith({bool? enabled}) {
    return _AccessOption(
      label: label,
      iconKind: iconKind,
      iconPath: iconPath,
      emoji: emoji,
      iconBackgroundColor: iconBackgroundColor,
      enabled: enabled ?? this.enabled,
    );
  }
}

enum _AccessIconKind { svg, emoji }
