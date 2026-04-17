import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';


Future<void> showAddNoteBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AddNoteBottomSheet(),
  );
}

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = mediaQuery.size.height * 0.42;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radius3xl),
              topRight: Radius.circular(AppSpacing.radius3xl),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Removed manual bar to allow system default, keeping space
              PremiumSheetHeader(
                title: 'Add note',
                leadingLabel: 'Cancel',
                onLeadingTap: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space16,
                    AppSpacing.space16,
                    AppSpacing.space16,
                    AppSpacing.space16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOTE',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral500,
                          letterSpacing: 0.48,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      PremiumTextField(
                        isDark: false,
                        label: 'Title*',
                        placeholder: 'Type to add or search existing symptom...',
                        controller: _titleController,
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      PremiumTextField(
                        isDark: false,
                        label: 'Note*',
                        placeholder: 'Write or paste a link',
                        controller: _noteController,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  0,
                  AppSpacing.space16,
                  AppSpacing.space16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: Text(
                      'Save Note',
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

