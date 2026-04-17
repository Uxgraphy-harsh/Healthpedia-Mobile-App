import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/widgets/premium_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'repeat_bottom_sheet.dart';

class AddReminderBottomSheet extends StatefulWidget {
  const AddReminderBottomSheet({super.key});

  @override
  State<AddReminderBottomSheet> createState() => _AddReminderBottomSheetState();
}

class _AddReminderBottomSheetState extends State<AddReminderBottomSheet> {
  String selectedType = 'Medicine';
  bool isAM = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<String> _selectedDays = ['Sunday']; // default matches Figma
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// Returns a human-readable label for the selected repeat days
  String get _repeatLabel {
    const allDays = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    const weekends = ['Saturday', 'Sunday'];
    final sorted = List<String>.from(_selectedDays)
      ..sort((a, b) => allDays.indexOf(a).compareTo(allDays.indexOf(b)));
    if (sorted.length == 7) return 'Everyday';
    if (sorted.toSet().containsAll(weekdays) && sorted.length == 5) return 'Weekdays';
    if (sorted.toSet().containsAll(weekends) && sorted.length == 2) return 'Weekends';
    return sorted.map((d) => d.substring(0, 3)).join(', ');
  }

  Future<void> _openRepeatSheet(BuildContext context) async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RepeatBottomSheet(initialSelected: _selectedDays),
    );
    if (result != null && result.isNotEmpty) {
      setState(() => _selectedDays = result);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0A0A0A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF0A0A0A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0A0A0A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF0A0A0A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        isAM = picked.period == DayPeriod.am;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PremiumBottomSheet(
      title: 'Add reminder',
      leadingLabel: 'Cancel',
      onLeadingTap: () => Navigator.of(context).pop(),
      footer: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Save Reminder',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel('REMINDER'),
          const SizedBox(height: 10),
          
          // Title Field
          PremiumTextField(
            controller: _titleController,
            label: 'Title',
            placeholder: 'Thyroid Medicine',
            isDark: false,
            forceLabelInside: true,
          ),
          const SizedBox(height: 16),
          
          // Date & Time Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PremiumTextField(
                  label: 'Date',
                  placeholder: _selectedDate != null 
                      ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
                      : '00/00/0000',
                  onTap: () => _selectDate(context),
                  isDark: false,
                  forceLabelInside: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PremiumTextField(
                  label: 'Time',
                  placeholder: _selectedTime != null 
                      ? "${_selectedTime!.hourOfPeriod == 0 ? 12 : _selectedTime!.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')} ${isAM ? 'AM' : 'PM'}"
                      : '00:00 AM',
                  onTap: () => _selectTime(context),
                  isDark: false,
                  forceLabelInside: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Repeat Field
          PremiumTextField(
            label: 'Repeat',
            placeholder: _repeatLabel,
            onTap: () => _openRepeatSheet(context),
            showTrailingChevron: true,
            isDark: false,
            forceLabelInside: true,
          ),
          
          const SizedBox(height: 20),
          _buildSectionLabel('TYPE', isRequired: true),
          const SizedBox(height: 10),
          
          // Type Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTypeChip('Appointment'),
              _buildTypeChip('Medicine'),
              _buildTypeChip('Report collection'),
              _buildTypeChip('Food'),
              _buildTypeChip('General reminder'),
            ],
          ),
          
          const SizedBox(height: 20),
          _buildSectionLabel('ADDITIONAL INFORMATION'),
          const SizedBox(height: 10),
          
          // Description Field
          PremiumTextField(
            controller: _descriptionController,
            label: 'Description',
            placeholder: 'Write or paste a link',
            isDark: false,
            maxLines: 4,
            forceLabelInside: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF737373),
          letterSpacing: 0.48,
        ),
        children: [
          TextSpan(text: text),
          if (isRequired)
            const TextSpan(
              text: '*',
              style: TextStyle(color: Color(0xFFB91C1C)),
            ),
        ],
      ),
    );
  }


  Widget _buildTypeChip(String type) {
    final bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC2410C) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? const Color(0xFFC2410C) : const Color(0xFFE5E5E5),
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 12,
            color: isSelected ? Colors.white : const Color(0xFF737373),
          ),
        ),
      ),
    );
  }
}
