import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

import 'package:healthpedia_frontend/core/constants/app_avatars.dart';

void showChangeProfilePhotoSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ChangeProfilePhotoBottomSheet(),
  );
}

class ChangeProfilePhotoBottomSheet extends StatefulWidget {
  const ChangeProfilePhotoBottomSheet({super.key});

  @override
  State<ChangeProfilePhotoBottomSheet> createState() =>
      _ChangeProfilePhotoBottomSheetState();
}

class _ChangeProfilePhotoBottomSheetState extends State<ChangeProfilePhotoBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PlatformFile? _uploadedFile;
  int _selectedAvatarIndex = 6; // Adjusted default

  final List<String> _avatars = AppAvatars.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      final file = result.files.first;
      if (file.size <= 2 * 1024 * 1024) {
        setState(() {
          _uploadedFile = file;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File size exceeds 2MB limit')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PremiumSheetHeader(
            title: 'Change profile photo',
            leadingLabel: 'Cancel',
            onLeadingTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.blue600,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.blue600,
            unselectedLabelColor: AppColors.neutral500,
            labelStyle: AppTypography.label1.copyWith(fontWeight: FontWeight.w400),
            tabs: const [
              Tab(text: 'Image'),
              Tab(text: 'Avatar'),
            ],
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 280,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildImageTab(),
                  _buildAvatarTab(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neutral950,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
                elevation: 0,
              ),
              child: Text(
                'Update Profile Photo',
                style: AppTypography.label1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTab() {
    if (_uploadedFile != null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.blue600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _uploadedFile!.name,
                  style: AppTypography.label2.copyWith(color: AppColors.neutral950),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${(_uploadedFile!.size / 1024 / 1024).toStringAsFixed(1)} MB',
                style: AppTypography.label2.copyWith(color: AppColors.neutral500),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _uploadedFile = null),
                child: const Icon(Icons.close, size: 20, color: AppColors.neutral500),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.neutral200,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Dashed border simulator (using custom painter normally, but let's keep it simple with thin border)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.file_upload_outlined,
                      color: AppColors.pink500, size: 28),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    'Tap to upload',
                    style: AppTypography.label1.copyWith(
                      color: AppColors.neutral950,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Max upto 2 mb per file upload',
                    style: AppTypography.label3.copyWith(color: AppColors.neutral500),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['PDF', 'JPG', 'PNG'].map((ext) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.neutral200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          ext,
                          style: AppTypography.label3
                              .copyWith(color: AppColors.neutral500),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarTab() {
    return Column(
      children: [
        // Preview Avatar (Cleaned)
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.pink300, width: 1.5),
          ),
          child: ClipOval(
            child: Image.asset(
              _avatars[_selectedAvatarIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: _avatars.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedAvatarIndex == index;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedAvatarIndex = index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.blue600 : AppColors.neutral200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(_avatars[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
