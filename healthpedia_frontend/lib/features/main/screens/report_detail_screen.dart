import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ── Top-level shadow constant ─────────────────────────────────────────────────

const _kCardShadow = BoxShadow(
  color: Color(0x0A000000),
  blurRadius: 4,
  offset: Offset(0, 2),
);

// ──────────────────────── Data models ────────────────────────────────────────

class _ResultRow {
  final String parameter;
  final String parameterSub;
  final String result;
  final String unit;
  final String normalRange;
  final bool isAbnormal;

  const _ResultRow({
    required this.parameter,
    required this.parameterSub,
    required this.result,
    required this.unit,
    required this.normalRange,
    this.isAbnormal = false,
  });
}

class _Attachment {
  final String name;
  final String size;
  final bool isPdf;

  const _Attachment({
    required this.name,
    required this.size,
    required this.isPdf,
  });
}

class _TimingPill {
  final IconData? icon;
  final String? label;
  final bool isActive;
  const _TimingPill({this.icon, this.label, required this.isActive});
}

// ──────────────────────── Screen ─────────────────────────────────────────────

class ReportDetailScreen extends StatelessWidget {
  final String labName;
  final String dateLabel;

  const ReportDetailScreen({
    super.key,
    this.labName = 'SRL Diagnostics, Baner',
    this.dateLabel = '14 Jan, 2025',
  });

  static const _results = [
    _ResultRow(
      parameter: 'TSH',
      parameterSub: 'Thyroid stimulating hormone',
      result: '6.2',
      unit: 'mIU/L',
      normalRange: '0.4 – 4.0',
      isAbnormal: true,
    ),
    _ResultRow(
      parameter: 'Free T3',
      parameterSub: 'Triiodothyronine',
      result: '3.1',
      unit: 'pg/mL',
      normalRange: '2.3 – 4.2',
    ),
    _ResultRow(
      parameter: 'Free T4',
      parameterSub: 'Thyroxine',
      result: '0.9',
      unit: 'ng/dL',
      normalRange: '0.8 – 1.8',
    ),
    _ResultRow(
      parameter: 'Anti-TPO',
      parameterSub: 'Thyroid peroxidase Ab',
      result: '42',
      unit: 'IU/mL',
      normalRange: '0 – 34',
      isAbnormal: true,
    ),
  ];

