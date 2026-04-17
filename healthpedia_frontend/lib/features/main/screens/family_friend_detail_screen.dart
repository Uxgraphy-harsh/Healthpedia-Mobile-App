import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/main/screens/family_friend_module_screens.dart';

class FamilyFriendDetailScreen extends StatelessWidget {
  const FamilyFriendDetailScreen({
    super.key,
    required this.name,
    required this.hpid,
    required this.ageLabel,
    required this.genderLabel,
    required this.imagePath,
    required this.avatarBackgroundColor,
    required this.allowedSections,
    required this.healthpediaId,
    required this.abhaId,
  });

  final String name;
  final String hpid;
  final String ageLabel;
  final String genderLabel;
  final String imagePath;
  final Color avatarBackgroundColor;
  final List<FamilyFriendSection> allowedSections;
  final String healthpediaId;
  final String abhaId;

  @override
  Widget build(BuildContext context) {
    final groupedSections = <List<FamilyFriendSection>>[];
    if (allowedSections.length >= 3) {
      groupedSections.add(allowedSections.sublist(0, 3));
    }
    if (allowedSections.length >= 6) {
      groupedSections.add(allowedSections.sublist(3, 6));
    }
    if (allowedSections.length > 6) {
      groupedSections.add(allowedSections.sublist(6));
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space40,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _HeaderBackButton(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              _ProfileHero(
                name: name,
                hpid: hpid,
                ageLabel: ageLabel,
                genderLabel: genderLabel,
                imagePath: imagePath,
                avatarBackgroundColor: avatarBackgroundColor,
              ),
              const SizedBox(height: AppSpacing.space24),
              ...groupedSections.map(
                (group) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.space24),
                  child: _SectionGroupCard(sections: group, memberName: name),
                ),
              ),
              _IdentityGroup(healthpediaId: healthpediaId, abhaId: abhaId),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyFriendSection {
  const FamilyFriendSection({
    required this.label,
    required this.iconKind,
    required this.iconBackgroundColor,
    this.iconPath,
    this.emoji,
  });

  final String label;
  final SectionIconKind iconKind;
  final Color iconBackgroundColor;
  final String? iconPath;
  final String? emoji;
}

enum SectionIconKind { svg, emoji }

const kDefaultFamilyFriendSections = [
  FamilyFriendSection(
    label: 'Conditions',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Conditions/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.rose500,
  ),
  FamilyFriendSection(
    label: 'Prescriptions',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Prescriptions/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.purple500,
  ),
  FamilyFriendSection(
    label: 'Allergies',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Allergies/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.orange500,
  ),
  FamilyFriendSection(
    label: 'Reports',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Reports/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.cyan500,
  ),
  FamilyFriendSection(
    label: 'Symptoms',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Symptoms/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.green500,
  ),
  FamilyFriendSection(
    label: 'Family History',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Family History/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.indigo500,
  ),
  FamilyFriendSection(
    label: 'Insurance',
    iconKind: SectionIconKind.svg,
    iconPath:
        'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends/Insurance/share access bottom sheet.svg',
    iconBackgroundColor: AppColors.teal500,
  ),
];

class _HeaderBackButton extends StatelessWidget {
  const _HeaderBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      onTap: onTap,
      child: const SizedBox(
        width: AppSpacing.size40,
        height: AppSpacing.size40,
        child: Center(
          child: Icon(
            Icons.arrow_back,
            size: AppSpacing.size24,
            color: AppColors.neutral500,
          ),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.name,
    required this.hpid,
    required this.ageLabel,
    required this.genderLabel,
    required this.imagePath,
    required this.avatarBackgroundColor,
  });

  final String name;
  final String hpid;
  final String ageLabel;
  final String genderLabel;
  final String imagePath;
  final Color avatarBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 116,
          height: 116,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neutral300, width: 1),
          ),
          child: ClipOval(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: AppTypography.h3.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          hpid,
          textAlign: TextAlign.center,
          style: AppTypography.label1.copyWith(
            color: AppColors.pink500,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          '$ageLabel • $genderLabel',
          textAlign: TextAlign.center,
          style: AppTypography.label1.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _SectionGroupCard extends StatelessWidget {
  const _SectionGroupCard({required this.sections, required this.memberName});

  final List<FamilyFriendSection> sections;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: List.generate(sections.length, (index) {
          final section = sections[index];
          return _SectionRow(
            section: section,
            showDivider: index < sections.length - 1,
            isCompact: sections.length == 1,
            memberName: memberName,
          );
        }),
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.section,
    required this.showDivider,
    required this.isCompact,
    required this.memberName,
  });

  final FamilyFriendSection section;
  final bool showDivider;
  final bool isCompact;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(
          context,
        ).push(createFamilyFriendSectionRoute(section, memberName: memberName));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.space16),
        child: Row(
          children: [
            _SectionIcon(section: section),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Container(
                constraints: BoxConstraints(minHeight: isCompact ? 53 : 73),
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                        section.label,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.space16),
                      child: const Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionIcon extends StatelessWidget {
  const _SectionIcon({required this.section});

  final FamilyFriendSection section;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: switch (section.iconKind) {
          SectionIconKind.svg => SvgPicture.asset(
              section.iconPath!,
              width: 32,
              height: 32,
            ),
          SectionIconKind.emoji => Text(
              section.emoji!,
              style: const TextStyle(fontSize: 24),
            ),
        },
      ),
    );
  }
}

class _IdentityGroup extends StatelessWidget {
  const _IdentityGroup({required this.healthpediaId, required this.abhaId});

  final String healthpediaId;
  final String abhaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: [
          _IdentityRow(
            leading: Image.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/Flower company icon.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            value: healthpediaId,
            label: 'HPID (Healthpedia ID)',
            showDivider: true,
          ),
          _IdentityRow(
            leading: Image.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png',
              width: 28,
              height: 20,
              fit: BoxFit.contain,
            ),
            value: abhaId,
            label: 'ABHA ID',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({
    required this.leading,
    required this.value,
    required this.label,
    required this.showDivider,
  });

  final Widget leading;
  final String value;
  final String label;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.neutral200))
            : null,
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  label,
                  style: AppTypography.label3.copyWith(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              HapticFeedback.selectionClick();
              await Clipboard.setData(ClipboardData(text: value));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$label copied'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Icon(
              Icons.content_copy_outlined,
              size: AppSpacing.size24,
              color: AppColors.neutral400,
            ),
          ),
        ],
      ),
    );
  }
}
