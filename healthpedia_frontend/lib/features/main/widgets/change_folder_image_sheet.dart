import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_conditions.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import 'package:healthpedia_frontend/features/main/widgets/profile_info_sheet_scaffold.dart';

void showChangeFolderImageSheet(
  BuildContext context, {
  required String currentImage,
  required ValueChanged<String> onSelected,
}) {
  showAppModalBottomSheet(
    context: context,
    builder: (context) => ChangeFolderImageSheet(
      currentImage: currentImage,
      onSelected: onSelected,
    ),
  );
}

class ChangeFolderImageSheet extends StatefulWidget {
  const ChangeFolderImageSheet({
    super.key,
    required this.currentImage,
    required this.onSelected,
  });

  final String currentImage;
  final ValueChanged<String> onSelected;

  @override
  State<ChangeFolderImageSheet> createState() => _ChangeFolderImageSheetState();
}

class _ChangeFolderImageSheetState extends State<ChangeFolderImageSheet> {
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.currentImage;
  }

  @override
  Widget build(BuildContext context) {
    return ProfileInfoSheetScaffold(
      title: 'Change Folder Image',
      leadingLabel: 'Cancel',
      onLeadingTap: () => Navigator.pop(context),
      primaryLabel: 'Update',
      onPrimaryTap: () {
        widget.onSelected(_selectedImage);
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          // Preview of selected image
          Container(
            width: 120,
            height: 120,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.neutral200),
            ),
            child: SvgPicture.asset(
              _selectedImage,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 32),
          // Grid of options
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: AppConditions.all.map((image) {
              final isSelected = _selectedImage == image;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedImage = image);
                },
                child: Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.black : AppColors.neutral200,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: SvgPicture.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
