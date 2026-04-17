import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/add_medical_record_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_floating_cta.dart';

import 'package:healthpedia_frontend/core/widgets/premium_alert_dialog.dart';
import 'package:healthpedia_frontend/core/widgets/premium_info_dialog.dart';

class FamilyHistoryScreen extends StatefulWidget {
  const FamilyHistoryScreen({super.key});

  @override
  State<FamilyHistoryScreen> createState() => _FamilyHistoryScreenState();
}

class _FamilyHistoryScreenState extends State<FamilyHistoryScreen> {
  final List<Map<String, dynamic>> _familyMembers = [
    {
      'relation': 'Father',
      'age': '79 Years',
      'name': 'Sujoy Sahu',
      'hpid': '#8836477253',
      'avatarPath':
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 82.png',
      'conditions': [
        {'name': 'Hypertension', 'date': 'Diagnosed • early 50s'},
        {'name': 'Type 2 Diabetes', 'date': 'Diagnosed • age 48'},
      ],
      'activeToday': true,
    },
    {
      'relation': 'Mother',
      'age': '79 Years',
      'name': 'Miska Sahu',
      'hpid': '#9354677563',
      'avatarPath':
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 83.png',
      'conditions': [
        {'name': 'Hypothyroidism', 'date': 'Diagnosed • late 40s'},
      ],
      'activeToday': true,
    },
  ];

  void _confirmDelete({
    required int memberIndex,
    required int conditionIndex,
    required String conditionName,
    required String memberName,
  }) {
    showDialog(
      context: context,
      builder: (context) => PremiumAlertDialog(
        title: 'Remove $conditionName?',
        description:
            'Are you sure you want to remove this record from $memberName’s history?',
        primaryLabel: 'Remove',
        isDestructive: true,
        onPrimaryPressed: () {
          setState(() {
            final member = _familyMembers[memberIndex];
            (member['conditions'] as List).removeAt(conditionIndex);

            // Auto-remove member card if no conditions remain
            if ((member['conditions'] as List).isEmpty) {
              _familyMembers.removeAt(memberIndex);
            }
          });
        },
      ),
    );
  }

  void _addMedicalRecord(String hpid, List<Map<String, String>> newConditions) {
    setState(() {
      // For demo, we either match by hpid or create a new entry
      final index = _familyMembers.indexWhere(
        (m) => m['hpid'] == hpid || m['hpid'] == '#$hpid',
      );

      if (index != -1) {
        (_familyMembers[index]['conditions'] as List).addAll(newConditions);
      } else {
        _familyMembers.add({
          'relation': 'Member',
          'age': 'Unknown',
          'name': 'New Record',
          'hpid': hpid.startsWith('#') ? hpid : '#$hpid',
          'avatarPath':
              'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 84.png',
          'conditions': newConditions,
          'activeToday': false,
        });
      }
    });
  }

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
              'assets/Figma MCP Assets/CommonAssets/Icons/Family History big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Family history',
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
                title: 'About Family History',
                description:
                    'Recording your family’s medical conditions helps Healthpedia’s AI flag hereditary risks and give you more personalised health guidance.',
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
          label: 'Add a Family Medical Record',
          icon: Icons.add_rounded,
          onTap: () => showAddMedicalRecordSheet(
            context,
            onAdd: (hpid, conditions) {
              _addMedicalRecord(hpid, conditions);
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
        children: [
          for (int i = 0; i < _familyMembers.length; i++) ...[
            _FamilyMemberCard(
              relation: _familyMembers[i]['relation'],
              age: _familyMembers[i]['age'],
              name: _familyMembers[i]['name'],
              hpid: _familyMembers[i]['hpid'],
              avatarPath: _familyMembers[i]['avatarPath'],
              activeToday: _familyMembers[i]['activeToday'],
              conditions: (_familyMembers[i]['conditions'] as List)
                  .map(
                    (c) => _FamilyCondition(name: c['name'], date: c['date']),
                  )
                  .toList(),
              onTapID: () => showDialog<void>(
                context: context,
                builder: (context) => PremiumInfoDialog(
                  title: 'Oops! You don’t have access to this profile.',
                  description:
                      'You can only see the profiles of people who has given you access to see their data.',
                  closeLabel: 'Close',
                  primaryLabel: 'Request Access',
                  onPrimaryPressed: () {},
                ),
              ),
              onEdit: () {
                showAddMedicalRecordSheet(
                  context,
                  initialHpid: _familyMembers[i]['hpid'],
                  initialConditions: (_familyMembers[i]['conditions'] as List)
                      .cast<Map<String, String>>(),
                  onAdd: (hpid, conditions) {
                    _addMedicalRecord(hpid, conditions);
                  },
                );
              },
              onDeleteCondition: (conditionIndex) => _confirmDelete(
                memberIndex: i,
                conditionIndex: conditionIndex,
                conditionName:
                    (_familyMembers[i]['conditions']
                        as List)[conditionIndex]['name'],
                memberName: _familyMembers[i]['name'],
              ),
            ),
            if (i < _familyMembers.length - 1) const SizedBox(height: 16),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _FamilyMemberCard extends StatelessWidget {
  final String relation;
  final String age;
  final String name;
  final String hpid;
  final String avatarPath;
  final bool activeToday;
  final List<_FamilyCondition> conditions;
  final VoidCallback? onTapID;
  final VoidCallback? onEdit;
  final Function(int)? onDeleteCondition;

  const _FamilyMemberCard({
    required this.relation,
    required this.age,
    required this.name,
    required this.hpid,
    required this.avatarPath,
    required this.conditions,
    this.activeToday = false,
    this.onTapID,
    this.onEdit,
    this.onDeleteCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              CircleAvatar(radius: 24, backgroundImage: AssetImage(avatarPath)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$relation • $age',
                      style: AppTypography.label3.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                    Text(
                      name,
                      style: AppTypography.label1.copyWith(
                        color: AppColors.neutral950,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapID,
                      child: Text(
                        'HPID: $hpid',
                        style: AppTypography.label3.copyWith(
                          color: const Color(0xFFE11D48),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: Text(
                      'Edit',
                      style: AppTypography.label2.copyWith(
                        color: AppColors.blue600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (activeToday)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        'Active Today',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.green600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...conditions.asMap().entries.map((entry) {
            final idx = entry.key;
            final c = entry.value;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        c.date,
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => onDeleteCondition?.call(idx),
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColors.neutral400,
                      size: 20,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FamilyCondition {
  final String name;
  final String date;
  _FamilyCondition({required this.name, required this.date});
}
