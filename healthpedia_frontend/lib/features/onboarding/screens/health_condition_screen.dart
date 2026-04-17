import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/health_trackers_screen.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/add_custom_condition_bottom_sheet.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/onboarding_footer_actions.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_search_field.dart';

/// The Health Condition onboarding screen.
/// Allows the user to select existing conditions or search/add customs.
class HealthConditionScreen extends StatefulWidget {
  const HealthConditionScreen({super.key});

  @override
  State<HealthConditionScreen> createState() => _HealthConditionScreenState();
}

class _HealthConditionScreenState extends State<HealthConditionScreen> {
  final TextEditingController _searchController = TextEditingController();

  // List of conditions that can be expanded with custom entries
  late List<String> availableConditions;

  final Set<String> _selectedConditions = {'Hypertension'};

  @override
  void initState() {
    super.initState();
    availableConditions = [
      'Hypertension',
      'Asthma',
      'Arthritis',
      'Chronic Obstructive Pulmonary Disease (COPD)',
      'Cancer',
      'Heart Disease',
      'Kidney Disease',
      'Stroke',
      'Alzheimer\'s Disease',
      'Multiple Sclerosis',
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addCustomCondition(String condition) {
    setState(() {
      if (!availableConditions.contains(condition)) {
        availableConditions.add(condition);
      }
      _selectedConditions.add(condition);
    });
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (_selectedConditions.contains(condition)) {
        _selectedConditions.remove(condition);
      } else {
        _selectedConditions.add(condition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppResponsive.horizontalPadding(context);
    final titleSize = AppResponsive.onboardingTitleSize(context);
    final titleTopSpacing = AppResponsive.onboardingHeaderTopSpacing(context);
    final sectionSpacing = AppResponsive.onboardingSectionSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.maroon700,
      body: Stack(
        children: [
          // ── Background Watermark ──────────
          Positioned(
            left: -327,
            top: 351,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Repeat group 4.png',
                width: 1045,
                height: 1045,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),

          // ── Main Content ──────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Progress Bar ──────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppSpacing.space16,
                  ),
                  child: ResponsiveConstrainedContent(
                    maxWidth: AppResponsive.onboardingContentMaxWidth(context),
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.pink200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: ResponsiveConstrainedContent(
                      maxWidth: AppResponsive.onboardingContentMaxWidth(
                        context,
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: titleTopSpacing),
                          Text(
                            'Any health\ncondition?',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: titleSize,
                              height: (titleSize + 12) / titleSize,
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          SizedBox(height: sectionSpacing),

                          _buildSearchBar(),

                          const SizedBox(height: AppSpacing.space24),

                          // ── Chips Wrap ──────────
                          Wrap(
                            spacing: 12.0,
                            runSpacing: 12.0,
                            children: [
                              ...availableConditions.map(
                                (condition) => _buildChip(condition),
                              ),
                              _buildCustomChip(),
                            ],
                          ),

                          const SizedBox(height: 48),
                          SizedBox(
                            height: AppResponsive.clampBottomSpacer(
                              context,
                              min: 16,
                              max: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                OnboardingFooterActions(
                  primary: FilledButton(
                    onPressed: () {
                      context.pushPremium(const HealthTrackersScreen());
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.pink600,
                      foregroundColor: AppColors.rose950,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      textStyle: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return PremiumSearchField(
      controller: _searchController,
      placeholder: 'Search condition...',
      isDark: true,
      backgroundColor: const Color(0x1AFFFFFF),
      textColor: AppColors.rose50,
      placeholderColor: AppColors.rose50,
      minHeight: 44,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      onChanged: (value) {
        setState(() {}); // Trigger filter
      },
      onClear: () {
        _searchController.clear();
        setState(() {});
      },
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedConditions.contains(label);

    // Using Figma tokens for active/inactive state
    final Color bgColor = isSelected
        ? const Color(0xFFFFE0E9)
        : const Color(0x1AFFFFFF);
    final Color textColor = isSelected
        ? const Color(0xFF49001E)
        : AppColors.rose50;
    final Color borderColor = isSelected
        ? Colors.transparent
        : const Color(0x26FFFFFF);

    return GestureDetector(
      onTap: () => _toggleCondition(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontFamily: 'Geist',
                ),
                softWrap: true,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              SvgPicture.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/check_circle.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF49001E),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomChip() {
    return GestureDetector(
      onTap: () {
        showAddCustomConditionSheet(
          context,
          onAdded: (condition) => _addCustomCondition(condition),
        );
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0x26FFFFFF), width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Custom',
              style: TextStyle(
                color: AppColors.rose50,
                fontSize: 15,
                fontFamily: 'Geist',
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.add, color: AppColors.rose50, size: 20),
          ],
        ),
      ),
    );
  }
}
