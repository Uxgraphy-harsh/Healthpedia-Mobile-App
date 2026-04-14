import 'package:flutter/material.dart';

class RepeatBottomSheet extends StatefulWidget {
  /// Pre-selected days passed from the parent sheet, e.g. ['Sunday']
  final List<String> initialSelected;
  const RepeatBottomSheet({super.key, this.initialSelected = const []});

  @override
  State<RepeatBottomSheet> createState() => _RepeatBottomSheetState();
}

class _RepeatBottomSheetState extends State<RepeatBottomSheet> {
  static const _days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    // Default to Sunday selected if nothing is passed (matches Figma default)
    _selected = widget.initialSelected.isEmpty
        ? {'Sunday'}
        : Set<String>.from(widget.initialSelected);
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
          // Home Indicator — 40×5px, 10% black opacity
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          // Header — Back (Blue 600) + centred "Repeat" title
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Return selected days back to the parent sheet
                        Navigator.of(context).pop(_selected.toList());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2563EB), // Blue 600
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Repeat',
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
          ),

          // Options List
          ..._days.asMap().entries.map((entry) {
            final int idx = entry.key;
            final String day = entry.value;
            final bool isSelected = _selected.contains(day);
            final bool isLast = idx == _days.length - 1;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    // Keep at least one day selected
                    if (_selected.length > 1) _selected.remove(day);
                  } else {
                    _selected.add(day);
                  }
                });
              },
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(color: Color(0xFFE5E5E5)),
                        ),
                ),
                child: Row(
                  children: [
                    // Day label — Geist Medium 16px, Neutral 950
                    Expanded(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Checkmark circle — 24×24px
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF3B82F6).withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3B82F6) // Blue 500
                              : const Color(0xFFA3A3A3), // Neutral 400
                          width: 1.5,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Color(0xFF3B82F6),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
