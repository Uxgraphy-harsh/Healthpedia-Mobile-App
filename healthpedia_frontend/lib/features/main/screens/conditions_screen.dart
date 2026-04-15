import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/add_condition_bottom_sheet.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
              width: 24,
              height: 24,
            ),
          ),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/Conditions big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Conditions',
              style: AppTypography.h6.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _ConditionCard(
              title: 'Thyroid',
              subtitle: 'Diagnosed • early 50s',
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 33.png',
            ),
            _ConditionCard(
              title: 'Diabetes',
              subtitle: 'Diagnosed • early 50s',
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 34.png',
            ),
            _ConditionCard(
              title: 'Cardiovascular',
              subtitle: 'Diagnosed • early 50s',
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 35.png',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          showAddConditionSheet(context);
        },
        backgroundColor: const Color(0xFFFFF1F2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
          side: const BorderSide(color: Color(0xFFFFD1D5)),
        ),
        label: Text(
          'Add a Condition',
          style: AppTypography.label1.copyWith(
            color: const Color(0xFFE11D48),
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(Icons.add, color: Color(0xFFE11D48)),
      ),
    );
  }
}

class _ConditionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;

  const _ConditionCard({
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Image.asset(iconPath, width: 48, height: 48),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.label3.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
