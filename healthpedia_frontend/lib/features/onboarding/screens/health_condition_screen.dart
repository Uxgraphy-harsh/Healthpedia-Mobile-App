import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/health_trackers_screen.dart';

/// The Health Condition onboarding screen.
/// Allows the user to select existing conditions or search/add customs.
class HealthConditionScreen extends StatefulWidget {
  const HealthConditionScreen({super.key});

  @override
  State<HealthConditionScreen> createState() => _HealthConditionScreenState();
}

class _HealthConditionScreenState extends State<HealthConditionScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Example conditions matching the Figma screenshot exactly
  final List<String> availableConditions = [
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

  final Set<String> _selectedConditions = {'Hypertension'};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Repeat group 4.png',
                width: 1045,
                height: 1045,
                fit: BoxFit.cover,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                    vertical: AppSpacing.space16,
                  ),
                  child: Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2), // Inactive track
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 179.0, // 50% width per Figma (179 out of 358)
                        decoration: BoxDecoration(
                          color: AppColors.pink200, // Active indicator
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.space24),
                          // ── Title ──────────
                          const Text(
                            'Any health\ncondition?',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 56, // Title-3
                              height: 68 / 56, // line-height
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space32),

                          // ── Search Bar ──────────
                          _buildSearchBar(),

                          const SizedBox(height: AppSpacing.space24),

                          // ── Chips Wrap ──────────
                          Wrap(
                            spacing: 12.0,
                            runSpacing: 12.0,
                            children: [
                              ...availableConditions.map((condition) => _buildChip(condition)),
                              _buildCustomChip(),
                            ],
                          ),
                          
                          const SizedBox(height: 120.0), // Padding to clear bottom CTA
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Controls ──────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSpacing.space24,
                right: AppSpacing.space24,
                bottom: AppSpacing.space48,
              ),
              child: Row(
                children: [
                  // Back button
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.5),
                        width: 1,
                      ),
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space16),
                  // Continue Button
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HealthTrackersScreen()),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.pink600, // Matching dark theme button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26), // Pill shape
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: AppTypography.body3SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF), // 10% white for glass effect
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0x26FFFFFF),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.rose50, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                color: AppColors.rose50,
                fontSize: 15,
                fontFamily: 'Geist',
              ),
              decoration: InputDecoration(
                filled: false,
                hintText: 'Search condition...',
                hintStyle: TextStyle(
                  color: AppColors.rose50.withOpacity(0.5),
                  fontSize: 15,
                  fontFamily: 'Geist',
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _searchController.clear();
            },
            child: SvgPicture.asset(
              'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Clear Search.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedConditions.contains(label);
    
    // Using Figma tokens for active/inactive state
    final Color bgColor = isSelected ? const Color(0xFFFFE0E9) : const Color(0x1AFFFFFF);
    final Color textColor = isSelected ? const Color(0xFF49001E) : AppColors.rose50;
    final Color borderColor = isSelected ? Colors.transparent : const Color(0x26FFFFFF);

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
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontFamily: 'Geist',
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              SvgPicture.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/check_circle.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(Color(0xFF49001E), BlendMode.srcIn),
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
        // Implement custom add logic
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
            const Icon(
              Icons.add,
              color: AppColors.rose50,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
