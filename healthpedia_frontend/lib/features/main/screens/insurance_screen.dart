import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/main/widgets/insurance_icon_tile.dart';
import '../widgets/add_insurance_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_info_dialog.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: AppColors.white,
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
              'assets/Figma MCP Assets/CommonAssets/Icons/shield_with_heart.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Insurance',
              style: AppTypography.h6.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => const PremiumInfoDialog(
                title: 'About Insurance',
                description:
                    'Your insurance policies are included in the Doctor Handoff PDF and shared with emergency contacts. Keep this up to date, it can be critical.',
              ),
            ),
            icon: const Icon(Icons.info_outline, color: AppColors.neutral500),
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.neutral200),
        ),
      ),
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
            right: 16,
            bottom: 40,
            child: _InsuranceFloatingCta(
              onTap: () => showAddInsuranceSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 220),
      child: Column(
        children: [
          _InsuranceCard(
            type: 'Health Insurance',
            name: 'Star Health Complete',
            policyNumber: 'SH-2024-738291',
            status: 'Expiring',
            statusColor: AppColors.orange600,
            statusBg: const Color(0xFFFFF7ED),
            typeColor: AppColors.green600,
            data: {
              'Cover': '₹10,00,000',
              'Premium': '₹12,400/yr',
              'Expires': "Dec '25",
            },
            fileName: 'SH-2024-738291.pdf',
          ),
          const SizedBox(height: 16),
          _InsuranceCard(
            type: 'Life Insurance',
            name: 'LIC Jeevan Anand',
            policyNumber: 'LIC-776421-20',
            status: 'Active',
            statusColor: AppColors.green600,
            statusBg: const Color(0xFFF0FDF4),
            typeColor: AppColors.red600,
            data: {
              'Cover': '₹50,00,000',
              'Premium': '₹28,000/yr',
              'Matures': '2045',
            },
            fileName: 'LIC-776421-20.pdf',
          ),
          const SizedBox(height: 16),
          _InsuranceCard(
            type: 'Term Insurance',
            name: 'HDFC Click 2 Protect',
            policyNumber: 'HDFC-TRM-20240089',
            status: 'Active',
            statusColor: AppColors.green600,
            statusBg: const Color(0xFFF0FDF4),
            typeColor: AppColors.indigo600,
            data: {'Cover': '₹1 Cr', 'Premium': '₹9,800/yr', 'Expires': '2054'},
            fileName: 'HDFC-TRM-20240089.pdf',
          ),
          const SizedBox(height: 16),
          _InsuranceCard(
            type: 'Vehicle Insurance',
            name: 'Bajaj Allianz Comprehensive',
            policyNumber: 'BAJ-2024-MH12AB1234',
            status: 'Active',
            statusColor: AppColors.green600,
            statusBg: const Color(0xFFF0FDF4),
            typeColor: AppColors.orange600,
            data: {
              'Vehicle': 'Honda City',
              'IDV': '₹8,20,000',
              'Expires': "Mar '26",
            },
            fileName: 'BAJ-2024-MH12AB1234.pdf',
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _InsuranceCard extends StatelessWidget {
  final String type;
  final String name;
  final String policyNumber;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final Color typeColor;
  final Map<String, String> data;
  final String fileName;

  const _InsuranceCard({
    required this.type,
    required this.name,
    required this.policyNumber,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.typeColor,
    required this.data,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                InsuranceIconTile(visual: InsuranceTypeVisuals.byLabel(type)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: AppTypography.label3.copyWith(
                          color: typeColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        name,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Policy: $policyNumber',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.label3.copyWith(
                                color: AppColors.blue500,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.blue500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            'assets/Figma MCP Assets/CommonAssets/Icons/content_copy.svg',
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blue500,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    status,
                    style: AppTypography.label3
                        .copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w400,
                        )
                        .copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          IntrinsicHeight(
            child: Row(
              children: [
                for (int i = 0; i < data.length; i++) ...[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.values.elementAt(i),
                            style: AppTypography.label2.copyWith(
                              color: AppColors.neutral950,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            data.keys.elementAt(i),
                            style: AppTypography.label3.copyWith(
                              color: AppColors.neutral500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i < data.length - 1)
                    const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: AppColors.neutral200,
                    ),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/Figma MCP Assets/CommonAssets/Icons/picture_as_pdf.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: AppTypography.label2.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '4.1 MB',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/Figma MCP Assets/CommonAssets/Icons/arrow_outward.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsuranceFloatingCta extends StatelessWidget {
  const _InsuranceFloatingCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.rose50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.pink100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/add_2.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.pink500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Add an Insurance Policy',
              style: AppTypography.label1.copyWith(
                color: AppColors.pink500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
