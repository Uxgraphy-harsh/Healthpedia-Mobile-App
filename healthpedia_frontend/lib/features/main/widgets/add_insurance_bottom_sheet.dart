import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

void showAddInsuranceSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const AddInsuranceBottomSheet(),
  );
}

class AddInsuranceBottomSheet extends StatefulWidget {
  const AddInsuranceBottomSheet({super.key});

  @override
  State<AddInsuranceBottomSheet> createState() => _AddInsuranceBottomSheetState();
}

class _AddInsuranceBottomSheetState extends State<AddInsuranceBottomSheet> {
  String _selectedType = 'Health';
  final List<Map<String, dynamic>> _types = [
    {'label': 'Health', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Health Insurance Icon.svg'},
    {'label': 'Life', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Life Insurance Icon.svg'},
    {'label': 'Term', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Term Insurance Icon.svg'},
    {'label': 'Vehicle', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Vehicle Insurance Icon.svg'},
    {'label': 'Travel', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Travel Insurance Icon.svg'},
    {'label': 'Other', 'icon': 'assets/Figma MCP Assets/CommonAssets/Icons/Other Insurance Icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.space24,
        left: 16,
        right: 16,
        top: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppColors.neutral200, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 32),
            _buildUploadBox(),
            const SizedBox(height: 24),
            _buildForm(),
            const SizedBox(height: 24),
            _buildTypeSelection(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTypography.label1.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w400)),
          ),
        ),
        Text('Add an Insurance Policy', style: AppTypography.h6.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFE0F2FE).withOpacity(0.5), const Color(0xFFFDF2F8).withOpacity(0.5)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          const Icon(Icons.file_upload_outlined, color: Color(0xFFE11D48)),
          const SizedBox(height: 12),
          Text('Upload file for AI to automatically fetch details', 
              textAlign: TextAlign.center,
              style: AppTypography.label2.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
          Text('Max upto 2 mb per file upload', style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['PDF', 'JPG', 'PNG'].map((ext) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: AppColors.neutral100, borderRadius: BorderRadius.circular(4)),
              child: Text(ext, style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField('Insurance provider*', 'e.g. Healthpedia Future Secure'),
        const SizedBox(height: 16),
        _buildTextField('Policy Name', 'e.g. Healthpedia Future Secure'),
        const SizedBox(height: 16),
        _buildTextField('Policy Number*', '0000000000'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('Purchased on', '00/00/0000')),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField('Expires on*', '00/00/0000')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('Sum Insured', '₹10,00,000')),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField('Premium', '₹12,400/yr')),
          ],
        ),
        const SizedBox(height: 16),
        _buildDropdownField('Premium Frequency', 'Annually'),
        const SizedBox(height: 16),
        _buildTextField('Nominee', 'Full name of nominee'),
        const SizedBox(height: 16),
        _buildTextField('Notes', 'Any additional details, claims history, etc.', maxLines: 3),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label, hintText: hint, floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.neutral200), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: AppTypography.label1.copyWith(color: AppColors.neutral950)),
              const Icon(Icons.expand_more, color: AppColors.neutral500),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('INSURANCE TYPE', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, mainSpacing: 8, crossSpacing: 8),
          itemCount: _types.length,
          itemBuilder: (context, index) {
            final type = _types[index];
            final isSelected = _selectedType == type['label'];
            return GestureDetector(
              onTap: () { HapticFeedback.selectionClick(); setState(() => _selectedType = type['label']!); },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue600 : AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: isSelected ? AppColors.blue600 : AppColors.neutral200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(type['icon']!, width: 16, height: 16, colorFilter: ColorFilter.mode(isSelected ? AppColors.white : AppColors.neutral500, BlendMode.srcIn)),
                    const SizedBox(width: 8),
                    Text(type['label']!, style: AppTypography.label2.copyWith(color: isSelected ? AppColors.white : AppColors.neutral500)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Color(0xFFE11D48)),
            label: Text('Add More', style: AppTypography.label1.copyWith(color: const Color(0xFFE11D48))),
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 56), side: const BorderSide(color: Color(0xFFFFD1D5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.neutral950, minimumSize: const Size(0, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
            child: Text('Save', style: AppTypography.label1.copyWith(color: AppColors.white)),
          ),
        ),
      ],
    );
  }
}
