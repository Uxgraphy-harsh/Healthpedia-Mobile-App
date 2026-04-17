import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_avatars.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_select.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_stepper.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/health_condition_screen.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/onboarding_footer_actions.dart';

class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  final List<Map<String, dynamic>> avatarSelection = [
    for (final avatar in AppAvatars.all) {'type': 'asset', 'value': avatar},
  ];

  late final PageController _avatarController;
  final _nameController = TextEditingController();

  int selectedAvatarIndex = 2;
  int _height = 170;
  int _weight = 70;
  DateTime? _selectedDate;
  String? _selectedGender;

  static const _onboardingFieldFill = Color(0x1AFFFFFF);
  static const _onboardingFieldText = AppColors.rose50;

  @override
  void initState() {
    super.initState();
    _avatarController = PageController(
      viewportFraction: 0.25,
      initialPage: selectedAvatarIndex,
    );
  }

  @override
  void dispose() {
    _avatarController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppResponsive.horizontalPadding(context);
    final titleSize = AppResponsive.onboardingTitleSize(context);
    final titleTopSpacing = AppResponsive.onboardingHeaderTopSpacing(context);
    final sectionSpacing = AppResponsive.onboardingSectionSpacing(context);
    final avatarRailHeight = AppResponsive.onboardingAvatarRailHeight(context);

    return Scaffold(
      backgroundColor: AppColors.maroon700,
      body: Stack(
        children: [
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppSpacing.space16,
                  ),
                  child: ResponsiveConstrainedContent(
                    maxWidth: AppResponsive.onboardingContentMaxWidth(context),
                    alignment: Alignment.topLeft,
                    child: _buildProgressBar(progress: 0.25),
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
                            'Please enter basic details',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: titleSize,
                              height: (titleSize + 12) / titleSize,
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          SizedBox(
                            height: avatarRailHeight,
                            child: PageView.builder(
                              controller: _avatarController,
                              clipBehavior: Clip.none,
                              itemCount: avatarSelection.length,
                              onPageChanged: (index) {
                                setState(() => selectedAvatarIndex = index);
                              },
                              itemBuilder: (context, index) {
                                final avatar = avatarSelection[index];
                                final isSelected = index == selectedAvatarIndex;
                                final avatarSize =
                                    AppResponsive.onboardingAvatarSize(
                                      context,
                                      selected: isSelected,
                                    );

                                return GestureDetector(
                                  onTap: () {
                                    _avatarController.animateToPage(
                                      index,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: isSelected ? 1 : 0.7,
                                    child: Center(
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        curve: Curves.easeOut,
                                        width: avatarSize,
                                        height: avatarSize,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.white
                                                : Colors.transparent,
                                            width: isSelected ? 3 : 0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            avatarSize / 2,
                                          ),
                                          child: avatar['type'] == 'asset'
                                              ? Image.asset(
                                                  avatar['value'] as String,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  avatar['value'] as String,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          PremiumTextField(
                            controller: _nameController,
                            placeholder: 'Name',
                            isDark: true,
                            backgroundColor: _onboardingFieldFill,
                            textColor: _onboardingFieldText,
                            placeholderColor: _onboardingFieldText,
                            minHeight: 55,
                            borderRadius: 8,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space20),
                          PremiumTextField(
                            valueText: _selectedDate == null
                                ? null
                                : '${_selectedDate!.day.toString().padLeft(2, '0')} / ${_selectedDate!.month.toString().padLeft(2, '0')} / ${_selectedDate!.year}',
                            placeholder: 'Date of Birth',
                            readOnly: true,
                            isDark: true,
                            backgroundColor: _onboardingFieldFill,
                            textColor: _onboardingFieldText,
                            placeholderColor: _onboardingFieldText,
                            suffixIcon: Icons.calendar_today_outlined,
                            minHeight: 55,
                            borderRadius: 8,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate ?? DateTime(2000),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() => _selectedDate = date);
                              }
                            },
                          ),
                          const SizedBox(height: AppSpacing.space20),
                          PremiumSelect<String>(
                            value: _selectedGender,
                            placeholder: 'Gender',
                            items: const ['Male', 'Female', 'Other'],
                            isDark: true,
                            backgroundColor: _onboardingFieldFill,
                            textColor: _onboardingFieldText,
                            placeholderColor: _onboardingFieldText,
                            minHeight: 55,
                            borderRadius: 8,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            onChanged: (value) {
                              setState(() => _selectedGender = value);
                            },
                          ),
                          const SizedBox(height: AppSpacing.space20),
                          Row(
                            children: [
                              Expanded(
                                child: PremiumStepper(
                                  unit: 'cm',
                                  value: _height,
                                  min: 50,
                                  max: 250,
                                  placeholder: 'Height (cm)',
                                  isDark: true,
                                  backgroundColor: _onboardingFieldFill,
                                  textColor: _onboardingFieldText,
                                  placeholderColor: _onboardingFieldText,
                                  minHeight: 55,
                                  borderRadius: 8,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  showUnitHint: false,
                                  onChanged: (value) =>
                                      setState(() => _height = value),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.space16),
                              Expanded(
                                child: PremiumStepper(
                                  unit: 'kg',
                                  value: _weight,
                                  min: 10,
                                  max: 300,
                                  placeholder: 'Weight (kg)',
                                  isDark: true,
                                  backgroundColor: _onboardingFieldFill,
                                  textColor: _onboardingFieldText,
                                  placeholderColor: _onboardingFieldText,
                                  minHeight: 55,
                                  borderRadius: 8,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  showUnitHint: false,
                                  onChanged: (value) =>
                                      setState(() => _weight = value),
                                ),
                              ),
                            ],
                          ),
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
                      context.pushPremium(const HealthConditionScreen());
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

  Widget _buildProgressBar({required double progress}) {
    return Container(
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress.clamp(0, 1),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.pink200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
