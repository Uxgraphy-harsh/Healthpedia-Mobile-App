import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_file_drop.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

/// Shows the "Add symptom" bottom sheet (≤60% screen height, scrollable).
Future<void> showAddSymptomSheet(
  BuildContext context, {
  required List<String> existingSymptoms,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddSymptomBottomSheet(existingSymptoms: existingSymptoms),
  );
}

class AddSymptomBottomSheet extends StatefulWidget {
  final List<String> existingSymptoms;

  const AddSymptomBottomSheet({super.key, required this.existingSymptoms});

  @override
  State<AddSymptomBottomSheet> createState() => _AddSymptomBottomSheetState();
}

class _AddSymptomBottomSheetState extends State<AddSymptomBottomSheet> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _nameFocus = FocusNode();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isAM = true;
  bool _isPassed = true; // Passed vs Ongoing
  int _severity = 0; // 0 = none selected, 1-5
  final Set<String> _selectedAlongside = {};
  final Set<String> _selectedTriggers = {};
  final List<PlatformFile> _attachments = [];
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  // Figma data for chips
  static const _alongsideOptions = [
    'Dizziness',
    'Headache',
    'Throat tightness',
    'Stress',
    'Nausea',
  ];

  static const _triggerOptions = [
    'After meal',
    'On waking up',
    'After activity',
    'Stress',
    'After medication',
    'Random',
  ];

  // Severity colors from Figma Range component (per level)
  // Level 1: Blue    Level 2: Teal    Level 3: Amber
  // Level 4: Orange  Level 5: Red/Pink
  static const _severityColors = <int, _SeverityStyle>{
    1: _SeverityStyle(
      bg: Color(0xFFDBEAFE),   // blue/100
      border: Color(0xFF3B82F6), // blue/500
      text: Color(0xFF1D4ED8),   // blue/700
    ),
    2: _SeverityStyle(
      bg: Color(0xFFCCFBF1),   // teal/100
      border: Color(0xFF14B8A6), // teal/500
      text: Color(0xFF0F766E),   // teal/700
    ),
    3: _SeverityStyle(
      bg: Color(0xFFFEF3C7),   // amber/100
      border: Color(0xFFF59E0B), // amber/500
      text: Color(0xFFB45309),   // amber/700
    ),
    4: _SeverityStyle(
      bg: Color(0xFFFFEDD5),   // orange/100
      border: Color(0xFFF97316), // orange/500
      text: Color(0xFFC2410C),   // orange/700
    ),
    5: _SeverityStyle(
      bg: Color(0xFFFFE4E6),   // rose/100
      border: Color(0xFFF43F5E), // rose/500
      text: Color(0xFFBE123C),   // rose/700
    ),
  };

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        setState(() => _showSuggestions = false);
      }
    });
  }

  void _onNameChanged() {
    final q = _nameController.text.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }
    final matches = widget.existingSymptoms
        .where((s) => s.toLowerCase().contains(q))
        .toList();
    setState(() {
      _suggestions = matches;
      _showSuggestions = matches.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0A0A0A),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF0A0A0A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0A0A0A),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF0A0A0A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _isAM = picked.period == DayPeriod.am;
      });
    }
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        for (final f in result.files) {
          // Max 2MB check
          if ((f.size / (1024 * 1024)) <= 2) {
            _attachments.add(f);
          }
        }
      });
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    return '${h.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Standard consistent height for Medium data entry sheets
    final maxHeight = screenHeight * 0.70;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
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
          // ── Drag handle ──
          // Removed manual bar as Android provides default, keeping space
          PremiumSheetHeader(
            title: 'Add symptom',
            leadingLabel: 'Cancel',
            onLeadingTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 0),

          // ── Scrollable content ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── SYMPTOM ──
                  _sectionLabel('SYMPTOM'),
                  const SizedBox(height: 8),
                  _buildNameField(),
                  if (_showSuggestions) _buildSuggestionsList(),
                  const SizedBox(height: 12),

                  // ── Date / Time row ──
                  Row(
                    children: [
                      Expanded(child: _buildDateField()),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTimeField()),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ── Passed / Ongoing toggle ──
                  _buildStatusToggle(),
                  const SizedBox(height: 20),

                  // ── SEVERITY ──
                  _sectionLabel('SEVERITY'),
                  const SizedBox(height: 8),
                  _buildSeverityRow(),
                  const SizedBox(height: 20),

                  // ── ALONGSIDE ──
                  _sectionLabel('ALONGSIDE'),
                  const SizedBox(height: 8),
                  _buildChipWrap(_alongsideOptions, _selectedAlongside),
                  const SizedBox(height: 20),

                  // ── POSSIBLE TRIGGER ──
                  _sectionLabel('POSSIBLE TRIGGER'),
                  const SizedBox(height: 8),
                  _buildChipWrap(_triggerOptions, _selectedTriggers),
                  const SizedBox(height: 20),

                  // ── ADDITIONAL INFORMATION ──
                  _sectionLabel('ADDITIONAL INFORMATION'),
                  const SizedBox(height: 8),
                  _buildNoteField(),
                  const SizedBox(height: 20),

                  // ── ATTACHMENTS ──
                  _sectionLabel('ATTACHMENTS'),
                  const SizedBox(height: 8),
                  _buildUploadArea(),
                  const SizedBox(height: 8),
                  ..._attachments.asMap().entries.map((e) =>
                      _buildAttachmentTile(e.key, e.value)),
                  const SizedBox(height: 24),

                  // ── Save Symptom CTA ──
                  // Removed from here to make it sticky
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  // ─── Section label ─────────────────────────────────────────────────
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Color(0xFF737373),
      ),
    );
  }


  // ─── Symptom name field ────────────────────────────────────────────
  Widget _buildNameField() {
    return PremiumTextField(
      controller: _nameController,
      label: 'Symptom name',
      placeholder: 'Type to add or search...',
      isDark: false,
    );
  }

  // ─── Autocomplete suggestions ──────────────────────────────────────
  Widget _buildSuggestionsList() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _suggestions
            .take(4)
            .map((s) => InkWell(
                  onTap: () {
                    _nameController.text = s;
                    _nameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: s.length),
                    );
                    setState(() => _showSuggestions = false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        s,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ─── Date field ────────────────────────────────────────────────────
  Widget _buildDateField() {
    return PremiumTextField(
      label: 'Date',
      placeholder: _selectedDate != null ? _formatDate(_selectedDate!) : '00/00/0000',
      onTap: _selectDate,
      isDark: false,
    );
  }

  // ─── Time field ────────────────────────────────────────────────────
  Widget _buildTimeField() {
    return PremiumTextField(
      label: 'Time',
      placeholder: _selectedTime != null ? _formatTime(_selectedTime!) : '00:00',
      onTap: _selectTime,
      isDark: false,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isAM = true),
            child: Text(
              'AM',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: _isAM ? FontWeight.w600 : FontWeight.w400,
                color: _isAM ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => _isAM = false),
            child: Text(
              'PM',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: !_isAM ? FontWeight.w600 : FontWeight.w400,
                color: !_isAM ? const Color(0xFF0A0A0A) : const Color(0xFFA3A3A3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Passed / Ongoing toggle ───────────────────────────────────────
  Widget _buildStatusToggle() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // neutral/100
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isPassed = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      _isPassed ? const Color(0xFF3B82F6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Passed',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isPassed ? Colors.white : const Color(0xFF737373),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isPassed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !_isPassed
                      ? const Color(0xFF3B82F6)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Ongoing',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: !_isPassed ? Colors.white : const Color(0xFF737373),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Severity row (1-5 colored boxes) ──────────────────────────────
  Widget _buildSeverityRow() {
    return Row(
      children: List.generate(5, (i) {
        final level = i + 1;
        final isSelected = _severity >= level;
        final style = _severityColors[level]!;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _severity = _severity == level ? 0 : level);
            },
            child: Container(
              margin: EdgeInsets.only(right: i < 4 ? 8 : 0),
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? style.bg : Colors.white,
                border: Border.all(
                  color: isSelected ? style.border : const Color(0xFFE5E5E5),
                  width: isSelected ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                '$level',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? style.text : const Color(0xFF737373),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ─── Chip wrap (Alongside / Trigger) ───────────────────────────────
  Widget _buildChipWrap(List<String> options, Set<String> selected) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((label) {
        final isActive = selected.contains(label);
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() {
              if (isActive) {
                selected.remove(label);
              } else {
                selected.add(label);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF3B82F6) // Blue/500
                  : Colors.white,
              border: Border.all(
                color: isActive
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFD4D4D4),
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.white : const Color(0xFF525252),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── Additional info / Note textarea ───────────────────────────────
  Widget _buildNoteField() {
    return PremiumTextField(
      controller: _noteController,
      label: 'Note',
      placeholder: 'Write or paste a link',
      maxLines: 4,
      isDark: false,
    );
  }

  // ─── Upload area ───────────────────────────────────────────────────
  Widget _buildUploadArea() {
    return PremiumFileDrop(
      onBrowse: _pickFiles,
      isDark: false,
    );
  }

  // ─── Attachment tile ───────────────────────────────────────────────
  Widget _buildAttachmentTile(int index, PlatformFile file) {
    final ext = file.extension?.toLowerCase() ?? '';
    final isPdf = ext == 'pdf';
    final isImage = ext == 'jpg' || ext == 'jpeg' || ext == 'png';
    
    IconData iconData = Icons.insert_drive_file_outlined;
    Color iconColor = const Color(0xFFA3A3A3); // AppColors.neutral500
    
    if (isPdf) {
      iconData = Icons.picture_as_pdf_outlined;
      iconColor = const Color(0xFFDC2626); // AppColors.red600
    } else if (isImage) {
      iconData = Icons.image_outlined;
      iconColor = ext == 'png' ? const Color(0xFF0284C7) : const Color(0xFFEA580C); // AppColors.sky600 : AppColors.orange600
      if (ext == 'png') iconColor = const Color(0xFF14B8A6); // Teal 500 matching screenshot
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // AppColors.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)), // AppColors.neutral200
      ),
      child: Row(
        children: [
          Icon(iconData, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              file.name,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0A),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // File size
          Text(
            _formatFileSize(file.size),
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(width: 8),
          // Remove button
          GestureDetector(
            onTap: () => setState(() => _attachments.removeAt(index)),
            child: const Icon(
              Icons.close,
              size: 18,
              color: Color(0xFF737373),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Save button ───────────────────────────────────────────────────
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          // TODO: Save logic
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A0A0A), // black
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Save Symptom',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Per-level severity color set
class _SeverityStyle {
  final Color bg;
  final Color border;
  final Color text;
  const _SeverityStyle({
    required this.bg,
    required this.border,
    required this.text,
  });
}
