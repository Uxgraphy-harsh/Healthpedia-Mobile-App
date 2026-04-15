import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/main/screens/family_friend_detail_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/report_folder_screen.dart';

Route<void> createFamilyFriendSectionRoute(
  FamilyFriendSection section, {
  required String memberName,
}) {
  switch (section.label) {
    case 'Conditions':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendConditionsScreen(memberName: memberName),
      );
    case 'Prescriptions':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendPrescriptionsScreen(memberName: memberName),
      );
    case 'Allergies':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendAllergiesScreen(memberName: memberName),
      );
    case 'Reports':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendReportsScreen(memberName: memberName),
      );
    case 'Symptoms':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendSymptomsScreen(memberName: memberName),
      );
    case 'Family History':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendFamilyHistoryScreen(memberName: memberName),
      );
    case 'Insurance':
      return MaterialPageRoute(
        builder: (_) => FamilyFriendInsuranceScreen(memberName: memberName),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => FamilyFriendConditionsScreen(memberName: memberName),
      );
  }
}

class FamilyFriendConditionsScreen extends StatelessWidget {
  const FamilyFriendConditionsScreen({super.key, required this.memberName});

  final String memberName;

  static const _cards = [
    _ConditionCardData(
      title: 'Thyroid',
      subtitle: 'Diagnosed • early 50s',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 33.png',
    ),
    _ConditionCardData(
      title: 'Diabetes',
      subtitle: 'Diagnosed • early 50s',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 34.png',
    ),
    _ConditionCardData(
      title: 'Cardiovascular',
      subtitle: 'Diagnosed • early 50s',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 35.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Conditions',
              leading: SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/Conditions big icon.svg',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space16),
                child: Wrap(
                  spacing: AppSpacing.space12,
                  runSpacing: AppSpacing.space12,
                  children: _cards
                      .map(
                        (card) => _ConditionCard(
                          data: card,
                          width: (MediaQuery.of(context).size.width - 44) / 2,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendPrescriptionsScreen extends StatelessWidget {
  const FamilyFriendPrescriptionsScreen({super.key, required this.memberName});

  final String memberName;

  static const _rows = [
    ['Hospital / Lab', 'SRL Diagnostics, Baner'],
    ['Referring doctor', 'Dr. Meena Sharma'],
    ['Report date', '14 Jan 2025'],
    ['Sample collected', '14 Jan  •  7:30 AM'],
    ['Lab reference', 'SRL/PUN/25/004821'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Prescriptions',
              leading: const Text('💊', style: TextStyle(fontSize: 24)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('PRESCRIPTION DETAILS'),
                    const SizedBox(height: AppSpacing.space12),
                    _DetailsTable(rows: _rows),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('PRESCRIBED MEDICINES'),
                    const SizedBox(height: AppSpacing.space12),
                    const _PrescriptionCarousel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendAllergiesScreen extends StatelessWidget {
  const FamilyFriendAllergiesScreen({super.key, required this.memberName});

  final String memberName;

  static const _drugAllergies = [
    _AllergyCardData(
      name: 'Penicillin',
      reaction:
          'Causes anaphylaxis — immediate throat swelling and difficulty breathing',
      severity: 'Severe',
      severityColor: AppColors.red500,
      severityBg: AppColors.red50,
    ),
    _AllergyCardData(
      name: 'Sulfa drugs',
      reaction: 'Causes skin rash and itching within hours of ingestion',
      severity: 'Moderate',
      severityColor: AppColors.orange600,
      severityBg: AppColors.orange50,
    ),
  ];

  static const _foodAllergies = [
    _AllergyCardData(
      name: 'Shellfish',
      reaction: 'Mild nausea and digestive discomfort',
      severity: 'Mild',
      severityColor: AppColors.green600,
      severityBg: AppColors.green50,
    ),
  ];

  static const _environmentalAllergies = [
    _AllergyCardData(
      name: 'Dust mites',
      reaction: 'Sneezing, watery eyes, nasal congestion — worsens at night',
      severity: 'Mild',
      severityColor: AppColors.green600,
      severityBg: AppColors.green50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Allergies',
              leading: SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/allergy.svg',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('DRUG & MEDICATION'),
                    const SizedBox(height: AppSpacing.space12),
                    ..._drugAllergies.map(_ReadOnlyAllergyCard.new),
                    const SizedBox(height: AppSpacing.space20),
                    _sectionTitle('FOOD'),
                    const SizedBox(height: AppSpacing.space12),
                    ..._foodAllergies.map(_ReadOnlyAllergyCard.new),
                    const SizedBox(height: AppSpacing.space20),
                    _sectionTitle('ENVIRONMENTAL'),
                    const SizedBox(height: AppSpacing.space12),
                    ..._environmentalAllergies.map(_ReadOnlyAllergyCard.new),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendReportsScreen extends StatelessWidget {
  const FamilyFriendReportsScreen({super.key, required this.memberName});

  final String memberName;

  static const _cards = [
    _ReportFolderCardData(
      title: 'Thyroid',
      updated: '14 Jan 2025',
      fileCount: 6,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 33.png',
    ),
    _ReportFolderCardData(
      title: 'Diabetes',
      updated: '14 Jan 2025',
      fileCount: 4,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 34.png',
    ),
    _ReportFolderCardData(
      title: 'Cardiovascular',
      updated: '2 Nov 2024',
      fileCount: 3,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 35.png',
    ),
    _ReportFolderCardData(
      title: 'General',
      updated: '2 Nov 2024',
      fileCount: 8,
      imagePath: 'assets/Figma MCP Assets/CommonAssets/Images/Report Image.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Reports',
              leading: SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/folder_open.svg',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space16),
                child: Wrap(
                  spacing: AppSpacing.space12,
                  runSpacing: AppSpacing.space12,
                  children: _cards
                      .map(
                        (card) => _ReportFolderCard(
                          data: card,
                          memberName: memberName,
                          width: (MediaQuery.of(context).size.width - 44) / 2,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendSymptomsScreen extends StatelessWidget {
  const FamilyFriendSymptomsScreen({super.key, required this.memberName});

  final String memberName;

  static const _entries = [
    _SymptomListEntry(
      name: 'Fatigue',
      lastLogged: 'Today, 3:00 PM',
      timesLogged: 3,
      isPassed: true,
    ),
    _SymptomListEntry(
      name: 'Throat tightness',
      lastLogged: 'Today, 8:00 PM',
      timesLogged: 7,
      isPassed: true,
    ),
    _SymptomListEntry(
      name: 'Dizziness',
      lastLogged: '21 Mar, 6:12 PM',
      timesLogged: 2,
      isPassed: true,
    ),
    _SymptomListEntry(
      name: 'Headache',
      lastLogged: '20 Mar, 9:42 PM',
      timesLogged: 8,
      isPassed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Symptoms',
              leading: const Text('🤒', style: TextStyle(fontSize: 24)),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.space16),
                itemCount: _entries.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.space8),
                itemBuilder: (context, index) => _MemberSymptomCard(
                  entry: _entries[index],
                  memberName: memberName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendFamilyHistoryScreen extends StatelessWidget {
  const FamilyFriendFamilyHistoryScreen({super.key, required this.memberName});

  final String memberName;

  static const _cards = [
    _FamilyHistoryCardData(
      relation: 'Father',
      age: '79 Years',
      name: 'Sujoy Sahu',
      hpid: '#8836477253',
      avatarPath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
      avatarBackgroundColor: AppColors.red100,
      status: 'Active Today',
      conditions: [
        _FamilyHistoryCondition('Hypertension', 'Diagnosed • early 50s'),
        _FamilyHistoryCondition('Type 2 Diabetes', 'Diagnosed • age 48'),
      ],
    ),
    _FamilyHistoryCardData(
      relation: 'Mother',
      age: '79 Years',
      name: 'Miska Sahu',
      hpid: '#9354677563',
      avatarPath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/F 84.png',
      avatarBackgroundColor: AppColors.yellow100,
      status: 'Active Today',
      conditions: [
        _FamilyHistoryCondition('Hypothyroidism', 'Diagnosed • late 40s'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Family history',
              leading: SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/Family History big icon.svg',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.space16),
                itemCount: _cards.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.space16),
                itemBuilder: (_, index) =>
                    _FamilyHistoryReadOnlyCard(data: _cards[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyFriendInsuranceScreen extends StatelessWidget {
  const FamilyFriendInsuranceScreen({super.key, required this.memberName});

  final String memberName;

  static const _cards = [
    _InsuranceCardData(
      type: 'Health Insurance',
      name: 'Star Health Complete',
      policyNumber: 'SH-2024-738291',
      status: 'Expiring',
      statusColor: AppColors.orange600,
      statusBg: AppColors.orange50,
      typeColor: AppColors.green600,
      iconPath:
          'assets/Figma MCP Assets/CommonAssets/Icons/Health Insurance Icon.svg',
      fileName: 'SH-2024-738291.pdf',
      fileSize: '4.1 MB',
      data: ['₹10,00,000', '₹12,400/yr', "Dec '25"],
      labels: ['Cover', 'Premium', 'Expires'],
    ),
    _InsuranceCardData(
      type: 'Life Insurance',
      name: 'LIC Jeevan Anand',
      policyNumber: 'LIC-776421-20',
      status: 'Active',
      statusColor: AppColors.green600,
      statusBg: AppColors.green50,
      typeColor: AppColors.red600,
      iconPath:
          'assets/Figma MCP Assets/CommonAssets/Icons/Life Insurance Icon.svg',
      fileName: 'LIC-776421-20.pdf',
      fileSize: '4.1 MB',
      data: ['₹50,00,000', '₹28,000/yr', '2045'],
      labels: ['Cover', 'Premium', 'Matures'],
    ),
    _InsuranceCardData(
      type: 'Term Insurance',
      name: 'HDFC Click 2 Protect',
      policyNumber: 'HDFC-TRM-20240089',
      status: 'Active',
      statusColor: AppColors.green600,
      statusBg: AppColors.green50,
      typeColor: AppColors.indigo600,
      iconPath:
          'assets/Figma MCP Assets/CommonAssets/Icons/Term Insurance Icon.svg',
      fileName: 'HDFC-TRM-20240089.pdf',
      fileSize: '4.1 MB',
      data: ['₹1 Cr', '₹9,800/yr', '2054'],
      labels: ['Cover', 'Premium', 'Expires'],
    ),
    _InsuranceCardData(
      type: 'Vehicle Insurance',
      name: 'Bajaj Allianz Comprehensive',
      policyNumber: 'BAJ-2024-MH12AB1234',
      status: 'Active',
      statusColor: AppColors.green600,
      statusBg: AppColors.green50,
      typeColor: AppColors.amber600,
      iconPath:
          'assets/Figma MCP Assets/CommonAssets/Icons/Vehicle Insurance Icon.svg',
      fileName: 'BAJ-2024-MH12AB1234.pdf',
      fileSize: '4.1 MB',
      data: ['Honda City', '₹8,20,000', "Mar '26"],
      labels: ['Vehicle', 'IDV', 'Expires'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SectionHeader(
              title: 'Insurance',
              leading: SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/Insurance big icon.svg',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.space16),
                itemCount: _cards.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.space16),
                itemBuilder: (_, index) =>
                    _ReadOnlyInsuranceCard(data: _cards[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.leading});

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.neutral500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.space16),
            leading,
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space8,
                ),
                child: Text(
                  title,
                  style: AppTypography.h6.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Text _sectionTitle(String title) => Text(
  title,
  style: const TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.56,
    color: AppColors.neutral500,
  ),
);

class _ConditionCardData {
  const _ConditionCardData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  final String title;
  final String subtitle;
  final String imagePath;
}

class _ConditionCard extends StatelessWidget {
  const _ConditionCard({required this.data, required this.width});

  final _ConditionCardData data;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 111,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.imagePath, width: 40, height: 40),
          const SizedBox(height: AppSpacing.space12),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.label3.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsTable extends StatelessWidget {
  const _DetailsTable({required this.rows});

  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final isLast = entry.key == rows.length - 1;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space14,
            ),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : const Border(
                      bottom: BorderSide(color: AppColors.neutral200),
                    ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.value[0],
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Flexible(
                  child: Text(
                    entry.value[1],
                    textAlign: TextAlign.right,
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral950,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PrescriptionCarousel extends StatelessWidget {
  const _PrescriptionCarousel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 2 ? 12 : 0),
            child: const _PrescriptionCard(),
          ),
        ),
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.neutral200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: Image.asset(
                  'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(color: AppColors.neutral200),
                  ),
                  child: Text(
                    '1x',
                    style: AppTypography.label3.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Row(
            children: List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.only(right: index == 0 ? 8 : 0),
                width: 44,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(
                    color: index == 0
                        ? AppColors.neutral950
                        : AppColors.neutral200,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Thyrox 50 Tablet',
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            '~ Before food',
            style: AppTypography.body3.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(height: AppSpacing.space10),
          Row(
            children: const [
              _TimingPill(active: true, label: '☀'),
              SizedBox(width: 6),
              _TimingPill(active: false, label: 'L'),
              SizedBox(width: 6),
              _TimingPill(active: false, label: 'D'),
              SizedBox(width: 6),
              _TimingPill(active: false, label: '◐'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimingPill extends StatelessWidget {
  const _TimingPill({required this.active, required this.label});

  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: active ? AppColors.blue500 : AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: active ? AppColors.blue500 : AppColors.neutral300,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: AppTypography.label3.copyWith(
          color: active ? AppColors.white : AppColors.neutral500,
        ),
      ),
    );
  }
}

class _AllergyCardData {
  const _AllergyCardData({
    required this.name,
    required this.reaction,
    required this.severity,
    required this.severityColor,
    required this.severityBg,
  });

  final String name;
  final String reaction;
  final String severity;
  final Color severityColor;
  final Color severityBg;
}

class _ReadOnlyAllergyCard extends StatelessWidget {
  const _ReadOnlyAllergyCard(this.data);

  final _AllergyCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space12),
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            data.reaction,
            style: AppTypography.body1.copyWith(
              color: AppColors.neutral600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: data.severityBg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: data.severityColor.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              data.severity,
              style: AppTypography.label2.copyWith(color: data.severityColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportFolderCardData {
  const _ReportFolderCardData({
    required this.title,
    required this.updated,
    required this.fileCount,
    required this.imagePath,
  });

  final String title;
  final String updated;
  final int fileCount;
  final String imagePath;
}

class _ReportFolderCard extends StatelessWidget {
  const _ReportFolderCard({
    required this.data,
    required this.width,
    required this.memberName,
  });

  final _ReportFolderCardData data;
  final double width;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FamilyFriendReportFolderScreen(
              memberName: memberName,
              folderTitle: data.title,
              totalFiles: data.fileCount,
              entries: _reportEntriesFor(data.title, data.fileCount),
            ),
          ),
        );
      },
      child: Container(
        width: width,
        height: 149,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              data.imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSpacing.space12),
            Text(
              data.title,
              style: AppTypography.label1.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Updated • ${data.updated}',
              style: AppTypography.body3.copyWith(color: AppColors.neutral500),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(color: AppColors.neutral200),
              ),
              child: Text(
                '${data.fileCount} files',
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SymptomListEntry {
  const _SymptomListEntry({
    required this.name,
    required this.lastLogged,
    required this.timesLogged,
    required this.isPassed,
  });

  final String name;
  final String lastLogged;
  final int timesLogged;
  final bool isPassed;
}

class _MemberSymptomCard extends StatelessWidget {
  const _MemberSymptomCard({required this.entry, required this.memberName});

  final _SymptomListEntry entry;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _FamilyFriendSymptomDetailScreen(
              memberName: memberName,
              entry: entry,
            ),
          ),
        );
      },
      child: Container(
        height: 79,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last logged • ${entry.lastLogged}',
                    style: AppTypography.label3.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        entry.name,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space8),
                      _SymptomStatusBadge(isPassed: entry.isPassed),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '${entry.timesLogged} times logged',
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.neutral500,
            ),
          ],
        ),
      ),
    );
  }
}

class _SymptomStatusBadge extends StatelessWidget {
  const _SymptomStatusBadge({required this.isPassed});

  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isPassed ? const Color(0x193B82F6) : const Color(0x40FED7AA),
        border: Border.all(
          color: isPassed ? const Color(0x193B82F6) : const Color(0x40FED7AA),
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        isPassed ? 'Passed' : 'Ongoing',
        style: AppTypography.label3.copyWith(
          color: isPassed ? AppColors.blue600 : AppColors.orange700,
        ),
      ),
    );
  }
}

class FamilyFriendReportFolderScreen extends StatefulWidget {
  const FamilyFriendReportFolderScreen({
    super.key,
    required this.memberName,
    required this.folderTitle,
    required this.totalFiles,
    required this.entries,
  });

  final String memberName;
  final String folderTitle;
  final int totalFiles;
  final List<ReportEntry> entries;

  @override
  State<FamilyFriendReportFolderScreen> createState() =>
      _FamilyFriendReportFolderScreenState();
}

class _FamilyFriendReportFolderScreenState
    extends State<FamilyFriendReportFolderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(
        () => _searchQuery = _searchController.text.trim().toLowerCase(),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReportEntry> get _filteredEntries {
    if (_searchQuery.isEmpty) {
      return widget.entries;
    }

    return widget.entries.where((entry) {
      return entry.labName.toLowerCase().contains(_searchQuery) ||
          entry.doctorRef.toLowerCase().contains(_searchQuery) ||
          entry.note.toLowerCase().contains(_searchQuery) ||
          entry.files.any(
            (file) => file.name.toLowerCase().contains(_searchQuery),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <int, List<ReportEntry>>{};
    for (final entry in _filteredEntries) {
      grouped.putIfAbsent(entry.year, () => []).add(entry);
    }
    final sortedYears = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _FamilyFriendFolderHeader(
              title: widget.folderTitle,
              totalFiles: widget.totalFiles,
              controller: _searchController,
              hasText: _searchQuery.isNotEmpty,
              onClear: () {
                _searchController.clear();
                FocusScope.of(context).unfocus();
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space40,
                ),
                children: [
                  for (int i = 0; i < sortedYears.length; i++) ...[
                    if (i > 0)
                      _FamilyFriendYearDivider(year: '${sortedYears[i]}'),
                    ...grouped[sortedYears[i]]!.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.space8,
                        ),
                        child: _FamilyFriendReportEntryCard(entry: entry),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendFolderHeader extends StatelessWidget {
  const _FamilyFriendFolderHeader({
    required this.title,
    required this.totalFiles,
    required this.controller,
    required this.hasText,
    required this.onClear,
  });

  final String title;
  final int totalFiles;
  final TextEditingController controller;
  final bool hasText;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      padding: const EdgeInsets.only(bottom: AppSpacing.space16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox(
                    width: AppSpacing.size40,
                    height: AppSpacing.size40,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: AppSpacing.size24,
                        color: AppColors.neutral950,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.space8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.h6.copyWith(
                            color: AppColors.neutral950,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          '$totalFiles FILES TOTAL',
                          style: AppTypography.label3.copyWith(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.48,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppSpacing.size44,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.neutral300),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusFull,
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: AppSpacing.space12),
                        const Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.neutral400,
                        ),
                        const SizedBox(width: AppSpacing.space4),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            style: AppTypography.body3.copyWith(
                              color: AppColors.neutral950,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search report name, symptom, note...',
                              hintStyle: AppTypography.body3.copyWith(
                                color: AppColors.neutral400,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            cursorColor: AppColors.neutral950,
                          ),
                        ),
                        if (hasText)
                          GestureDetector(
                            onTap: onClear,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                right: AppSpacing.space10,
                              ),
                              child: Icon(
                                Icons.cancel_rounded,
                                size: 20,
                                color: AppColors.neutral400,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: AppSpacing.space12),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Container(
                  width: AppSpacing.size44,
                  height: AppSpacing.size44,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.neutral300),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    size: 20,
                    color: AppColors.neutral600,
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

class _FamilyFriendYearDivider extends StatelessWidget {
  const _FamilyFriendYearDivider({required this.year});

  final String year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: AppColors.neutral200, thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: Text(
              year,
              style: AppTypography.label3.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.48,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: AppColors.neutral200, thickness: 1),
          ),
        ],
      ),
    );
  }
}

class _FamilyFriendReportEntryCard extends StatelessWidget {
  const _FamilyFriendReportEntryCard({required this.entry});

  final ReportEntry entry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FamilyFriendReportDetailScreen(
              labName: entry.labName,
              dateLabel: '${entry.day} ${entry.month}, ${entry.year}',
            ),
          ),
        );
      },
      child: Container(
        height: 259,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space10,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.space8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pink950,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${entry.day}',
                        style: AppTypography.h6.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        entry.month,
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${entry.year}',
                        style: AppTypography.caption1.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.fileCount} files • ${entry.fileTypeLabel}',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space2),
                      Text(
                        entry.labName,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        entry.doctorRef,
                        style: AppTypography.label2.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.neutral500,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            const Divider(height: 1, color: AppColors.neutral200),
            const SizedBox(height: AppSpacing.space12),
            Text(
              entry.note,
              style: AppTypography.label3.copyWith(
                color: AppColors.neutral950,
                height: 1.35,
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            const Divider(height: 1, color: AppColors.neutral200),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space8,
              children: entry.files
                  .map((file) => _FamilyFriendThumbnailPill(file: file))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendThumbnailPill extends StatelessWidget {
  const _FamilyFriendThumbnailPill({required this.file});

  final ReportFile file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            file.isPdf ? Icons.picture_as_pdf_outlined : Icons.image_outlined,
            size: 16,
            color: file.isPdf ? AppColors.red500 : AppColors.blue500,
          ),
          const SizedBox(width: AppSpacing.space4),
          Text(
            file.name,
            style: AppTypography.label3.copyWith(color: AppColors.neutral700),
          ),
        ],
      ),
    );
  }
}

class FamilyFriendReportDetailScreen extends StatelessWidget {
  const FamilyFriendReportDetailScreen({
    super.key,
    required this.labName,
    required this.dateLabel,
  });

  final String labName;
  final String dateLabel;

  static const _resultRows = [
    _FamilyFriendResultRow(
      parameter: 'TSH',
      parameterSub: 'Thyroid stimulating hormone',
      result: '6.2',
      unit: 'mIU/L',
      normalRange: '0.4 – 4.0',
      isAbnormal: true,
    ),
    _FamilyFriendResultRow(
      parameter: 'Free T3',
      parameterSub: 'Triiodothyronine',
      result: '3.1',
      unit: 'pg/mL',
      normalRange: '2.3 – 4.2',
    ),
    _FamilyFriendResultRow(
      parameter: 'Free T4',
      parameterSub: 'Thyroxine',
      result: '0.9',
      unit: 'ng/dL',
      normalRange: '0.8 – 1.8',
    ),
    _FamilyFriendResultRow(
      parameter: 'Anti-TPO',
      parameterSub: 'Thyroid peroxidase Ab',
      result: '42',
      unit: 'IU/mL',
      normalRange: '0 – 34',
      isAbnormal: true,
    ),
  ];

  static const _attachments = [
    _FamilyFriendAttachment(
      name: 'Thyroid_Jan25.pdf',
      size: '24.4 MB',
      isPdf: true,
    ),
    _FamilyFriendAttachment(
      name: 'Report_p1.jpg',
      size: '1.7 MB',
      isPdf: false,
    ),
    _FamilyFriendAttachment(
      name: 'Report_p2.jpg',
      size: '1.7 MB',
      isPdf: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _FamilyFriendDetailHeader(
              title: labName,
              subtitle: dateLabel.toUpperCase(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.space16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.neutral200),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radius2xl,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DOCTOR'S IMPRESSION",
                            style: AppTypography.label3.copyWith(
                              color: AppColors.neutral500,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space8),
                          Text(
                            '"TSH elevated. Anti-TPO borderline positive. Patient on Eltroxin 50mcg — consider dose titration to 75mcg. Retest TSH and Anti-TPO after 6 weeks. Continue current diet and sleep schedule."',
                            style: AppTypography.label1.copyWith(
                              color: AppColors.neutral950,
                              fontWeight: FontWeight.w500,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space8),
                          Text(
                            '– Dr. Meena Sharma, Endocrinologist',
                            style: AppTypography.label2.copyWith(
                              color: AppColors.neutral600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('REPORT DETAILS'),
                    const SizedBox(height: AppSpacing.space12),
                    const _DetailsTable(
                      rows: [
                        ['Hospital / Lab', 'SRL Diagnostics, Baner'],
                        ['Referring doctor', 'Dr. Meena Sharma'],
                        ['Report date', '14 Jan 2025'],
                        ['Sample collected', '14 Jan  •  7:30 AM'],
                        ['Lab reference', 'SRL/PUN/25/004821'],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('VITALS AT TIME OF TEST'),
                    const SizedBox(height: AppSpacing.space12),
                    const _FamilyFriendVitalsRow(),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('RESULTS'),
                    const SizedBox(height: AppSpacing.space12),
                    _FamilyFriendResultsTable(rows: _resultRows),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('PRESCRIPTIONS'),
                    const SizedBox(height: AppSpacing.space12),
                    const _PrescriptionCarousel(),
                    const SizedBox(height: AppSpacing.space24),
                    _sectionTitle('ATTACHMENTS'),
                    const SizedBox(height: AppSpacing.space12),
                    ..._attachments.map(
                      (attachment) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.space12,
                        ),
                        child: _FamilyFriendAttachmentCard(
                          attachment: attachment,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendDetailHeader extends StatelessWidget {
  const _FamilyFriendDetailHeader({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: AppSpacing.size40,
                height: AppSpacing.size40,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: AppSpacing.size24,
                    color: AppColors.neutral950,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.space16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.h6.copyWith(
                        color: AppColors.neutral950,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      subtitle,
                      style: AppTypography.label3.copyWith(
                        color: AppColors.neutral500,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.48,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (trailing != null) ...[trailing!],
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendVitalsRow extends StatelessWidget {
  const _FamilyFriendVitalsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _FamilyFriendVitalCard(
            icon: Icons.monitor_weight_outlined,
            value: '58',
            suffix: 'kg',
            label: 'Weight',
          ),
        ),
        SizedBox(width: AppSpacing.space8),
        Expanded(
          child: _FamilyFriendVitalCard(
            icon: Icons.monitor_heart_outlined,
            value: '20.3',
            label: 'BMI',
          ),
        ),
        SizedBox(width: AppSpacing.space8),
        Expanded(
          child: _FamilyFriendVitalCard(
            icon: Icons.favorite_outline,
            value: '118/76',
            label: 'BP',
          ),
        ),
      ],
    );
  }
}

class _FamilyFriendVitalCard extends StatelessWidget {
  const _FamilyFriendVitalCard({
    required this.icon,
    required this.value,
    required this.label,
    this.suffix,
  });

  final IconData icon;
  final String value;
  final String label;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppColors.neutral700),
          const SizedBox(height: AppSpacing.space4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: AppTypography.h5SemiBold.copyWith(
                    color: AppColors.neutral950,
                  ),
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: AppSpacing.space4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    suffix!,
                    style: AppTypography.label2.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            label,
            style: AppTypography.label3.copyWith(color: AppColors.neutral500),
          ),
        ],
      ),
    );
  }
}

class _FamilyFriendResultRow {
  const _FamilyFriendResultRow({
    required this.parameter,
    required this.parameterSub,
    required this.result,
    required this.unit,
    required this.normalRange,
    this.isAbnormal = false,
  });

  final String parameter;
  final String parameterSub;
  final String result;
  final String unit;
  final String normalRange;
  final bool isAbnormal;
}

class _FamilyFriendResultsTable extends StatelessWidget {
  const _FamilyFriendResultsTable({required this.rows});

  final List<_FamilyFriendResultRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral100),
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.neutral100)),
            ),
            child: Row(
              children: const [
                _FamilyFriendResultHeaderCell(label: 'PARAMETER'),
                _FamilyFriendResultHeaderCell(label: 'RESULT'),
                _FamilyFriendResultHeaderCell(label: 'NORMAL RANGE'),
              ],
            ),
          ),
          ...rows.asMap().entries.map((entry) {
            final row = entry.value;
            final isLast = entry.key == rows.length - 1;
            return Row(
              children: [
                _FamilyFriendResultValueCell(
                  text: row.parameter,
                  subtitle: row.parameterSub,
                  highlight: row.isAbnormal,
                  showBottomBorder: !isLast,
                ),
                _FamilyFriendResultValueCell(
                  text: row.result,
                  subtitle: row.unit,
                  highlight: row.isAbnormal,
                  showBottomBorder: !isLast,
                ),
                _FamilyFriendResultValueCell(
                  text: row.normalRange,
                  highlight: row.isAbnormal,
                  showBottomBorder: !isLast,
                  compact: true,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _FamilyFriendResultHeaderCell extends StatelessWidget {
  const _FamilyFriendResultHeaderCell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space8),
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: AppColors.neutral100)),
        ),
        child: Text(
          label,
          style: AppTypography.caption1.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _FamilyFriendResultValueCell extends StatelessWidget {
  const _FamilyFriendResultValueCell({
    required this.text,
    this.subtitle,
    required this.highlight,
    required this.showBottomBorder,
    this.compact = false,
  });

  final String text;
  final String? subtitle;
  final bool highlight;
  final bool showBottomBorder;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space8,
          vertical: AppSpacing.space12,
        ),
        decoration: BoxDecoration(
          color: highlight ? AppColors.yellow50 : AppColors.white,
          border: Border(
            right: const BorderSide(color: AppColors.neutral100),
            bottom: showBottomBorder
                ? const BorderSide(color: AppColors.neutral100)
                : BorderSide.none,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTypography.label3.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.space4),
              Text(
                subtitle!,
                style:
                    (compact ? AppTypography.caption1 : AppTypography.caption1)
                        .copyWith(color: AppColors.neutral500),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendAttachment {
  const _FamilyFriendAttachment({
    required this.name,
    required this.size,
    required this.isPdf,
  });

  final String name;
  final String size;
  final bool isPdf;
}

class _FamilyFriendAttachmentCard extends StatelessWidget {
  const _FamilyFriendAttachmentCard({required this.attachment});

  final _FamilyFriendAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            attachment.isPdf
                ? Icons.picture_as_pdf_outlined
                : Icons.image_outlined,
            size: 24,
            color: attachment.isPdf ? AppColors.red500 : AppColors.blue500,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  attachment.size,
                  style: AppTypography.label2.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.north_east, color: AppColors.neutral500),
        ],
      ),
    );
  }
}

class _FamilyFriendSymptomDetailScreen extends StatelessWidget {
  const _FamilyFriendSymptomDetailScreen({
    required this.memberName,
    required this.entry,
  });

  final String memberName;
  final _SymptomListEntry entry;

  static const _logs = [
    _FamilyFriendSymptomLogEntry(
      timestamp: 'Today, 3:00 PM',
      note: 'Felt very low after lunch. Could barely focus on work.',
      alongside: ['Dizziness', 'Headache', 'After lunch', 'Ongoing'],
      severity: 4,
      triggers: [
        'After meal',
        'On waking up',
        'After activity',
        'Stress',
        'After medication',
        'Random',
      ],
      activeTrigger: 'On waking up',
      attachments: [
        _FamilyFriendSymptomAttachment(
          name: 'WhatsApp-2338340124732.png',
          size: '1.1 MB',
        ),
      ],
    ),
    _FamilyFriendSymptomLogEntry(
      timestamp: 'Today, 3:00 PM',
      note: 'Felt very low after lunch. Could barely focus on work.',
      alongside: ['Dizziness', 'Headache', 'After lunch', 'Ongoing'],
      severity: 4,
      triggers: [
        'After meal',
        'On waking up',
        'After activity',
        'Stress',
        'After medication',
        'Random',
      ],
      activeTrigger: 'On waking up',
    ),
    _FamilyFriendSymptomLogEntry(
      timestamp: 'Today, 3:00 PM',
      note: 'Felt very low after lunch. Could barely focus on work.',
      alongside: ['Dizziness', 'Headache', 'After lunch', 'Ongoing'],
      severity: 4,
      triggers: [
        'After meal',
        'On waking up',
        'After activity',
        'Stress',
        'After medication',
        'Random',
      ],
      activeTrigger: 'On waking up',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _FamilyFriendDetailHeader(
              title: entry.name,
              subtitle: '${entry.timesLogged} TIMES LOGGED',
              trailing: _SymptomStatusBadge(isPassed: entry.isPassed),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space40,
                ),
                itemCount: _logs.length,
                itemBuilder: (_, index) => _FamilyFriendTimelineEntry(
                  entry: _logs[index],
                  isFirst: index == 0,
                  isLast: index == _logs.length - 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendSymptomLogEntry {
  const _FamilyFriendSymptomLogEntry({
    required this.timestamp,
    required this.note,
    required this.alongside,
    required this.severity,
    required this.triggers,
    this.activeTrigger,
    this.attachments = const [],
  });

  final String timestamp;
  final String note;
  final List<String> alongside;
  final int severity;
  final List<String> triggers;
  final String? activeTrigger;
  final List<_FamilyFriendSymptomAttachment> attachments;
}

class _FamilyFriendSymptomAttachment {
  const _FamilyFriendSymptomAttachment({
    required this.name,
    required this.size,
  });

  final String name;
  final String size;
}

class _FamilyFriendTimelineEntry extends StatelessWidget {
  const _FamilyFriendTimelineEntry({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final _FamilyFriendSymptomLogEntry entry;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 12,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: isFirst
                          ? Colors.transparent
                          : AppColors.neutral300,
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: isLast ? Colors.transparent : AppColors.neutral300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.neutral200),
                    borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.timestamp,
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space2),
                      Text(
                        entry.note,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space12),
                      _FamilyFriendMetaTitle(title: 'ALONGSIDE'),
                      const SizedBox(height: AppSpacing.space8),
                      Wrap(
                        spacing: AppSpacing.space8,
                        runSpacing: AppSpacing.space8,
                        children: entry.alongside
                            .map(
                              (item) => _FamilyFriendPill(
                                label: item,
                                selected: false,
                              ),
                            )
                            .toList(),
                      ),
                      if (entry.attachments.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.space12),
                        _FamilyFriendMetaTitle(title: 'ATTACHMENTS'),
                        const SizedBox(height: AppSpacing.space10),
                        ...entry.attachments.map(
                          (attachment) => Container(
                            height: 55,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.space12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.neutral200),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusLg,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: AppColors.cyan600,
                                ),
                                const SizedBox(width: AppSpacing.space8),
                                Expanded(
                                  child: Text(
                                    attachment.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.label2.copyWith(
                                      color: AppColors.neutral950,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.space8),
                                Text(
                                  attachment.size,
                                  style: AppTypography.label2.copyWith(
                                    color: AppColors.neutral500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.space12),
                      _FamilyFriendMetaTitle(title: 'SEVERITY'),
                      const SizedBox(height: AppSpacing.space10),
                      _FamilyFriendSeverityScale(value: entry.severity),
                      const SizedBox(height: AppSpacing.space12),
                      _FamilyFriendMetaTitle(title: 'POSSIBLE TRIGGER'),
                      const SizedBox(height: AppSpacing.space10),
                      Wrap(
                        spacing: AppSpacing.space8,
                        runSpacing: AppSpacing.space8,
                        children: entry.triggers
                            .map(
                              (item) => _FamilyFriendPill(
                                label: item,
                                selected: item == entry.activeTrigger,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendMetaTitle extends StatelessWidget {
  const _FamilyFriendMetaTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.label3.copyWith(
        color: AppColors.neutral500,
        letterSpacing: 0.48,
      ),
    );
  }
}

class _FamilyFriendPill extends StatelessWidget {
  const _FamilyFriendPill({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.blue500 : AppColors.neutral100,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(
          color: selected ? AppColors.blue500 : AppColors.neutral200,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.label3.copyWith(
          color: selected ? AppColors.white : AppColors.neutral600,
        ),
      ),
    );
  }
}

class _FamilyFriendSeverityScale extends StatelessWidget {
  const _FamilyFriendSeverityScale({required this.value});

  final int value;

  static const _backgrounds = [
    AppColors.blue50,
    AppColors.teal50,
    AppColors.amber50,
    AppColors.orange50,
    AppColors.white,
  ];

  static const _borders = [
    AppColors.blue500,
    AppColors.teal500,
    AppColors.amber400,
    AppColors.orange400,
    AppColors.neutral200,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          width: 24,
          height: 24,
          margin: EdgeInsets.only(right: index == 4 ? 0 : AppSpacing.space8),
          decoration: BoxDecoration(
            color: _backgrounds[index],
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(color: _borders[index]),
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: AppTypography.caption1.copyWith(color: AppColors.neutral950),
          ),
        );
      }),
    );
  }
}

class _FamilyHistoryCardData {
  const _FamilyHistoryCardData({
    required this.relation,
    required this.age,
    required this.name,
    required this.hpid,
    required this.avatarPath,
    required this.avatarBackgroundColor,
    required this.status,
    required this.conditions,
  });

  final String relation;
  final String age;
  final String name;
  final String hpid;
  final String avatarPath;
  final Color avatarBackgroundColor;
  final String status;
  final List<_FamilyHistoryCondition> conditions;
}

class _FamilyHistoryCondition {
  const _FamilyHistoryCondition(this.name, this.meta);

  final String name;
  final String meta;
}

class _FamilyHistoryReadOnlyCard extends StatelessWidget {
  const _FamilyHistoryReadOnlyCard({required this.data});

  final _FamilyHistoryCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neutral300),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: data.avatarBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(data.avatarPath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.relation} • ${data.age}',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                      Text(
                        data.name,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'HPID: ${data.hpid}',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.pink500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.pink500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green50,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(color: AppColors.green100),
                  ),
                  child: Text(
                    data.status,
                    style: AppTypography.label3.copyWith(
                      color: AppColors.green700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          ...data.conditions.asMap().entries.map((entry) {
            final condition = entry.value;
            final isLast = entry.key == data.conditions.length - 1;
            return Container(
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: AppColors.neutral200),
                      ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.neutral200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            condition.name,
                            style: AppTypography.label1.copyWith(
                              color: AppColors.neutral950,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            condition.meta,
                            style: AppTypography.label3.copyWith(
                              color: AppColors.neutral500,
                            ),
                          ),
                        ],
                      ),
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

class _InsuranceCardData {
  const _InsuranceCardData({
    required this.type,
    required this.name,
    required this.policyNumber,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.typeColor,
    required this.iconPath,
    required this.fileName,
    required this.fileSize,
    required this.data,
    required this.labels,
  });

  final String type;
  final String name;
  final String policyNumber;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final Color typeColor;
  final String iconPath;
  final String fileName;
  final String fileSize;
  final List<String> data;
  final List<String> labels;
}

class _ReadOnlyInsuranceCard extends StatelessWidget {
  const _ReadOnlyInsuranceCard({required this.data});

  final _InsuranceCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: data.typeColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      data.iconPath,
                      width: 45,
                      height: 45,
                      colorFilter: ColorFilter.mode(
                        data.typeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.type,
                        style: AppTypography.label3.copyWith(
                          color: data.typeColor,
                        ),
                      ),
                      Text(
                        data.name,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Policy: ${data.policyNumber}',
                            style: AppTypography.label3.copyWith(
                              color: AppColors.blue600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.blue600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.content_copy,
                            size: 16,
                            color: AppColors.blue600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: data.statusBg,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    data.status,
                    style: AppTypography.label3.copyWith(
                      color: data.statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          const Divider(height: 1, color: AppColors.neutral200),
          Row(
            children: List.generate(3, (index) {
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  decoration: BoxDecoration(
                    border: index < 2
                        ? const Border(
                            right: BorderSide(color: AppColors.neutral200),
                          )
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.data[index],
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        data.labels[index],
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space12,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.red500,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'PDF',
                    style: AppTypography.caption1.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.fileName,
                        style: AppTypography.label1.copyWith(
                          color: AppColors.neutral950,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        data.fileSize,
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.north_east, color: AppColors.neutral500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<ReportEntry> _reportEntriesFor(String title, int totalFiles) {
  const note =
      'TSH came back elevated at 6.2 mIU/L, above the normal range. Free T3 and T4 are within limits. Anti-TPO antibodies slightly raised. Doctor has recommended a retest in 6 weeks and a possible Eltroxin dosage review.';

  final fileCount = title == 'Thyroid'
      ? 3
      : title == 'Diabetes'
      ? 4
      : title == 'General'
      ? 8
      : 3;

  final files = [
    ReportFile(name: '${title}_Jan25.pdf', isPdf: true),
    const ReportFile(name: 'Report_p1.jpg', isPdf: false),
    const ReportFile(name: 'Report_p2.jpg', isPdf: false),
  ];

  final entry2025 = ReportEntry(
    day: 14,
    month: 'JAN',
    year: 2025,
    fileCount: fileCount,
    fileTypeLabel: 'PDF + 2 photos',
    labName: 'SRL Diagnostics, Baner',
    doctorRef: 'Ref. Dr. Meena Sharma',
    note: note,
    files: files,
  );
  final entry2024 = ReportEntry(
    day: 14,
    month: 'JAN',
    year: 2024,
    fileCount: fileCount,
    fileTypeLabel: 'PDF + 2 photos',
    labName: 'SRL Diagnostics, Baner',
    doctorRef: 'Ref. Dr. Meena Sharma',
    note: note,
    files: files,
  );

  if (title == 'Thyroid') {
    return [entry2025, entry2025, entry2024, entry2024];
  }

  return [entry2025];
}
