import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_button.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});

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
              'assets/Figma MCP Assets/CommonAssets/Icons/Data & Privacy big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Data & Privacy',
                style: AppTypography.h6.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
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
          // ── Protection Info Card ──────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOW WE PROTECT YOUR DATA',
                  style: AppTypography.label3.copyWith(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  'End-to-end encryption',
                  'All health data is encrypted at rest and in transit. No one — including us — can read your data.',
                  iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/End-to-end encryption Icon.png',
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.neutral100),
                const SizedBox(height: 20),
                _buildInfoRow(
                  'Data stored in India',
                  'All your health data is stored on servers located within India, compliant with DPDP Act 2023.',
                  iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/Data stored in India Icon.png',
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Standardized Delete Button ──────────
          PremiumButton(
            label: 'Delete my Account',
            variant: PremiumButtonVariant.destructive,
            onPressed: () {
              // Handle account deletion
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String desc, {required String iconPath}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.security_rounded,
                size: 20,
                color: AppColors.blue500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral500,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
