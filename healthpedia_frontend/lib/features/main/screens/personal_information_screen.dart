import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/edit_name_bottom_sheet.dart';
import '../widgets/edit_email_bottom_sheet.dart';
import '../widgets/edit_phone_bottom_sheet.dart';
import '../widgets/personal_info_bottom_sheets.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 72,
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Personal Information',
          style: AppTypography.h6.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _InfoSection(
              items: [
                _InfoItem(label: 'Name', value: 'Mahesh Sahu'),
                _InfoItem(label: 'Email', value: 'samarth@uxgraphy.com'),
                _InfoItem(
                  label: 'Phone',
                  value: '9039443124',
                  prefix: '+91',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space16),
            _InfoSection(
              items: [
                _InfoItem(
                  label: 'Date of birth',
                  value: '', // Handled specially
                  isDate: true,
                ),
                _InfoItem(label: 'Age', value: '47 years'),
                _InfoItem(label: 'Gender', value: 'Male'),
                _InfoItem(label: 'Height', value: '169 cm'),
                _InfoItem(label: 'Weight', value: '68 kg'),
                _InfoItem(label: 'Blood Group', value: 'O+'),
                _InfoItem(label: 'City', value: 'Pune, Maharashtra'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.items});
  final List<_InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Neutral/100
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return _buildRow(item, !isLast, context);
        }).toList(),
      ),
    );
  }

  Widget _buildRow(_InfoItem item, bool showBorder, BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        if (item.label == 'Name') {
          showEditNameSheet(context);
        } else if (item.label == 'Email') {
          showEditEmailSheet(context);
        } else if (item.label == 'Phone') {
          showEditPhoneSheet(context);
        } else if (item.label == 'Date of birth') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditDOBBottomSheet());
        } else if (item.label == 'Age') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditAgeBottomSheet());
        } else if (item.label == 'Gender') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditGenderBottomSheet());
        } else if (item.label == 'Height') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditHeightBottomSheet());
        } else if (item.label == 'Weight') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditWeightBottomSheet());
        } else if (item.label == 'Blood Group') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditBloodGroupBottomSheet());
        } else if (item.label == 'City') {
          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const EditCityBottomSheet());
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          decoration: BoxDecoration(
            border: showBorder
                ? const Border(
                    bottom: BorderSide(color: AppColors.neutral200),
                  )
                : null,
          ),
          child: Row(
            children: [
              Text(
                item.label,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              if (item.isDate)
                _buildDateValue()
              else if (item.prefix != null)
                _buildPhoneValue(item)
              else
                Text(
                  item.value,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(width: 0),
              SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/Field Icon V1.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateValue() {
    const dividerStyle = TextStyle(
      fontFamily: 'Geist',
      fontSize: 16,
      color: Color(0xFF525252),
    );
    const valueStyle = TextStyle(
      fontFamily: 'Geist',
      fontSize: 16,
      color: Color(0xFF0A0A0A),
    );

    return Row(
      children: const [
        Text('04', style: valueStyle),
        Text(' / ', style: dividerStyle),
        Text('12', style: valueStyle),
        Text(' / ', style: dividerStyle),
        Text('2001', style: valueStyle),
      ],
    );
  }

  Widget _buildPhoneValue(_InfoItem item) {
    return Row(
      children: [
        Text(
          item.prefix!,
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 16,
            color: Color(0xFF525252),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          item.value,
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 16,
            color: Color(0xFF0A0A0A),
          ),
        ),
      ],
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  final String? prefix;
  final bool isDate;
  _InfoItem({
    required this.label,
    required this.value,
    this.prefix,
    this.isDate = false,
  });
}

