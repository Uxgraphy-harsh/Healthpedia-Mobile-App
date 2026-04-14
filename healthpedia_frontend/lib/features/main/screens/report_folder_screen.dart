import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/sort_bottom_sheet.dart';
import 'report_detail_screen.dart';

// ─────────────────────────── Data models ─────────────────────────────────────

class ReportFile {
  final String name;
  final bool isPdf; // true = PDF icon, false = image icon
  const ReportFile({required this.name, required this.isPdf});
}

class ReportEntry {
  final int day;
  final String month; // 'JAN', 'FEB', …
  final int year;
  final int fileCount;
  final String fileTypeLabel; // e.g. 'PDF + 2 photos'
  final String labName;
  final String doctorRef;
  final String note;
  final List<ReportFile> files;
  const ReportEntry({
    required this.day,
    required this.month,
    required this.year,
    required this.fileCount,
    required this.fileTypeLabel,
    required this.labName,
    required this.doctorRef,
    required this.note,
    required this.files,
  });
}

// ─────────────────────────── Screen ──────────────────────────────────────────

class ReportFolderScreen extends StatefulWidget {
  final String folderTitle;
  final int totalFiles;
  final List<ReportEntry> entries;

  const ReportFolderScreen({
    super.key,
    required this.folderTitle,
    required this.totalFiles,
    required this.entries,
  });

  @override
  State<ReportFolderScreen> createState() => _ReportFolderScreenState();
}

class _ReportFolderScreenState extends State<ReportFolderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  SortOption _currentSort = SortOption.newestFirst;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
      () => setState(() => _searchQuery = _searchController.text),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Group entries by year for the year-divider
    final Map<int, List<ReportEntry>> grouped = {};
    for (final e in widget.entries) {
      grouped.putIfAbsent(e.year, () => []).add(e);
    }
    final sortedYears = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  for (int i = 0; i < sortedYears.length; i++) ...[
                    // Only show year divider after the first group
                    if (i > 0) _buildYearDivider(sortedYears[i].toString()),
                    ...grouped[sortedYears[i]]!.map(_buildRecordCard),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Back arrow + title row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Back 40×40 tap target
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF0A0A0A),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.folderTitle,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.totalFiles} FILES TOTAL',
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.48,
                          color: Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Search bar + Filter pill
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Search pill (expands)
                Expanded(
                  child: Container(
                    height: 44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFD4D4D4)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xFFA3A3A3),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF0A0A0A),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Search report name, symptom, note...',
                              hintStyle: TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA3A3A3),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            cursorColor: const Color(0xFF0A0A0A),
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.cancel_rounded,
                                size: 20,
                                color: Color(0xFFA3A3A3),
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                // Filter pill — 44×44 circle with filter_list icon (from Figma MCP)
                GestureDetector(
                  onTap: () async {
                    HapticFeedback.lightImpact();
                    final result = await showModalBottomSheet<SortOption>(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => SortBottomSheet(initialSort: _currentSort),
                    );
                    if (result != null) {
                      setState(() => _currentSort = result);
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFD4D4D4)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/Figma MCP Assets/CommonAssets/Icons/filter_list.svg',
                        width: 20,
                        height: 20,
                      ),
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

  // ── Year divider ────────────────────────────────────────────────────────────

  Widget _buildYearDivider(String year) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Color(0xFFE5E5E5), thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              year,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.48,
                color: Color(0xFF737373),
              ),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFE5E5E5), thickness: 1)),
        ],
      ),
    );
  }

  // ── Record card ─────────────────────────────────────────────────────────────

  Widget _buildRecordCard(ReportEntry entry) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportDetailScreen(
              labName: entry.labName,
              dateLabel: '${entry.day} ${entry.month}, ${entry.year}',
            ),
          ),
        );
      },
      child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row: date pill + record info + chevron
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date pill — pink/950 bg, 50px wide
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C0011),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${entry.day}',
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      entry.month,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF737373),
                      ),
                    ),
                    Text(
                      '${entry.year}',
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF737373),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Record info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Files info meta line
                    Row(
                      children: [
                        Text(
                          '${entry.fileCount} files',
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF737373),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '•',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF737373),
                            ),
                          ),
                        ),
                        Text(
                          entry.fileTypeLabel,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF737373),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.labName,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A0A0A),
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      entry.doctorRef,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF525252),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Chevron — arrow_forward_ios (Figma: Field Icon V1)
              SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/arrow_forward_ios.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF0A0A0A),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E5E5)),
          const SizedBox(height: 12),

          // Note text
          Text(
            entry.note,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF0A0A0A),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E5E5)),
          const SizedBox(height: 12),

          // File thumbnail pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: entry.files.map(_buildFilePill).toList(),
          ),
        ],
      ),
      ),  // Container
    );   // GestureDetector
  }

  Widget _buildFilePill(ReportFile file) {
    // PDF → picture_as_pdf.svg | Image → filter.svg  (both from Figma MCP)
    final iconPath = file.isPdf
        ? 'assets/Figma MCP Assets/CommonAssets/Icons/picture_as_pdf.svg'
        : 'assets/Figma MCP Assets/CommonAssets/Icons/filter.svg';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          Text(
            file.name,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF404040),
            ),
          ),
        ],
      ),
    );
  }
}
