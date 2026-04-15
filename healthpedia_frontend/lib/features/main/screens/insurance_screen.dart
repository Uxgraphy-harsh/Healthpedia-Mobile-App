import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/add_insurance_bottom_sheet.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  bool _showAboutPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
              'assets/Figma MCP Assets/CommonAssets/Icons/Insurance big icon.svg',
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
            onPressed: () => setState(() => _showAboutPopup = true),
            icon: const Icon(Icons.info_outline, color: AppColors.neutral500),
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          _buildContent(),
          if (_showAboutPopup) _buildAboutPopup(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          showAddInsuranceSheet(context);
        },
        backgroundColor: const Color(0xFFFFF1F2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
          side: const BorderSide(color: Color(0xFFFFD1D5)),
        ),
        label: Text(
          'Add an Insurance Policy',
          style: AppTypography.label1.copyWith(
            color: const Color(0xFFE11D48),
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(Icons.add, color: Color(0xFFE11D48)),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.space16),
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
            iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/Health Insurance Icon.svg',
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
            iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/Life Insurance Icon.svg',
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
            iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/Term Insurance Icon.svg',
            data: {
              'Cover': '₹1 Cr',
              'Premium': '₹9,800/yr',
              'Expires': '2054',
            },
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
            iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/Vehicle Insurance Icon.svg',
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

  Widget _buildAboutPopup() {
    return GestureDetector(
      onTap: () => setState(() => _showAboutPopup = false),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Insurance',
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _showAboutPopup = false),
                        child: Text(
                          'Understood',
                          style: AppTypography.label1.copyWith(
                            color: AppColors.blue600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your insurance policies are included in the Doctor Handoff PDF and shared with emergency contacts. Keep this up to date, it can be critical.',
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
  final String iconPath;
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
    required this.iconPath,
    required this.data,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(iconPath, width: 24, height: 24, colorFilter: ColorFilter.mode(typeColor, BlendMode.srcIn)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type, style: AppTypography.label3.copyWith(color: typeColor, fontWeight: FontWeight.w600)),
                      Text(name, style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Text('Policy: $policyNumber', style: AppTypography.label3.copyWith(color: AppColors.blue600)),
                          const SizedBox(width: 4),
                          const Icon(Icons.copy, size: 12, color: AppColors.blue600),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(99)),
                  child: Text(status, style: AppTypography.label3.copyWith(color: statusColor, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: data.entries.map((e) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.value, style: AppTypography.label2.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
                    Text(e.key, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
                  ],
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/pdf_icon.svg', width: 24, height: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fileName, style: AppTypography.label2.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w500)),
                      Text('4.1 MB', style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
                    ],
                  ),
                ),
                const Icon(Icons.north_east, color: AppColors.neutral400, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
