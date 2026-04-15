import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/severity_switch.dart';
import '../widgets/add_allergy_bottom_sheet.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  bool _showAboutPopup = false;

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
              'assets/Figma MCP Assets/CommonAssets/Icons/Allergies big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Allergies',
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
          showAddAllergySheet(context);
        },
        backgroundColor: const Color(0xFFFFF1F2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
          side: const BorderSide(color: Color(0xFFFFD1D5)),
        ),
        label: Text(
          'Add an Allergy',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('DRUG & MEDICATION'),
          _AllergyCard(
            name: 'Penicillin',
            reaction: 'Causes anaphylaxis — immediate throat swelling and difficulty breathing',
            severity: AllergySeverity.severe,
          ),
          _AllergyCard(
            name: 'Sulfa drugs',
            reaction: 'Causes skin rash and itching within hours of ingestion',
            severity: AllergySeverity.moderate,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('FOOD'),
          _AllergyCard(
            name: 'Shellfish',
            reaction: 'Mild nausea and digestive discomfort',
            severity: AllergySeverity.mild,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('ENVIRONMENTAL'),
          _AllergyCard(
            name: 'Dust mites',
            reaction: 'Sneezing, watery eyes, nasal congestion — worsens at night',
            severity: AllergySeverity.mild,
          ),
          const SizedBox(height: 80), // Fab space
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTypography.label3.copyWith(
          color: AppColors.neutral500,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
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
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(20),
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
                        'About Allergies',
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
                    'Your allergies are included in the Doctor Handoff PDF and shared with emergency contacts. Keep this up to date, it can be critical.',
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral600,
                      fontWeight: FontWeight.w400,
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

class _AllergyCard extends StatelessWidget {
  final String name;
  final String reaction;
  final AllergySeverity severity;

  const _AllergyCard({
    required this.name,
    required this.reaction,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    Color severityColor;
    Color severityBg;
    String severityLabel;

    switch (severity) {
      case AllergySeverity.mild:
        severityColor = AppColors.green600;
        severityBg = const Color(0xFFF0FDF4);
        severityLabel = 'Mild';
        break;
      case AllergySeverity.moderate:
        severityColor = AppColors.orange600;
        severityBg = const Color(0xFFFFF7ED);
        severityLabel = 'Moderate';
        break;
      case AllergySeverity.severe:
        severityColor = AppColors.red600;
        severityBg = const Color(0xFFFEF2F2);
        severityLabel = 'Severe';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.delete_outline, color: AppColors.neutral400, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            reaction,
            style: AppTypography.label2.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: severityBg,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              severityLabel,
              style: AppTypography.label3.copyWith(
                color: severityColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
