import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import '../widgets/edit_name_bottom_sheet.dart';
import '../widgets/edit_email_bottom_sheet.dart';
import '../widgets/edit_phone_bottom_sheet.dart';
import '../widgets/personal_info_bottom_sheets.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  // Mock State
  String _name = 'Mahesh Sahu';
  String _email = 'samarth@uxgraphy.com';
  String _phone = '9039443124';
  DateTime _dob = DateTime(2001, 12, 4);
  int _age = 47;
  String _gender = 'Male';
  int _height = 169;
  int _weight = 68;
  String _bloodGroup = 'O+';
  String _city = 'Pune, Maharashtra';

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppResponsive.horizontalPadding(context);

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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 16,
        ),
        child: ResponsiveConstrainedContent(
          child: Column(
            children: [
              _buildSection([
                _InfoItem(
                  label: 'Name',
                  value: _name,
                  onTap: () => showEditNameSheet(
                    context,
                    initialName: _name,
                    onUpdate: (val) => setState(() => _name = val),
                  ),
                ),
                _InfoItem(
                  label: 'Email',
                  value: _email,
                  onTap: () => showEditEmailSheet(
                    context,
                    initialEmail: _email,
                    onUpdate: (val) => setState(() => _email = val),
                  ),
                ),
                _InfoItem(
                  label: 'Phone',
                  value: _phone,
                  prefix: '+91',
                  onTap: () => showEditPhoneSheet(
                    context,
                    initialPhone: _phone,
                    onUpdate: (val) => setState(() => _phone = val),
                  ),
                ),
              ]),
              const SizedBox(height: AppSpacing.space16),
              _buildSection([
                _InfoItem(
                  label: 'Date of birth',
                  value: '',
                  isDate: true,
                  onTap: () => _showSheet(
                    EditDOBBottomSheet(
                      initialDate: _dob,
                      onUpdate: (val) => setState(() => _dob = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'Age',
                  value: '$_age years',
                  onTap: () => _showSheet(
                    EditAgeBottomSheet(
                      initialAge: _age,
                      onUpdate: (val) => setState(() => _age = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'Gender',
                  value: _gender,
                  onTap: () => _showSheet(
                    EditGenderBottomSheet(
                      initialGender: _gender,
                      onUpdate: (val) => setState(() => _gender = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'Height',
                  value: '$_height cm',
                  onTap: () => _showSheet(
                    EditHeightBottomSheet(
                      initialHeight: _height,
                      onUpdate: (val) => setState(() => _height = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'Weight',
                  value: '$_weight kg',
                  onTap: () => _showSheet(
                    EditWeightBottomSheet(
                      initialWeight: _weight,
                      onUpdate: (val) => setState(() => _weight = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'Blood Group',
                  value: _bloodGroup,
                  onTap: () => _showSheet(
                    EditBloodGroupBottomSheet(
                      initialGroup: _bloodGroup,
                      onUpdate: (val) => setState(() => _bloodGroup = val),
                    ),
                  ),
                ),
                _InfoItem(
                  label: 'City',
                  value: _city,
                  onTap: () => _showSheet(
                    EditCityBottomSheet(
                      initialCity: _city,
                      onUpdate: (val) => setState(() => _city = val),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _showSheet(Widget sheet) {
    showAppModalBottomSheet(context: context, builder: (context) => sheet);
  }

  Widget _buildSection(List<_InfoItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return _buildRow(item, !isLast);
        }).toList(),
      ),
    );
  }

  Widget _buildRow(_InfoItem item, bool showBorder) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        item.onTap();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          decoration: BoxDecoration(
            border: showBorder
                ? const Border(bottom: BorderSide(color: AppColors.neutral200))
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.label,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: item.isDate
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _buildDateValue(_dob),
                        )
                      : item.prefix != null
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _buildPhoneValue(item),
                        )
                      : Text(
                          item.value,
                          style: AppTypography.label1.copyWith(
                            color: AppColors.neutral950,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.neutral400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateValue(DateTime d) {
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
      children: [
        Text(d.day.toString().padLeft(2, '0'), style: valueStyle),
        const Text(' / ', style: dividerStyle),
        Text(d.month.toString().padLeft(2, '0'), style: valueStyle),
        const Text(' / ', style: dividerStyle),
        Text(d.year.toString(), style: valueStyle),
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
  final VoidCallback onTap;
  _InfoItem({
    required this.label,
    required this.value,
    required this.onTap,
    this.prefix,
    this.isDate = false,
  });
}
