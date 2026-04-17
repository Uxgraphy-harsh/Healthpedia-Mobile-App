import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_file_drop.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_field_states.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

class UploadReportBottomSheet extends StatefulWidget {
  const UploadReportBottomSheet({super.key});

  @override
  State<UploadReportBottomSheet> createState() => _UploadReportBottomSheetState();
}

class _UploadReportBottomSheetState extends State<UploadReportBottomSheet> {
  // Mock data for uploaded files
  final List<Map<String, String>> _uploadedFiles = [
    {'name': 'Thyroid_Jan25.pdf', 'size': '1.7 MB', 'type': 'pdf'},
    {'name': 'Report_photo.jpg', 'size': '840 KB', 'type': 'jpg'},
    {'name': 'Xray.png', 'size': '1.1 MB', 'type': 'png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Home Indicator
          // Removed manual bar to allow system default, keeping space
          PremiumSheetHeader(
            title: 'Upload Report',
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2563EB), // blue/600
                  ),
                ),
              ),
            ),
          ),
            const SizedBox(height: 8),

          const Divider(height: 1, color: AppColors.neutral200),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // File Drop Component
                  const PremiumFileDrop(
                    isDark: false,
                    state: PremiumFieldState.defaultState,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Uploaded Files List
                  ..._uploadedFiles.map((file) => _buildFileItem(file)),
                  
                  const SizedBox(height: 24),
                  
                  // Action Button
                  // Removed from here to make it sticky
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Action logic
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neutral950,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome_rounded, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Upload & Organize with AI',
                      style: AppTypography.body1SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(Map<String, String> file) {
    IconData fileIcon;
    Color iconColor;
    
    switch (file['type']) {
      case 'pdf':
        fileIcon = Icons.picture_as_pdf_outlined;
        iconColor = AppColors.red600;
        break;
      case 'jpg':
        fileIcon = Icons.image_outlined;
        iconColor = AppColors.orange600;
        break;
      case 'png':
        fileIcon = Icons.image_outlined;
        iconColor = AppColors.sky600;
        break;
      default:
        fileIcon = Icons.insert_drive_file_outlined;
        iconColor = AppColors.neutral500;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          Icon(fileIcon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              file['name']!,
              style: AppTypography.body1SemiBold.copyWith(
                color: AppColors.neutral950,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            file['size']!,
            style: AppTypography.caption1.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _uploadedFiles.remove(file);
              });
            },
            child: Icon(
              Icons.close_rounded,
              color: AppColors.neutral400,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
