import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

Future<void> showAddPrescriptionSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AddPrescriptionBottomSheet(),
  );
}

Future<void> showAddPrescriptionMedicinesSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _AddPrescriptionMedicinesBottomSheet(
      medicines: _mockPrescriptionMedicines,
    ),
  );
}

Future<void> showAddPrescriptionMedicineEditorSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _AddPrescriptionMedicineEditorBottomSheet(),
  );
}

Future<void> showAddPrescriptionDetailsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _AddPrescriptionDetailsBottomSheet(),
  );
}

class AddPrescriptionBottomSheet extends StatefulWidget {
  const AddPrescriptionBottomSheet({super.key});

  @override
  State<AddPrescriptionBottomSheet> createState() =>
      _AddPrescriptionBottomSheetState();
}

class _AddPrescriptionBottomSheetState
    extends State<AddPrescriptionBottomSheet> {
  final List<_PrescriptionMedicine> _medicines = List.of(
    _mockPrescriptionMedicines,
  );

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: viewInsets),
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
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 8, bottom: 6),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
              ),
              SizedBox(
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space16,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Back',
                            style: AppTypography.label2.copyWith(
                              color: AppColors.blue600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Prescription details',
                      style: AppTypography.label1SemiBold.copyWith(
                        color: AppColors.neutral950,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prescription details and adding at least medicine 1 is\nrequired to add new prescription.',
                      style: AppTypography.label2.copyWith(
                        color: AppColors.red500,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    _SheetOptionTile(
                      iconBackground: AppColors.rose500,
                      icon: Icons.assignment_turned_in_rounded,
                      iconColor: AppColors.white,
                      title: 'Prescription Details',
                      isRequired: true,
                      onTap: () => showAddPrescriptionDetailsSheet(context),
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    _SheetOptionTile(
                      iconBackground: AppColors.purple500,
                      emoji: '💊',
                      title: 'Medicines',
                      trailingCounter: '${_medicines.length}',
                      onTap: () => showAddPrescriptionMedicinesSheet(context),
                    ),
                    const SizedBox(height: AppSpacing.space32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Center(
                          child: Text(
                            'Done',
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
            ],
          ),
        ),
      ),
    );
  }
}

const List<_PrescriptionMedicine> _mockPrescriptionMedicines = [
  _PrescriptionMedicine(
    name: 'Thyrox 50 Tablet',
    note: '~ Before food',
    quantity: '1x',
  ),
  _PrescriptionMedicine(
    name: 'Thyrox 50 Tablet',
    note: '~ Before food',
    quantity: '1x',
  ),
];

class _PrescriptionMedicine {
  const _PrescriptionMedicine({
    required this.name,
    required this.note,
    required this.quantity,
  });

  final String name;
  final String note;
  final String quantity;
}

class _SheetOptionTile extends StatelessWidget {
  const _SheetOptionTile({
    required this.iconBackground,
    required this.title,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.emoji,
    this.isRequired = false,
    this.trailingCounter,
  });

  final Color iconBackground;
  final IconData? icon;
  final Color? iconColor;
  final String? emoji;
  final String title;
  final bool isRequired;
  final String? trailingCounter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.neutral100,
      borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        child: Container(
          height: 53,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Row(
            children: [
              _IconBadge(
                background: iconBackground,
                icon: icon,
                iconColor: iconColor,
                emoji: emoji,
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: AppTypography.body2Medium.copyWith(
                      color: AppColors.neutral950,
                    ),
                    children: [
                      TextSpan(text: title),
                      if (isRequired)
                        const TextSpan(
                          text: '*',
                          style: TextStyle(color: AppColors.red500),
                        ),
                    ],
                  ),
                ),
              ),
              if (trailingCounter != null) ...[
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Text(
                    trailingCounter!,
                    style: AppTypography.body2Medium.copyWith(
                      color: AppColors.neutral950,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
              ],
              const Icon(
                Icons.chevron_right_rounded,
                size: 24,
                color: AppColors.neutral400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({
    required this.background,
    this.icon,
    this.iconColor,
    this.emoji,
  });

  final Color background;
  final IconData? icon;
  final Color? iconColor;
  final String? emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -4,
            top: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -4,
            bottom: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: emoji != null
                ? Text(emoji!, style: const TextStyle(fontSize: 18))
                : Icon(icon, size: 18, color: iconColor ?? AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _AddPrescriptionMedicinesBottomSheet extends StatelessWidget {
  const _AddPrescriptionMedicinesBottomSheet({required this.medicines});

  static const _medicineImagePath =
      'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png';

  final List<_PrescriptionMedicine> medicines;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(top: 8, bottom: 6),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
            ),
            SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16,
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          'Back',
                          style: AppTypography.label2.copyWith(
                            color: AppColors.blue600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Medicines',
                    style: AppTypography.label1SemiBold.copyWith(
                      color: AppColors.neutral950,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space16,
                AppSpacing.space24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MEDICINES',
                    style: AppTypography.label2SemiBold.copyWith(
                      color: AppColors.neutral500,
                      letterSpacing: 0.56,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Row(
                    children: [
                      for (
                        var index = 0;
                        index < medicines.length;
                        index++
                      ) ...[
                        Expanded(
                          child: _MedicineCard(medicine: medicines[index]),
                        ),
                        if (index < medicines.length - 1)
                          const SizedBox(width: AppSpacing.space12),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space24),
                  OutlinedButton(
                    onPressed: () =>
                        showAddPrescriptionMedicineEditorSheet(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      side: const BorderSide(color: AppColors.neutral400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 24, color: AppColors.pink500),
                        const SizedBox(width: AppSpacing.space10),
                        Text(
                          'Add More',
                          style: AppTypography.body2Medium.copyWith(
                            color: AppColors.pink500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({required this.medicine});

  final _PrescriptionMedicine medicine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    _AddPrescriptionMedicinesBottomSheet._medicineImagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Row(
                children: const [
                  _MedicineThumb(isSelected: true),
                  SizedBox(width: AppSpacing.space4),
                  _MedicineThumb(),
                ],
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                medicine.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                medicine.note,
                style: AppTypography.label2.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              const Row(
                children: [
                  _DoseIcon(
                    isActive: true,
                    child: Icon(
                      Icons.wb_sunny_rounded,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: AppSpacing.space10),
                  _DoseIcon(label: 'L'),
                  SizedBox(width: AppSpacing.space10),
                  _DoseIcon(label: 'D'),
                  SizedBox(width: AppSpacing.space10),
                  _DoseIcon(
                    child: Icon(
                      Icons.nights_stay_rounded,
                      size: 16,
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                border: Border.all(color: AppColors.neutral200),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                medicine.quantity,
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineThumb extends StatelessWidget {
  const _MedicineThumb({this.isSelected = false});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isSelected ? AppColors.neutral950 : AppColors.neutral200,
          width: isSelected ? 0.75 : 0.75,
        ),
      ),
      child: Image.asset(
        _AddPrescriptionMedicinesBottomSheet._medicineImagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _DoseIcon extends StatelessWidget {
  const _DoseIcon({this.label, this.child, this.isActive = false});

  final String? label;
  final Widget? child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.blue500 : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child:
          child ??
          Text(
            label!,
            style: AppTypography.label1.copyWith(
              color: AppColors.neutral400,
              fontWeight: FontWeight.w500,
            ),
          ),
    );
  }
}

class _AddPrescriptionMedicineEditorBottomSheet extends StatefulWidget {
  const _AddPrescriptionMedicineEditorBottomSheet();

  @override
  State<_AddPrescriptionMedicineEditorBottomSheet> createState() =>
      _AddPrescriptionMedicineEditorBottomSheetState();
}

class _AddPrescriptionMedicineEditorBottomSheetState
    extends State<_AddPrescriptionMedicineEditorBottomSheet> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  int _pillCount = 2;
  String _selectedWhenToTake = 'Breakfast';
  String _selectedFoodInstruction = 'Before meal';
  List<_SheetAttachment> _attachments = const [
    _SheetAttachment(name: 'WhatsApp-2338340124732.png', sizeLabel: '1.1 MB'),
  ];

  static const _whenToTakeOptions = [
    _SelectionOption(label: 'Breakfast', icon: Icons.wb_sunny_rounded),
    _SelectionOption(label: 'Lunch', letter: 'L'),
    _SelectionOption(label: 'Dinner', letter: 'D'),
    _SelectionOption(label: 'Before Bed', icon: Icons.nights_stay_rounded),
  ];

  static const _foodInstructionOptions = [
    'Empty stomach',
    'Before meal',
    'After meal',
    'With meal',
  ];

  @override
  void dispose() {
    _medicineNameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final sizeInMb = file.size / (1024 * 1024);
    if (sizeInMb > 2) return;

    setState(() {
      _attachments = [
        ..._attachments,
        _SheetAttachment(
          name: file.name,
          sizeLabel: '${sizeInMb.toStringAsFixed(1)} MB',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = mediaQuery.size.height * 0.60;

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
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 8, bottom: 6),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
              ),
              SizedBox(
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space16,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Back',
                            style: AppTypography.label2.copyWith(
                              color: AppColors.blue600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Medicines',
                      style: AppTypography.label1SemiBold.copyWith(
                        color: AppColors.neutral950,
                      ),
                    ),
                  ],
                ),
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
                      _LabeledInputField(
                        label: 'Medicine name',
                        isRequired: true,
                        hint: 'e.g. Thyrox 50, metformin 500mg, etc...',
                        controller: _medicineNameController,
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      _PillCountField(
                        count: _pillCount,
                        onDecrement: () => setState(
                          () =>
                              _pillCount = _pillCount > 1 ? _pillCount - 1 : 1,
                        ),
                        onIncrement: () =>
                            setState(() => _pillCount = _pillCount + 1),
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      _LabeledInputField(
                        label: 'Note',
                        hint: 'e.g. Take with warm water, etc...',
                        controller: _noteController,
                        maxLines: 3,
                        minHeight: 86,
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      _SectionLabel(title: 'WHEN TO TAKE'),
                      const SizedBox(height: AppSpacing.space10),
                      Wrap(
                        spacing: AppSpacing.space8,
                        runSpacing: AppSpacing.space8,
                        children: _whenToTakeOptions
                            .map(
                              (option) => _ChoiceTile(
                                width: 175,
                                label: option.label,
                                icon: option.icon,
                                letter: option.letter,
                                selected: _selectedWhenToTake == option.label,
                                onTap: () => setState(
                                  () => _selectedWhenToTake = option.label,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      _SectionLabel(title: 'FOOD INSTRUCTION'),
                      const SizedBox(height: AppSpacing.space10),
                      Wrap(
                        spacing: AppSpacing.space8,
                        runSpacing: AppSpacing.space8,
                        children: _foodInstructionOptions
                            .map(
                              (option) => _PillChip(
                                label: option,
                                selected: _selectedFoodInstruction == option,
                                onTap: () => setState(
                                  () => _selectedFoodInstruction = option,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      _SectionLabel(title: 'MEDICINE PHOTOS'),
                      const SizedBox(height: AppSpacing.space10),
                      _UploadArea(onTap: _pickFiles),
                      const SizedBox(height: AppSpacing.space10),
                      ..._attachments.map(
                        (attachment) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.space10,
                          ),
                          child: _AttachmentRow(
                            attachment: attachment,
                            onRemove: () => setState(
                              () => _attachments = _attachments
                                  .where((item) => item != attachment)
                                  .toList(),
                            ),
                          ),
                        ),
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
                      'Add',
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

class _AddPrescriptionDetailsBottomSheet extends StatefulWidget {
  const _AddPrescriptionDetailsBottomSheet();

  @override
  State<_AddPrescriptionDetailsBottomSheet> createState() =>
      _AddPrescriptionDetailsBottomSheetState();
}

class _AddPrescriptionDetailsBottomSheetState
    extends State<_AddPrescriptionDetailsBottomSheet> {
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(
    text: '00/00/0000',
  );
  final TextEditingController _specialityController = TextEditingController(
    text: 'Endocrinology',
  );

  @override
  void dispose() {
    _doctorController.dispose();
    _hospitalController.dispose();
    _dateController.dispose();
    _specialityController.dispose();
    super.dispose();
  }

  Future<void> _pickPrescriptionFile() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.86),
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
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 8, bottom: 6),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
              ),
              SizedBox(
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space16,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Back',
                            style: AppTypography.label2.copyWith(
                              color: AppColors.blue600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Prescription details',
                      style: AppTypography.label1SemiBold.copyWith(
                        color: AppColors.neutral950,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space16,
                    AppSpacing.space16,
                    AppSpacing.space16,
                    AppSpacing.space24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PrescriptionUploadArea(onTap: _pickPrescriptionFile),
                      const SizedBox(height: AppSpacing.space20),
                      const _SectionLabel(title: 'PRESCRIPTION DETAILS'),
                      const SizedBox(height: AppSpacing.space10),
                      _LabeledInputField(
                        label: 'Doctor',
                        isRequired: true,
                        hint: 'Type to add or search existing symptom...',
                        controller: _doctorController,
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      _LabeledInputField(
                        label: 'Hospital / Lab',
                        isRequired: true,
                        hint: 'Type to add or search existing symptom...',
                        controller: _hospitalController,
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      _LabeledInputField(
                        label: 'Date',
                        hint: '00/00/0000',
                        controller: _dateController,
                      ),
                      const SizedBox(height: AppSpacing.space10),
                      _LabeledInputField(
                        label: 'Speciality',
                        hint: 'Endocrinology',
                        controller: _specialityController,
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      Text(
                        'ATTACHMENTS',
                        style: AppTypography.label2SemiBold.copyWith(
                          color: AppColors.neutral500,
                          letterSpacing: 0.56,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space12),
                      const _PdfAttachmentCard(),
                      const SizedBox(height: AppSpacing.space12),
                      const _PrescriptionReferenceCard(),
                      const SizedBox(height: AppSpacing.space12),
                      const _PrescriptionReferenceCard(),
                    ],
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

class _SelectionOption {
  const _SelectionOption({required this.label, this.icon, this.letter});

  final String label;
  final IconData? icon;
  final String? letter;
}

class _SheetAttachment {
  const _SheetAttachment({required this.name, required this.sizeLabel});

  final String name;
  final String sizeLabel;
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.label3.copyWith(
        color: AppColors.neutral500,
        letterSpacing: 0.48,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PrescriptionUploadArea extends StatelessWidget {
  const _PrescriptionUploadArea({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: AppSpacing.space24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.neutral300),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFDDEAFF),
              AppColors.white,
              Color(0xFFFFF2C9),
              Color(0xFFFBE4F5),
            ],
            stops: [0.0, 0.35, 0.78, 1.0],
          ),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.file_upload_outlined,
              size: 24,
              color: AppColors.pink500,
            ),
            const SizedBox(height: AppSpacing.space12),
            SizedBox(
              width: 246,
              child: Text(
                'Upload file for AI to\nautomatically fetch details',
                textAlign: TextAlign.center,
                style: AppTypography.label1Bold.copyWith(
                  color: AppColors.neutral950,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Max upto 2 mb per file upload',
              style: AppTypography.label2.copyWith(color: AppColors.neutral500),
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space4,
              children: const [
                _FormatChip(label: 'PDF'),
                _FormatChip(label: 'JPG'),
                _FormatChip(label: 'PNG'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledInputField extends StatelessWidget {
  const _LabeledInputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.isRequired = false,
    this.maxLines = 1,
    this.minHeight = 55,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isRequired;
  final int maxLines;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: AppTypography.caption1.copyWith(
                color: AppColors.neutral500,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: AppColors.red700),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: AppTypography.body3.copyWith(color: AppColors.neutral950),
            decoration: InputDecoration(
              isDense: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: hint,
              hintStyle: AppTypography.body3.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillCountField extends StatelessWidget {
  const _PillCountField({
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 55),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Number of Pills / Unit',
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$count',
                  style: AppTypography.body3.copyWith(
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _QuantityButton(icon: Icons.remove, onTap: onDecrement),
              const SizedBox(width: AppSpacing.space4),
              _QuantityButton(icon: Icons.add, onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: const Color(0xFFBEBEBE)),
        ),
        child: Icon(icon, size: 24, color: AppColors.neutral950),
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.letter,
    this.width = 175,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final String? letter;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? AppColors.white : AppColors.neutral500;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
          color: selected ? AppColors.blue500 : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: selected ? AppColors.blue500 : AppColors.neutral200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, size: 16, color: textColor)
            else if (letter != null)
              Text(
                letter!,
                style: AppTypography.label1.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(width: AppSpacing.space8),
            Text(
              label,
              style: AppTypography.body3.copyWith(
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? AppColors.blue500 : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: selected ? AppColors.blue500 : AppColors.neutral200,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.label3.copyWith(
            color: selected ? AppColors.white : AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _UploadArea extends StatelessWidget {
  const _UploadArea({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: AppSpacing.space24,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: AppColors.neutral300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.file_upload_outlined,
              size: 24,
              color: AppColors.pink500,
            ),
            const SizedBox(height: AppSpacing.space12),
            Text(
              'Tap to upload',
              style: AppTypography.label1Bold.copyWith(
                color: AppColors.neutral950,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Max upto 2 mb per file upload',
              style: AppTypography.label2.copyWith(color: AppColors.neutral500),
            ),
            const SizedBox(height: AppSpacing.space12),
            Wrap(
              spacing: AppSpacing.space4,
              children: const [
                _FormatChip(label: 'PDF'),
                _FormatChip(label: 'JPG'),
                _FormatChip(label: 'PNG'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormatChip extends StatelessWidget {
  const _FormatChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Text(
        label,
        style: AppTypography.label2.copyWith(color: AppColors.neutral500),
      ),
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  const _AttachmentRow({required this.attachment, required this.onRemove});

  final _SheetAttachment attachment;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file_rounded,
            size: 24,
            color: AppColors.sky500,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Text(
              attachment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.label2SemiBold.copyWith(
                color: AppColors.neutral950,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          Text(
            attachment.sizeLabel,
            style: AppTypography.label2.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(width: AppSpacing.space4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close,
              size: 24,
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PdfAttachmentCard extends StatelessWidget {
  const _PdfAttachmentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf_rounded,
            size: 24,
            color: AppColors.red500,
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thyroid_Jan25.pdf',
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  '24.4 MB',
                  style: AppTypography.label2.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_outward_rounded,
            size: 24,
            color: AppColors.neutral500,
          ),
        ],
      ),
    );
  }
}

class _PrescriptionReferenceCard extends StatelessWidget {
  const _PrescriptionReferenceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
            decoration: BoxDecoration(
              color: AppColors.pink950,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                Text(
                  '14',
                  style: AppTypography.h6SemiBold.copyWith(
                    color: AppColors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'JAN',
                  style: AppTypography.label3SemiBold.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                Text(
                  '2025',
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 files • PDF + 2 photos',
                  style: AppTypography.label3.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'SRL Diagnostics, Baner',
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Ref. Dr. Meena Sharma',
                  style: AppTypography.label2.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          const Icon(
            Icons.chevron_right_rounded,
            size: 24,
            color: AppColors.neutral500,
          ),
        ],
      ),
    );
  }
}
