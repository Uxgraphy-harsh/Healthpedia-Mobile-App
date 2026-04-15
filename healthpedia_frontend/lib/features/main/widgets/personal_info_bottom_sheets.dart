import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'horizontal_wheel_picker.dart';

// --- Base Widget for Common UI ---
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
          const SizedBox(height: 8),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          _buildHeader(context),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                onUpdate();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neutral950,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                elevation: 0,
              ),
              child: Text('Update', style: AppTypography.label1.copyWith(fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text('Cancel', style: AppTypography.label1.copyWith(color: AppColors.blue600, fontWeight: FontWeight.w400)),
            ),
          ),
          Text(title, style: AppTypography.h6.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// --- 1. Edit Date of Birth ---
class EditDOBBottomSheet extends StatefulWidget {
  const EditDOBBottomSheet({super.key});
  @override
  State<EditDOBBottomSheet> createState() => _EditDOBBottomSheetState();
}

class _EditDOBBottomSheetState extends State<EditDOBBottomSheet> {
  DateTime _selectedDate = DateTime(2001, 12, 4);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.blue600, onPrimary: AppColors.white, onSurface: AppColors.neutral950),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit date of birth',
      onUpdate: () {},
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date of birth', style: AppTypography.label1.copyWith(color: AppColors.neutral950)),
              Text('${_selectedDate.day.toString().padLeft(2, '0')} / ${_selectedDate.month.toString().padLeft(2, '0')} / ${_selectedDate.year}', 
                   style: AppTypography.label1.copyWith(color: AppColors.neutral950)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. Edit Age ---
class EditAgeBottomSheet extends StatelessWidget {
  const EditAgeBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    int currentAge = 48;
    return _BaseInfoSheet(
      title: 'Edit age',
      onUpdate: () {},
      child: HorizontalWheelPicker(
        minValue: 1, maxValue: 120, initialValue: 48, unit: 'years',
        onChanged: (val) => currentAge = val,
      ),
    );
  }
}

// --- 3. Edit Gender ---
class EditGenderBottomSheet extends StatefulWidget {
  const EditGenderBottomSheet({super.key});
  @override
  State<EditGenderBottomSheet> createState() => _EditGenderBottomSheetState();
}

class _EditGenderBottomSheetState extends State<EditGenderBottomSheet> {
  String _selected = 'Male';
  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit gender',
      onUpdate: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: ['Male', 'Female', 'Other'].map((g) {
            final isSelected = _selected == g;
            return Expanded(
              child: GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); setState(() => _selected = g); },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : null,
                  ),
                  child: Center(
                    child: Text(g, style: AppTypography.label2.copyWith(color: isSelected ? AppColors.neutral950 : AppColors.neutral500, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// --- 4. Edit Height ---
class EditHeightBottomSheet extends StatelessWidget {
  const EditHeightBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    int currentHeight = 169;
    return _BaseInfoSheet(
      title: 'Edit height',
      onUpdate: () {},
      child: HorizontalWheelPicker(
        minValue: 50, maxValue: 250, initialValue: 169, unit: 'cm',
        onChanged: (val) => currentHeight = val,
      ),
    );
  }
}

// --- 5. Edit Weight ---
class EditWeightBottomSheet extends StatelessWidget {
  const EditWeightBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    int currentWeight = 68;
    return _BaseInfoSheet(
      title: 'Edit weight',
      onUpdate: () {},
      child: HorizontalWheelPicker(
        minValue: 20, maxValue: 200, initialValue: 68, unit: 'kg',
        onChanged: (val) => currentWeight = val,
      ),
    );
  }
}

// --- 6. Edit Blood Group ---
class EditBloodGroupBottomSheet extends StatefulWidget {
  const EditBloodGroupBottomSheet({super.key});
  @override
  State<EditBloodGroupBottomSheet> createState() => _EditBloodGroupBottomSheetState();
}

class _EditBloodGroupBottomSheetState extends State<EditBloodGroupBottomSheet> {
  String _selected = 'O+';
  final List<String> _groups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit blood group',
      onUpdate: () {},
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selected,
            isExpanded: true,
            icon: const Icon(Icons.expand_more, color: AppColors.neutral500),
            items: _groups.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (val) { if (val != null) setState(() => _selected = val); },
          ),
        ),
      ),
    );
  }
}

// --- 7. Edit City ---
class EditCityBottomSheet extends StatefulWidget {
  const EditCityBottomSheet({super.key});
  @override
  State<EditCityBottomSheet> createState() => _EditCityBottomSheetState();
}

class _EditCityBottomSheetState extends State<EditCityBottomSheet> {
  final TextEditingController _controller = TextEditingController(text: 'Pune, Maharashtra');
  final List<String> _suggestions = ['Pune, Maharashtra', 'Mumbai, Maharashtra', 'Bangalore, Karnataka', 'Delhi, NCR', 'Hyderabad, Telangana'];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoSheet(
      title: 'Edit city',
      onUpdate: () {},
      child: Autocomplete<String>(
        initialValue: const TextEditingValue(text: 'Pune, Maharashtra'),
        optionsBuilder: (TextEditingValue value) {
          if (value.text == '') return const Iterable<String>.empty();
          return _suggestions.where((s) => s.toLowerCase().contains(value.text.toLowerCase()));
        },
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          return Container(
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text('City', style: AppTypography.label1.copyWith(color: AppColors.neutral950)),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'Enter city'),
                    style: AppTypography.label1.copyWith(color: AppColors.neutral950),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
