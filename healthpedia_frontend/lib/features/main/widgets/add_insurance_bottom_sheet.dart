import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_button.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_date_picker.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_file_drop.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_select.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'insurance_icon_tile.dart';

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
  State<AddInsuranceBottomSheet> createState() =>
      _AddInsuranceBottomSheetState();
}

class _AddInsuranceBottomSheetState extends State<AddInsuranceBottomSheet> {
  String _selectedType = 'Health';
  String? _premiumFrequency = 'Annually';
  DateTime? _purchasedOn;
  DateTime? _expiresOn;
  final _providerController = TextEditingController();
  final _policyNameController = TextEditingController();
  final _policyNumberController = TextEditingController();
  final _sumInsuredController = TextEditingController();
  final _premiumController = TextEditingController();
  final _nomineeController = TextEditingController();
  final _notesController = TextEditingController();
  final List<Map<String, dynamic>> _types = [
    {'label': 'Health'},
    {'label': 'Life'},
    {'label': 'Term'},
    {'label': 'Vehicle'},
    {'label': 'Travel'},
    {'label': 'Other'},
  ];
  final List<String> _premiumFrequencies = const [
    'Annually',
    'Half-yearly',
    'Quarterly',
    'Monthly',
    'One-time',
  ];

  @override
  void dispose() {
    _providerController.dispose();
    _policyNameController.dispose();
    _policyNumberController.dispose();
    _sumInsuredController.dispose();
    _premiumController.dispose();
    _nomineeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumBottomSheet(
      title: 'Add an Insurance Policy',
      leadingLabel: 'Cancel',
      onLeadingTap: () => Navigator.pop(context),
      footer: _buildActionButtons(),
      child: Column(
        children: [
          _buildUploadBox(),
          const SizedBox(height: 24),
          _buildForm(),
          const SizedBox(height: 24),
          _buildTypeSelection(),
        ],
      ),
    );
  }

  Widget _buildUploadBox() {
    return PremiumFileDrop(
      isDark: false,
      onBrowse: () {},
      label: null,
      hint: 'Max upto 2 mb per file upload',
      emptyIcon: const Icon(
        Icons.file_upload_outlined,
        color: Color(0xFFE11D48),
      ),
      emptyTitle: 'Upload file for AI to automatically fetch details',
      showEmptyBrowseButton: false,
      supportedFormats: const ['PDF', 'JPG', 'PNG'],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(
          'Insurance provider*',
          'e.g. Healthpedia Future Secure',
          controller: _providerController,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          'Policy Name',
          'e.g. Healthpedia Future Secure',
          controller: _policyNameController,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          'Policy Number*',
          '0000000000',
          controller: _policyNumberController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                'Purchased on',
                _purchasedOn,
                (value) => setState(() => _purchasedOn = value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateField(
                'Expires on*',
                _expiresOn,
                (value) => setState(() => _expiresOn = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                'Sum Insured',
                '₹10,00,000',
                controller: _sumInsuredController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                'Premium',
                '₹12,400/yr',
                controller: _premiumController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPremiumFrequencyField(),
        const SizedBox(height: 16),
        _buildTextField(
          'Nominee',
          'Full name of nominee',
          controller: _nomineeController,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          'Notes',
          'Any additional details, claims history, etc.',
          controller: _notesController,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return PremiumTextField(
      controller: controller,
      label: label,
      placeholder: hint,
      maxLines: maxLines,
      keyboardType: keyboardType,
      isDark: false,
      forceLabelInside: true,
      minHeight: maxLines > 1 ? 96 : 64,
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? value,
    ValueChanged<DateTime> onDateSelected,
  ) {
    return PremiumDatePicker(
      label: label,
      placeholder: '00/00/0000',
      value: value,
      onDateSelected: onDateSelected,
      isDark: false,
      minHeight: 64,
    );
  }

  Widget _buildPremiumFrequencyField() {
    return PremiumSelect<String>(
      label: 'Premium Frequency',
      placeholder: 'Annually',
      value: _premiumFrequency,
      items: _premiumFrequencies,
      onChanged: (value) => setState(() => _premiumFrequency = value),
      isDark: false,
      minHeight: 64,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
    );
  }

  Widget _buildTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INSURANCE TYPE',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _types.length,
          itemBuilder: (context, index) {
            final type = _types[index];
            final isSelected = _selectedType == type['label'];
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedType = type['label']!);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.blue600.withValues(alpha: 0.05)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.blue600
                        : AppColors.neutral200,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InsuranceIconAssetTile(
                      assetPath: InsuranceTypeAssets.byLabel(
                        type['label'] as String,
                      ),
                      size: 32,
                      borderRadius: 8,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      type['label']!,
                      style: AppTypography.label1.copyWith(
                        color: isSelected
                            ? AppColors.blue600
                            : AppColors.neutral950,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
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
    return PremiumButton(
      label: 'Save',
      size: PremiumButtonSize.docked,
      onPressed: () => Navigator.pop(context),
    );
  }
}
