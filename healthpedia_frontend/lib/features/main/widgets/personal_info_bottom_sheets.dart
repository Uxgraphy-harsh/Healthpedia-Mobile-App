import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_date_picker.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_select.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/features/main/widgets/profile_info_sheet_scaffold.dart';
import 'horizontal_wheel_picker.dart';

class _BaseInfoSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onUpdate;

  const _BaseInfoSheet({
    required this.title,
    required this.child,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileInfoSheetScaffold(
      title: title,
      primaryLabel: 'Update',
      onPrimaryTap: () {
        onUpdate();
        Navigator.pop(context);
      },
      child: child,
    );
  }
}

// --- 1. Edit Date of Birth ---
class EditDOBBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onUpdate;

  const EditDOBBottomSheet({
    super.key,
    required this.initialDate,
    required this.onUpdate,
  });

  @override
  State<EditDOBBottomSheet> createState() => _EditDOBBottomSheetState();
}

class _EditDOBBottomSheetState extends State<EditDOBBottomSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit date of birth',
      onUpdate: () => widget.onUpdate(_selectedDate),
      child: PremiumDatePicker(
        label: 'Date of birth',
        value: _selectedDate,
        isDark: false,
        onDateSelected: (value) => setState(() => _selectedDate = value),
      ),
    );
  }
}

// --- 2. Edit Age ---
class EditAgeBottomSheet extends StatelessWidget {
  final int initialAge;
  final ValueChanged<int> onUpdate;

  const EditAgeBottomSheet({
    super.key,
    required this.initialAge,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    int currentAge = initialAge;
    return _BaseInfoSheet(
      title: 'Edit age',
      onUpdate: () => onUpdate(currentAge),
      child: HorizontalWheelPicker(
        minValue: 1, 
        maxValue: 120, 
        initialValue: initialAge, 
        unit: 'years',
        isDark: false,
        onChanged: (val) => currentAge = val,
      ),
    );
  }
}

// --- 3. Edit Gender ---
class EditGenderBottomSheet extends StatefulWidget {
  final String initialGender;
  final ValueChanged<String> onUpdate;

  const EditGenderBottomSheet({
    super.key,
    required this.initialGender,
    required this.onUpdate,
  });

  @override
  State<EditGenderBottomSheet> createState() => _EditGenderBottomSheetState();
}

class _EditGenderBottomSheetState extends State<EditGenderBottomSheet> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit gender',
      onUpdate: () => widget.onUpdate(_selected),
      child: PremiumSelect<String>(
        value: _selected,
        placeholder: 'Gender',
        items: const ['Male', 'Female', 'Other'],
        isDark: false,
        onChanged: (val) {
          if (val != null) {
            setState(() => _selected = val);
          }
        },
      ),
    );
  }
}

// --- 4. Edit Height ---
class EditHeightBottomSheet extends StatelessWidget {
  final int initialHeight;
  final ValueChanged<int> onUpdate;

  const EditHeightBottomSheet({
    super.key,
    required this.initialHeight,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    int currentHeight = initialHeight;
    return _BaseInfoSheet(
      title: 'Edit height',
      onUpdate: () => onUpdate(currentHeight),
      child: HorizontalWheelPicker(
        minValue: 50, 
        maxValue: 250, 
        initialValue: initialHeight, 
        unit: 'cm',
        isDark: false,
        onChanged: (val) => currentHeight = val,
      ),
    );
  }
}

// --- 5. Edit Weight ---
class EditWeightBottomSheet extends StatelessWidget {
  final int initialWeight;
  final ValueChanged<int> onUpdate;

  const EditWeightBottomSheet({
    super.key,
    required this.initialWeight,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    int currentWeight = initialWeight;
    return _BaseInfoSheet(
      title: 'Edit weight',
      onUpdate: () => onUpdate(currentWeight),
      child: HorizontalWheelPicker(
        minValue: 20, 
        maxValue: 200, 
        initialValue: initialWeight, 
        unit: 'kg',
        isDark: false,
        onChanged: (val) => currentWeight = val,
      ),
    );
  }
}

// --- 6. Edit Blood Group ---
class EditBloodGroupBottomSheet extends StatefulWidget {
  final String initialGroup;
  final ValueChanged<String> onUpdate;

  const EditBloodGroupBottomSheet({
    super.key,
    required this.initialGroup,
    required this.onUpdate,
  });

  @override
  State<EditBloodGroupBottomSheet> createState() => _EditBloodGroupBottomSheetState();
}

class _EditBloodGroupBottomSheetState extends State<EditBloodGroupBottomSheet> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialGroup;
  }

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit blood group',
      onUpdate: () => widget.onUpdate(_selected),
      child: PremiumSelect<String>(
        value: _selected,
        placeholder: 'Blood Group',
        items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
        isDark: false,
        onChanged: (val) {
          if (val != null) {
            setState(() => _selected = val);
          }
        },
      ),
    );
  }
}

// --- 7. Edit City ---
class EditCityBottomSheet extends StatefulWidget {
  final String initialCity;
  final ValueChanged<String> onUpdate;

  const EditCityBottomSheet({
    super.key,
    required this.initialCity,
    required this.onUpdate,
  });

  @override
  State<EditCityBottomSheet> createState() => _EditCityBottomSheetState();
}

class _EditCityBottomSheetState extends State<EditCityBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCity);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit city',
      onUpdate: () => widget.onUpdate(_controller.text),
      child: PremiumTextField(
        label: 'City',
        controller: _controller,
        isDark: false,
      ),
    );
  }
}
