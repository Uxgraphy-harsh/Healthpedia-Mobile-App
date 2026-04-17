import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/widgets/premium_sheet_header.dart';

enum SortOption { newestFirst, oldestFirst, mostFiles, labNameAZ }

extension SortOptionLabel on SortOption {
  String get label {
    switch (this) {
      case SortOption.newestFirst:
        return 'Newest date first';
      case SortOption.oldestFirst:
        return 'Oldest data first';
      case SortOption.mostFiles:
        return 'Most files';
      case SortOption.labNameAZ:
        return 'Lab name A-Z';
    }
  }
}

class SortBottomSheet extends StatefulWidget {
  final SortOption initialSort;
  const SortBottomSheet({super.key, this.initialSort = SortOption.newestFirst});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late SortOption _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSort;
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
          PremiumSheetHeader(
            title: 'Sort by',
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(null),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2563EB), // Blue 600
                  ),
                ),
              ),
            ),
          ),

          // ── Options ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: SortOption.values.asMap().entries.map((entry) {
                final int idx = entry.key;
                final SortOption opt = entry.value;
                final bool isSelected = _selected == opt;
                final bool isLast = idx == SortOption.values.length - 1;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() => _selected = opt);
                    // Slight delay so user sees the selection before close
                    Future.delayed(const Duration(milliseconds: 150), () {
                      if (mounted) Navigator.of(context).pop(_selected);
                    });
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 9.5),
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
                        // Option label — Medium 16px, Neutral 950
                        Expanded(
                          child: Text(
                            opt.label,
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A0A0A),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // Check icon — Material Icons.check, shown only when selected
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            size: 24,
                            color: Color(0xFF0A0A0A), // Neutral 950
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