  static const _attachments = [
    _Attachment(name: 'Thyroid_Jan25.pdf', size: '24.4 MB', isPdf: true),
    _Attachment(name: 'Report_p1.jpg', size: '1.7 MB', isPdf: false),
    _Attachment(name: 'Report_p2.jpg', size: '1.7 MB', isPdf: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorImpression(),
                    const SizedBox(height: 24),
                    _buildSection('REPORT DETAILS', _buildReportDetails()),
                    const SizedBox(height: 24),
                    _buildSection('VITALS AT TIME OF TEST', _buildVitals()),
                    const SizedBox(height: 24),
                    _buildSection('RESULTS', _buildResultsTable()),
                    const SizedBox(height: 24),
                    _buildSection('PRESCRIBED MEDICINES', _buildPrescriptions()),
                    const SizedBox(height: 24),
                    _buildSection('ATTACHMENTS', _buildAttachments()),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Icon(Icons.arrow_back, size: 24, color: Color(0xFF0A0A0A)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labName,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateLabel.toUpperCase(),
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
            ),
          ],
        ),
      ),
    );
  }

  // ── Doctor's impression ────────────────────────────────────────────────────

  Widget _buildDoctorImpression() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DOCTOR'S IMPRESSION",
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"TSH elevated. Anti-TPO borderline positive. Patient on Eltroxin '
            '50mcg — consider dose titration to 75mcg. Retest TSH and '
            'Anti-TPO after 6 weeks. Continue current diet and sleep schedule."',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '– Dr. Meena Sharma, Endocrinologist',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF525252),
            ),
          ),
        ],
      ),
    );
  }

  // ── Generic section wrapper ────────────────────────────────────────────────

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.56,
            color: Color(0xFF737373),
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  // ── Report Details table ───────────────────────────────────────────────────

  Widget _buildReportDetails() {
    final rows = [
      ['Hospital / Lab', 'SRL Diagnostics, Baner'],
      ['Referring doctor', 'Dr. Meena Sharma'],
      ['Report date', '14 Jan 2025'],
      ['Sample collected', '14 Jan  •  7:30 AM'],
      ['Lab reference', 'SRL/PUN/25/004821'],
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF5F5F5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: rows.asMap().entries.map((e) {
          final bool isLast = e.key == rows.length - 1;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : const Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    e.value[0],
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF737373),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    e.value[1],
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Vitals ─────────────────────────────────────────────────────────────────

  Widget _buildVitals() {
    return Row(
      children: [
        Expanded(child: _buildVitalCard(
          icon: Icons.monitor_weight_outlined,
          value: '58', unit: 'kg', label: 'Weight',
        )),
        const SizedBox(width: 8),
        Expanded(child: _buildVitalCard(
          icon: Icons.commit, value: '20.3', label: 'BMI',
        )),
        const SizedBox(width: 8),
        Expanded(child: _buildVitalCard(
          icon: Icons.bloodtype_outlined, value: '118/76', label: 'BP',
        )),
      ],
    );
  }

  Widget _buildVitalCard({
    required IconData icon,
    required String value,
    String? unit,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: const Color(0xFF0A0A0A)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A0A0A),
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA3A3A3),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
        ],
      ),
    );
  }

  // ── Results table ──────────────────────────────────────────────────────────

  Widget _buildResultsTable() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF5F5F5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _buildTableCell('PARAMETER', isHeader: true),
                _buildTableCell('RESULT', isHeader: true),
                _buildTableCell('NORMAL RANGE', isHeader: true),
              ],
            ),
          ),
          ..._results.map((r) => IntrinsicHeight(
            child: Row(
              children: [
                _buildTableCell(r.parameter, sub: r.parameterSub,
                    isAbnormal: r.isAbnormal, isLast: _results.last == r),
                _buildTableCell(r.result, sub: r.unit,
                    isAbnormal: r.isAbnormal, isLast: _results.last == r),
                _buildTableCell(r.normalRange,
                    isAbnormal: r.isAbnormal, isLast: _results.last == r),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTableCell(
    String text, {
    String? sub,
    bool isHeader = false,
    bool isAbnormal = false,
    bool isLast = false,
  }) {
    Color bg = Colors.white;
    if (isAbnormal) bg = const Color(0xFFFEFCE8);
    if (isHeader) bg = Colors.white;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg,
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
        ),
        child: isHeader
            ? SizedBox(
                height: 42,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(text,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF737373),
                      )),
                ),
              )
            : SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1),
                    if (sub != null)
                      Text(sub,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF737373),
                          )),
                  ],
                ),
              ),
      ),
    );
  }

  // ── Prescribed Medicines ───────────────────────────────────────────────────

  Widget _buildPrescriptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (i) => Padding(
          padding: EdgeInsets.only(right: i < 2 ? 12 : 0),
          child: const _PrescriptionCard(),
        )),
      ),
    );
  }

  // ── Attachments ────────────────────────────────────────────────────────────

  Widget _buildAttachments() {
    return Column(
      children: _attachments.map((a) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [_kCardShadow],
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                a.isPdf
                    ? 'assets/Figma MCP Assets/CommonAssets/Icons/picture_as_pdf.svg'
                    : 'assets/Figma MCP Assets/CommonAssets/Icons/filter.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.name,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1),
                    Text(a.size,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF737373),
                        )),
                  ],
                ),
              ),
              const Icon(Icons.arrow_outward, size: 24, color: Color(0xFF0A0A0A)),
            ],
          ),
        ),
      )).toList(),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────────

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.mediumImpact(),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B113D),
                      Color(0xFF5E1D5E),
                      Color(0xFF79113A),
                      Color(0xFF7A0C14),
                    ],
                    stops: [0.0, 0.5, 0.75, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, size: 18, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Ask AI',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Center(
                  child: Text('Share',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────── Prescription card (stateful) ───────────────────────

class _PrescriptionCard extends StatefulWidget {
  const _PrescriptionCard();

  @override
  State<_PrescriptionCard> createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<_PrescriptionCard> {
  static const _images = [
    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
  ];

  static const _timings = [
    _TimingPill(icon: Icons.wb_sunny_rounded, label: null, isActive: true),
    _TimingPill(icon: null, label: 'L', isActive: false),
    _TimingPill(icon: null, label: 'D', isActive: false),
    _TimingPill(icon: Icons.nights_stay, label: null, isActive: false),
  ];

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _openFullscreen(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _FullscreenImageViewer(
          images: _images,
          initialIndex: _currentIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Main image (PageView + 1x badge) ──────────────────────────────
          Stack(
            children: [
              GestureDetector(
                onTap: () => _openFullscreen(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _images.length,
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      itemBuilder: (_, i) => Image.asset(
                        _images[i],
                        fit: BoxFit.contain, // contain = no crop
                      ),
                    ),
                  ),
                ),
              ),
              // 1x badge
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: const [_kCardShadow],
                  ),
                  child: const Text(
                    '1x',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── Thumbnail slider indicators ────────────────────────────────────
          Row(
            children: List.generate(_images.length, (i) {
              final isSelected = _currentIndex == i;
              return GestureDetector(
                onTap: () => _goToPage(i),
                child: Container(
                  margin: EdgeInsets.only(right: i < _images.length - 1 ? 4 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFFE5E5E5),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Image.asset(
                        _images[i],
                        fit: BoxFit.contain, // contain = no crop in thumb too
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          // ── Medicine name + timing ─────────────────────────────────────────
          const Text(
            'Thyrox 50 Tablet',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
            ),
          ),
          const Text(
            '~ Before food',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 8),

          // ── Dosage timing pills ────────────────────────────────────────────
          Row(
            children: _timings.map((t) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: t.isActive ? const Color(0xFF3B82F6) : Colors.transparent,
                  border: t.isActive
                      ? null
                      : Border.all(color: const Color(0xFFA3A3A3)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: t.icon != null
                      ? Icon(t.icon,
                          size: 14,
                          color:
                              t.isActive ? Colors.white : const Color(0xFFA3A3A3))
                      : Text(
                          t.label!,
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: t.isActive
                                ? Colors.white
                                : const Color(0xFFA3A3A3),
                          ),
                        ),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────── Full-screen image viewer ────────────────────────────

class _FullscreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullscreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<_FullscreenImageViewer> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final botPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Swipeable + zoomable images ────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, i) => InteractiveViewer(
              minScale: 1.0,
              maxScale: 5.0,
              child: SizedBox.expand(
                child: Image.asset(
                  widget.images[i],
                  fit: BoxFit.contain, // fills the full-screen bounds
                ),
              ),
            ),
          ),

          // ── Close button ───────────────────────────────────────────────────
          Positioned(
            top: topPad + 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),

          // ── Image counter (e.g. "2 / 3") ──────────────────────────────────
          Positioned(
            top: topPad + 22,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontFamily: 'Geist',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ── Dot indicator ──────────────────────────────────────────────────
          Positioned(
            bottom: botPad + 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                final isActive = _currentIndex == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
