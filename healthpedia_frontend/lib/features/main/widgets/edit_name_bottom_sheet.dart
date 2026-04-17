import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/features/main/widgets/profile_info_sheet_scaffold.dart';

void showEditNameSheet(
  BuildContext context, {
  required String initialName,
  required ValueChanged<String> onUpdate,
}) {
  showAppModalBottomSheet(
    context: context,
    builder: (context) =>
        EditNameBottomSheet(initialName: initialName, onUpdate: onUpdate),
  );
}

class EditNameBottomSheet extends StatefulWidget {
  const EditNameBottomSheet({
    super.key,
    required this.initialName,
    required this.onUpdate,
  });

  final String initialName;
  final ValueChanged<String> onUpdate;

  @override
  State<EditNameBottomSheet> createState() => _EditNameBottomSheetState();
}

class _EditNameBottomSheetState extends State<EditNameBottomSheet> {
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    final parts = widget.initialName.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.last : '';
    final middle = parts.length > 2
        ? parts.sublist(1, parts.length - 1).join(' ')
        : '';

    _firstNameController = TextEditingController(text: first);
    _middleNameController = TextEditingController(text: middle);
    _lastNameController = TextEditingController(text: last);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileInfoSheetScaffold(
      title: 'Edit name',
      primaryLabel: 'Update',
      onPrimaryTap: () {
        final parts = [
          _firstNameController.text.trim(),
          _middleNameController.text.trim(),
          _lastNameController.text.trim(),
        ].where((part) => part.isNotEmpty).toList();
        widget.onUpdate(parts.join(' '));
        Navigator.pop(context);
      },
      child: Column(
        children: [
          PremiumTextField(
            label: 'First Name',
            controller: _firstNameController,
            isDark: false,
          ),
          const SizedBox(height: 8),
          PremiumTextField(
            label: 'Middle Name',
            controller: _middleNameController,
            isDark: false,
          ),
          const SizedBox(height: 8),
          PremiumTextField(
            label: 'Last Name',
            controller: _lastNameController,
            isDark: false,
          ),
        ],
      ),
    );
  }
}
