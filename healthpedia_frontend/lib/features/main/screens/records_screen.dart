import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/add_note_bottom_sheet.dart';
import 'report_folder_screen.dart';
import 'prescription_detail_screen.dart';
import '../widgets/add_prescription_bottom_sheet.dart';
import '../widgets/add_symptom_bottom_sheet.dart';
import 'symptom_detail_screen.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Report card data — images from Figma MCP Assets/CommonAssets/Images
  final List<_ReportCard> _reports = [
    _ReportCard(
      title: 'Thyroid',
      updated: '14 Jan 2025',
      fileCount: 6,
      imagePath: 'assets/Figma MCP Assets/CommonAssets/Images/Report Image.png',
    ),
    _ReportCard(
      title: 'Diabetes',
      updated: '14 Jan 2025',
      fileCount: 4,
      imagePath:
          'assets/Figma MCP Assets/CommonAssets/Images/Report Image-1.png',
    ),
    _ReportCard(
      title: 'Cardiovascular',
      updated: '2 Nov 2024',
      fileCount: 3,
      imagePath:
          'assets/Figma MCP Assets/CommonAssets/Images/Report Image-2.png',
    ),
    _ReportCard(
      title: 'General',
      updated: '2 Nov 2024',
      fileCount: 8,
      imagePath:
          'assets/Figma MCP Assets/CommonAssets/Images/Report Image-3.png',
    ),
  ];

  // Prescription mock data
  final List<_PrescriptionEntry> _prescriptions = [
    const _PrescriptionEntry(
      date: '28 Feb 2026',
      doctorName: 'Dr. Sharma',
      speciality: 'Endocrinology',
      itemCount: 3,
    ),
    const _PrescriptionEntry(
      date: '28 Feb 2026',
      doctorName: 'Dr. Sharma',
      speciality: 'Endocrinology',
      itemCount: 3,
    ),
  ];

  final List<_NoteEntry> _notes = const [
    _NoteEntry(
      timestamp: '22 Mar 2025, 3:00 PM',
      title: 'Dr. Sharma visit — key points',
      body:
          'TSH still elevated. Dose might be increased next visit. Need to retest in 6 weeks. She mentioned stress can worsen thyroid levels significantly.',
    ),
    _NoteEntry(
      timestamp: '22 Mar 2025, 3:00 PM',
      title: 'Dr. Sharma visit — key points',
      body:
          'TSH still elevated. Dose might be increased next visit. Need to retest in 6 weeks. She mentioned stress can worsen thyroid levels significantly.',
    ),
  ];

  static const _tabs = [
    '📂  Reports',
    '🤒  Symptoms',
    '💊  Prescriptions',
    '✏️  Notes',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildReportsTab(),
                      _buildSymptomsTab(),
                      _buildPrescriptionsTab(),
                      _buildNotesTab(),
                    ],
                  ),
                ),
                // Bottom nav padding
                const SizedBox(height: 85),
              ],
            ),

            // FAB — changes label based on active tab
            Positioned(
              right: 16,
              bottom: 126,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  if (_tabController.index == 1) {
                    showAddSymptomSheet(
                      context,
                      existingSymptoms: _symptoms.map((s) => s.name).toList(),
                    );
                  } else if (_tabController.index == 2) {
                    showAddPrescriptionSheet(context);
                  } else if (_tabController.index == 3) {
                    showAddNoteBottomSheet(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2), // rose/50
                    border: Border.all(
                      color: const Color(0xFFFFC3D7),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _tabController,
                        builder: (_, __) {
                          final idx = _tabController.index;
                          final isSymptoms = idx == 1;
                          final isPrescriptions = idx == 2;
                          final isNotes = idx == 3;
                          final icon = isSymptoms
                              ? const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Color(0xFFCD577F),
                                )
                              : isPrescriptions
                              ? const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Color(0xFFCD577F),
                                )
                              : isNotes
                              ? const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Color(0xFFCD577F),
                                )
                              : SvgPicture.asset(
                                  'assets/Figma MCP Assets/CommonAssets/Icons/upload.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFFCD577F),
                                    BlendMode.srcIn,
                                  ),
                                );
                          final label = isSymptoms
                              ? 'Add New Symptom'
                              : isPrescriptions
                              ? 'Add New Prescription'
                              : isNotes
                              ? 'Add New Note'
                              : 'Upload a new report';
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              icon,
                              const SizedBox(width: 12),
                              Text(
                                label,
                                style: const TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFCD577F),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header: title + search bar + tab bar
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Records" title row — 40px height
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Records',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Search bar — pill-shaped, 44px, no nested TextField decoration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  // Search icon
                  const Icon(Icons.search, size: 20, color: Color(0xFFA3A3A3)),
                  const SizedBox(width: 4),
                  // Transparent, borderless input
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
                  // Clear (X) button — only when text is present
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

          const SizedBox(height: 8),

          // Tab Bar
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            labelPadding: const EdgeInsets.only(right: 24),
            indicatorColor: const Color(0xFF3B82F6), // Blue 500
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: const Color(0xFF3B82F6),
            unselectedLabelColor: const Color(0xFF737373), // neutral/500
            labelStyle: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            dividerColor: Colors.transparent,
            tabs: _tabs.map((t) => Tab(text: t, height: 44)).toList(),
          ),
        ],
      ),
    );
  }

  /// 2-column wrap grid for report cards
  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _reports.map((r) => _buildReportCard(r)).toList(),
      ),
    );
  }

  // ── Symptoms tab ────────────────────────────────────────────────────────────

  static const _symptoms = [
    _SymptomEntry(
      name: 'Fatigue',
      lastLogged: 'Today, 3:00 PM',
      timesLogged: 3,
      status: _SymptomStatus.passed,
    ),
    _SymptomEntry(
      name: 'Throat tightness',
      lastLogged: 'Today, 8:00 PM',
      timesLogged: 7,
      status: _SymptomStatus.passed,
    ),
    _SymptomEntry(
      name: 'Dizziness',
      lastLogged: '21 Mar, 6:12 PM',
      timesLogged: 2,
      status: _SymptomStatus.passed,
    ),
    _SymptomEntry(
      name: 'Headache',
      lastLogged: '20 Mar, 9:42 PM',
      timesLogged: 8,
      status: _SymptomStatus.ongoing,
    ),
  ];

  Widget _buildSymptomsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _symptoms.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => _buildSymptomCard(_symptoms[i]),
    );
  }

  Widget _buildSymptomCard(_SymptomEntry s) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SymptomDetailScreen(
              symptomName: s.name,
              timesLogged: s.timesLogged,
              isPassed: s.status == _SymptomStatus.passed,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Left: texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Last logged • Today, 3:00 PM" — 12px, Neutral 500
                  Row(
                    children: [
                      const Text(
                        'Last logged',
                        style: TextStyle(
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
                        s.lastLogged,
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
                  // Name + status badge — Geist Medium 16px, Neutral 950
                  Row(
                    children: [
                      Text(
                        s.name,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(s.status),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // "X times logged" — 14px, Neutral 600
                  Text(
                    '${s.timesLogged} times logged',
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
            // Right: chevron — arrow_forward_ios Material icon
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF0A0A0A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(_SymptomStatus status) {
    // Passed: rgba(59,130,246,0.1) bg + border | Blue/600 text
    // Ongoing: rgba(254,215,170,0.25) bg + border | Orange/700 text
    final isPassed = status == _SymptomStatus.passed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isPassed
            ? const Color(0x193B82F6) // rgba(59,130,246,0.1)
            : const Color(0x40FED7AA), // rgba(254,215,170,0.25)
        border: Border.all(
          color: isPassed ? const Color(0x193B82F6) : const Color(0x40FED7AA),
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isPassed ? 'Passed' : 'Ongoing',
        style: TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: isPassed
              ? const Color(0xFF2563EB) // Blue/600
              : const Color(0xFFC2410C), // Orange/700
        ),
      ),
    );
  }

  List<ReportEntry> _getEntriesFor(String title) {
    const note =
        'TSH came back elevated at 6.2 mIU/L, above the normal range. Free T3 and T4 are within limits. '
        'Anti-TPO antibodies slightly raised. Doctor has recommended a retest in 6 weeks '
        'and a possible Eltroxin dosage review.';
    final files = [
      ReportFile(name: '${title}_Jan25.pdf', isPdf: true),
      const ReportFile(name: 'Report_p1.jpg', isPdf: false),
      const ReportFile(name: 'Report_p2.jpg', isPdf: false),
    ];
    final entry2025 = ReportEntry(
      day: 14,
      month: 'JAN',
      year: 2025,
      fileCount: 3,
      fileTypeLabel: 'PDF + 2 photos',
      labName: 'SRL Diagnostics, Baner',
      doctorRef: 'Ref. Dr. Meena Sharma',
      note: note,
      files: files,
    );
    final entry2024 = ReportEntry(
      day: 14,
      month: 'JAN',
      year: 2024,
      fileCount: 3,
      fileTypeLabel: 'PDF + 2 photos',
      labName: 'SRL Diagnostics, Baner',
      doctorRef: 'Ref. Dr. Meena Sharma',
      note: note,
      files: files,
    );
    return [entry2025, entry2025, entry2024, entry2024];
  }

  Widget _buildReportCard(_ReportCard card) {
    final cardWidth = (MediaQuery.of(context).size.width - 16 * 2 - 8) / 2;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportFolderScreen(
              folderTitle: card.title,
              totalFiles: card.fileCount,
              entries: _getEntriesFor(card.title),
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // neutral/100
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          // Inner white info card
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report image — 40×40
              Image.asset(
                card.imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                card.title,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0A0A0A),
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 2),
              // Updated metadata
              Row(
                children: [
                  const Text(
                    'Updated',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF737373),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '•',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      color: Color(0xFF737373),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    card.updated,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF737373),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // File count pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${card.fileCount} files',
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF525252), // neutral/600
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Prescriptions tab ────────────────────────────────────────────
  Widget _buildPrescriptionsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _prescriptions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => _buildPrescriptionCard(_prescriptions[i]),
    );
  }

  Widget _buildPrescriptionCard(_PrescriptionEntry p) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PrescriptionDetailScreen(
              labName: 'SRL Diagnostics, Baner',
              dateLabel: '14 Jan, 2025',
              doctorName: p.doctorName,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Text(
                    p.date,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF737373),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Doctor + Speciality
                  Text(
                    '${p.doctorName} — ${p.speciality}',
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  // Item count
                  Text(
                    '${p.itemCount} items',
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
            const Icon(Icons.chevron_right, size: 24, color: Color(0xFF737373)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _notes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _buildNoteCard(_notes[i]),
    );
  }

  Widget _buildNoteCard(_NoteEntry note) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.timestamp,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF737373),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              note.title,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              note.body,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF525252),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCard {
  final String title;
  final String updated;
  final int fileCount;
  final String imagePath;

  const _ReportCard({
    required this.title,
    required this.updated,
    required this.fileCount,
    required this.imagePath,
  });
}

enum _SymptomStatus { passed, ongoing }

class _SymptomEntry {
  final String name;
  final String lastLogged;
  final int timesLogged;
  final _SymptomStatus status;

  const _SymptomEntry({
    required this.name,
    required this.lastLogged,
    required this.timesLogged,
    required this.status,
  });
}

class _PrescriptionEntry {
  final String date;
  final String doctorName;
  final String speciality;
  final int itemCount;

  const _PrescriptionEntry({
    required this.date,
    required this.doctorName,
    required this.speciality,
    required this.itemCount,
  });
}

class _NoteEntry {
  final String timestamp;
  final String title;
  final String body;

  const _NoteEntry({
    required this.timestamp,
    required this.title,
    required this.body,
  });
}
