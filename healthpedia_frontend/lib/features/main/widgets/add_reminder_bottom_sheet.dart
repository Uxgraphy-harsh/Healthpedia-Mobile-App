import 'package:flutter/material.dart';
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Home Indicator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        color: Color(0xFF2563EB), // Blue 600
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Add reminder',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE5E5E5)),

          // Form Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('REMINDER'),
                  const SizedBox(height: 10),
                  
                  // Title Field
                  _buildTextField(
                    label: 'Title',
                    placeholder: 'Thyroid Medicine',
                    isRequired: true,
                    controller: _titleController,
                  ),
                  const SizedBox(height: 8),
                  
                  // Date & Time Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Date',
                          placeholder: _selectedDate != null 
                              ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
                              : '00/00/0000',
                          isReadOnly: true,
                          onTap: () => _selectDate(context),
                          textStyle: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: _selectedDate != null ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectTime(context),
                          child: _buildTimeField(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Repeat Field
                  _buildTextField(
                    label: 'Repeat',
                    placeholder: _repeatLabel,
                    isReadOnly: true,
                    showArrow: true,
                    onTap: () => _openRepeatSheet(context),
                    textStyle: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0A0A0A),
                    ),
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
                  _buildTextField(
                    label: 'Description',
                    placeholder: 'Write or paste a link',
                    controller: _descriptionController,
                    height: 86,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action: Save logic
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
                  const SizedBox(height: 8),
                ],
              ),
            ),
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

  Widget _buildTextField({
    required String label,
    required String placeholder,
    bool isRequired = false,
    bool isReadOnly = false,
    bool showArrow = false,
    TextEditingController? controller,
    double? height,
    TextStyle? textStyle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  color: Color(0xFF737373),
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: label),
                  if (isRequired)
                    const TextSpan(
                      text: '*',
                      style: TextStyle(color: Color(0xFFB91C1C)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: height == null ? 22 : height - 35,
              child: Row(
                children: [
                  Expanded(
                    child: isReadOnly
                        ? Text(
                            placeholder,
                            style: textStyle ??
                                const TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFA3A3A3),
                                ),
                          )
                        : TextField(
                            controller: controller,
                            cursorColor: const Color(0xFF0A0A0A),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: placeholder,
                              hintStyle: const TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA3A3A3),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                            ),
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF0A0A0A),
                            ),
                          ),
                  ),
                  if (showArrow)
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF0A0A0A)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Time',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 22,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedTime != null 
                      ? "${_selectedTime!.hourOfPeriod == 0 ? 12 : _selectedTime!.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                      : '00:00',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: _selectedTime != null ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => isAM = true),
                  child: Text(
                    'AM',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 15,
                      fontWeight: isAM ? FontWeight.w600 : FontWeight.w400,
                      color: isAM ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => isAM = false),
                  child: Text(
                    'PM',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 15,
                      fontWeight: !isAM ? FontWeight.w600 : FontWeight.w400,
                      color: !isAM ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ],
            ),
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
