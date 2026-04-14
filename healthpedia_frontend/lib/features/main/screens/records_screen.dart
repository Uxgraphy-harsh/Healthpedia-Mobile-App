import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'report_folder_screen.dart';

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
      imagePath:
          'assets/Figma MCP Assets/CommonAssets/Images/Report Image.png',
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
                      _buildEmptyTab('🤒', 'No symptoms recorded'),
                      _buildEmptyTab('💊', 'No prescriptions yet'),
                      _buildEmptyTab('✏️', 'No notes added yet'),
                    ],
                  ),
                ),
                // Bottom nav padding
                const SizedBox(height: 85),
              ],
            ),

            // Floating "Upload a new report" FAB — consistent bottom:126 with Reminders CTA
            Positioned(
              right: 16,
              bottom: 126,
              child: GestureDetector(
                onTap: () => HapticFeedback.mediumImpact(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2), // rose/50
                    border: Border.all(color: const Color(0xFFFFC3D7), width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/Figma MCP Assets/CommonAssets/Icons/upload.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFCD577F), // pink/500
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Upload a new report',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFCD577F), // pink/500
                        ),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
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
                  const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFFA3A3A3),
                  ),
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

  Widget _buildEmptyTab(String emoji, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 15,
              color: Color(0xFFA3A3A3),
            ),
          ),
        ],
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
      day: 14, month: 'JAN', year: 2025,
      fileCount: 3, fileTypeLabel: 'PDF + 2 photos',
      labName: 'SRL Diagnostics, Baner',
      doctorRef: 'Ref. Dr. Meena Sharma',
      note: note, files: files,
    );
    final entry2024 = ReportEntry(
      day: 14, month: 'JAN', year: 2024,
      fileCount: 3, fileTypeLabel: 'PDF + 2 photos',
      labName: 'SRL Diagnostics, Baner',
      doctorRef: 'Ref. Dr. Meena Sharma',
      note: note, files: files,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
