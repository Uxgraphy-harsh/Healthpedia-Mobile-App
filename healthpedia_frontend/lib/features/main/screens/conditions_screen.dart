import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/add_condition_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_floating_cta.dart';
import 'package:healthpedia_frontend/core/constants/app_conditions.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({super.key});

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  final List<Map<String, String>> _conditions = [
    {
      'title': 'Thyroid',
      'subtitle': 'Diagnosed • early 50s',
      'iconPath': AppConditions.thyroid,
    },
    {
      'title': 'Diabetes',
      'subtitle': 'Diagnosed • early 50s',
      'iconPath': AppConditions.diabetes,
    },
    {
      'title': 'Cardiovascular',
      'subtitle': 'Diagnosed • early 50s',
      'iconPath': AppConditions.heart,
    },
  ];

  void _addCondition(String title, String subtitle, String iconPath) {
    setState(() {
      _conditions.add({
        'title': title,
        'subtitle': subtitle,
        'iconPath': iconPath,
      });
    });
  }

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _conditions.map((condition) => _ConditionCard(
            title: condition['title']!,
            subtitle: condition['subtitle']!,
            iconPath: condition['iconPath']!,
          )).toList(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: PremiumFloatingCTA(
          label: 'Add a Condition',
          icon: Icons.add_rounded,
          onTap: () => showAddConditionSheet(
            context,
            onAdd: (name, date, illustration) {
              _addCondition(name, date, illustration);
            },
          ),
        ),
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
          SvgPicture.asset(
            iconPath,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.neutral100,
                shape: BoxShape.circle,
              ),
            ),
          ),
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
