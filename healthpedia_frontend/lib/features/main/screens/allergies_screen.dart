import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/severity_switch.dart';
import 'package:healthpedia_frontend/core/widgets/premium_floating_cta.dart';
import 'package:healthpedia_frontend/core/widgets/premium_alert_dialog.dart';
import 'package:healthpedia_frontend/core/widgets/premium_info_dialog.dart';
import '../widgets/add_allergy_bottom_sheet.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final List<Map<String, dynamic>> _allergies = [
    {
      'type': 'DRUG & MEDICATION',
      'items': [
        {
          'name': 'Penicillin',
          'reaction':
              'Causes anaphylaxis — immediate throat swelling and difficulty breathing',
          'severity': AllergySeverity.severe,
        },
        {
          'name': 'Sulfa drugs',
          'reaction': 'Causes skin rash and itching within hours of ingestion',
          'severity': AllergySeverity.moderate,
        },
      ],
    },
    {
      'type': 'FOOD',
      'items': [
        {
          'name': 'Shellfish',
          'reaction': 'Mild nausea and digestive discomfort',
          'severity': AllergySeverity.mild,
        },
      ],
    },
    {
      'type': 'ENVIRONMENTAL',
      'items': [
        {
          'name': 'Dust mites',
          'reaction':
              'Sneezing, watery eyes, nasal congestion — worsens at night',
          'severity': AllergySeverity.mild,
        },
      ],
    },
  ];

  void _addAllergy(
    String name,
    String reaction,
    String type,
    AllergySeverity severity,
  ) {
    setState(() {
      final category = type.toUpperCase();
      final index = _allergies.indexWhere((s) => s['type'] == category);

      final newItem = {
        'name': name,
        'reaction': reaction,
        'severity': severity,
      };

      if (index != -1) {
        (_allergies[index]['items'] as List).add(newItem);
      } else {
        _allergies.add({
          'type': category,
          'items': [newItem],
        });
      }
    });
  }

  void _confirmDelete({required int sectionIndex, required int itemIndex}) {
    showDialog(
      context: context,
      builder: (context) => PremiumAlertDialog(
        title: 'Delete Allergy?',
        description:
            'Are you sure you want to remove this allergy from your records?',
        primaryLabel: 'Delete',
        isDestructive: true,
        onPrimaryPressed: () {
          setState(() {
            (_allergies[sectionIndex]['items'] as List).removeAt(itemIndex);
            if ((_allergies[sectionIndex]['items'] as List).isEmpty) {
              _allergies.removeAt(sectionIndex);
            }
          });
        },
      ),
    );
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
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => const PremiumInfoDialog(
                title: 'About Allergies',
                description:
                    'Your allergies are included in the Doctor Handoff PDF and shared with emergency contacts. Keep this up to date, it can be critical.',
              ),
            ),
            icon: const Icon(Icons.info_outline, color: AppColors.neutral500),
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: false,
      ),
      body: _buildContent(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: PremiumFloatingCTA(
          label: 'Add an Allergy',
          icon: Icons.add_rounded,
          onTap: () => showAddAllergySheet(
            context,
            onAdd: (name, reaction, type, severity) {
              _addAllergy(name, reaction, type, severity);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _allergies.length; i++) ...[
            _buildSectionHeader(_allergies[i]['type']),
            for (int j = 0; j < _allergies[i]['items'].length; j++)
              _AllergyCard(
                name: _allergies[i]['items'][j]['name'],
                reaction: _allergies[i]['items'][j]['reaction'],
                severity: _allergies[i]['items'][j]['severity'],
                onDelete: () => _confirmDelete(sectionIndex: i, itemIndex: j),
              ),
            if (i < _allergies.length - 1) const SizedBox(height: 24),
          ],
          const SizedBox(height: 80),
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
}

class _AllergyCard extends StatelessWidget {
  final String name;
  final String reaction;
  final AllergySeverity severity;
  final VoidCallback onDelete;

  const _AllergyCard({
    required this.name,
    required this.reaction,
    required this.severity,
    required this.onDelete,
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
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.neutral400,
                  size: 20,
                ),
              ),
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
