import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_switch.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _accessibilityEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
              width: 24,
            ),
          ),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/App Settings big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'App Settings',
              style: AppTypography.h6.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.neutral200, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Accessibility Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accessibility',
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Bigger fonts and icons',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                PremiumSwitch(
                  value: _accessibilityEnabled,
                  onChanged: (v) {
                    setState(() {
                      _accessibilityEnabled = v;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Grouped Selection Settings
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Column(
              children: [
                _buildSelectionRow('Language', 'English'),
                const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.neutral100),
                _buildSelectionRow('Units', 'Metric'),
                const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.neutral100),
                _buildSelectionRow('Temperature', 'Celsius', last: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionRow(String label, String value, {bool last = false}) {
    return InkWell(
      onTap: () {},
      borderRadius: last
          ? const BorderRadius.vertical(bottom: Radius.circular(16))
          : (label == 'Language'
              ? const BorderRadius.vertical(top: Radius.circular(16))
              : null),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Text(
              label,
              style: AppTypography.label1.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTypography.label1.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppColors.neutral400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
