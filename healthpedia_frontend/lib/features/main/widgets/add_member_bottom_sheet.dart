import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_country_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

Future<void> showAddMemberBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AddMemberBottomSheet(),
  );
}

class AddMemberBottomSheet extends StatefulWidget {
  const AddMemberBottomSheet({super.key});

  @override
  State<AddMemberBottomSheet> createState() => _AddMemberBottomSheetState();
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Container(
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
              PremiumSheetHeader(
                title: 'Add a Member',
                leadingLabel: 'Cancel',
                onLeadingTap: () => Navigator.of(context).pop(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space24,
                  AppSpacing.space16,
                  AppSpacing.space20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PremiumCountryField(
                      label: 'Mobile',
                      controller: _mobileController,
                      isDark: false,
                    ),
                    const SizedBox(height: AppSpacing.space32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        child: Text(
                          'Request access',
                          style: AppTypography.body2Medium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

