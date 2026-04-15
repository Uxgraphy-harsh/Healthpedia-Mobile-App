import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/add_medical_record_bottom_sheet.dart';

class FamilyHistoryScreen extends StatefulWidget {
  const FamilyHistoryScreen({super.key});

  @override
  State<FamilyHistoryScreen> createState() => _FamilyHistoryScreenState();
}

class _FamilyHistoryScreenState extends State<FamilyHistoryScreen> {
  bool _showAboutPopup = false;
  bool _showNoAccessPopup = false;

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
          if (_showNoAccessPopup) _buildNoAccessPopup(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          showAddMedicalRecordSheet(context);
        },
        backgroundColor: const Color(0xFFFFF1F2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
          side: const BorderSide(color: Color(0xFFFFD1D5)),
        ),
        label: Text(
          'Add a Medical Record',
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
          _FamilyMemberCard(
            relation: 'Father',
            age: '79 Years',
            name: 'Sujoy Sahu',
            hpid: '#8836477253',
            avatarPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 82.png',
            conditions: [
              _FamilyCondition(name: 'Hypertension', date: 'Diagnosed • early 50s'),
              _FamilyCondition(name: 'Type 2 Diabetes', date: 'Diagnosed • age 48'),
            ],
            onTapID: () => setState(() => _showNoAccessPopup = true),
          ),
          const SizedBox(height: 16),
          _FamilyMemberCard(
            relation: 'Mother',
            age: '79 Years',
            name: 'Miska Sahu',
            hpid: '#9354677563',
            avatarPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 83.png',
            conditions: [
              _FamilyCondition(name: 'Hypothyroidism', date: 'Diagnosed • late 40s'),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAboutPopup() {
    return _PopupOverlay(
      onClose: () => setState(() => _showAboutPopup = false),
      title: 'About Family History',
      description: 'Recording your family’s medical conditions helps Healthpedia’s AI flag hereditary risks and give you more personalised health guidance.',
    );
  }

  Widget _buildNoAccessPopup() {
    return Container(
      color: Colors.black.withOpacity(0.4),
      width: double.infinity, height: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Oops! You don’t have access to this profile.',
                        style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(() => _showNoAccessPopup = false),
                      child: Text('Close', style: AppTypography.label1.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'You can only see the profiles of people who has given you access to see their data.',
                  style: AppTypography.label2.copyWith(color: AppColors.neutral600),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => setState(() => _showNoAccessPopup = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue500,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    elevation: 0,
                  ),
                  child: Text('Request Access', style: AppTypography.label1.copyWith(color: AppColors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopupOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final String title;
  final String description;

  const _PopupOverlay({required this.onClose, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        width: double.infinity, height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: onClose,
                        child: Text('Understood', style: AppTypography.label1.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(description, style: AppTypography.label2.copyWith(color: AppColors.neutral600)),
                ],
              ),
            ),
          ),
        ),
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
  final List<_FamilyCondition> conditions;
  final VoidCallback? onTapID;

  const _FamilyMemberCard({
    required this.relation, required this.age, required this.name, required this.hpid, required this.avatarPath, required this.conditions, this.onTapID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
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
                    Text('$relation • $age', style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
                    Text(name, style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: onTapID,
                      child: Text('HPID: $hpid', style: AppTypography.label3.copyWith(color: const Color(0xFFE11D48), decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Edit', style: AppTypography.label2.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(99)),
                    child: Text('Active Today', style: AppTypography.label3.copyWith(color: AppColors.green600, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...conditions.map((c) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w500)),
                    Text(c.date, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
                  ],
                ),
                const Icon(Icons.delete_outline, color: AppColors.neutral400, size: 20),
              ],
            ),
          )),
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
