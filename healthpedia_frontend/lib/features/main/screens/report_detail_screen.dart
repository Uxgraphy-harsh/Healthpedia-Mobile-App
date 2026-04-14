import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ──────────────────────── Data models ────────────────────────────────────────

class _ResultRow {
  final String parameter;
  final String parameterSub;
  final String result;
  final String unit;
  final String normalRange;
  final bool isAbnormal; // yellow/50 background

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

// ──────────────────────── Screen ─────────────────────────────────────────────

class ReportDetailScreen extends StatelessWidget {
  final String labName;
  final String dateLabel; // e.g. "14 Jan, 2025"

  const ReportDetailScreen({
    super.key,
    this.labName = 'SRL Diagnostics, Baner',
    this.dateLabel = '14 Jan, 2025',
  });

  // ── Static data (matches Figma exactly) ────────────────────────────────────

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

  // ── Dosage dots pattern (empty, filled, empty, filled) ─────────────────────
  static const _dosageFilled = [false, true, false, true];

  // ──────────────────────────────────────────────────────────────────────────

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
                    _buildSection(
                        'VITALS AT TIME OF TEST', _buildVitals()),
                    const SizedBox(height: 24),
                    _buildSection('RESULTS', _buildResultsTable()),
                    const SizedBox(height: 24),
                    _buildSection('PRESCRIPTIONS', _buildPrescriptions()),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Back — arrow_back Material icon
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
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color(0xFF0A0A0A),
                      ),
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
                        // Lab title — SemiBold 20px, Neutral 950
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
                        // Date — Medium 12px, Neutral 500, UPPERCASE tracked
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
        ],
      ),
    );
  }

  // ── Doctor's impression card ───────────────────────────────────────────────

  Widget _buildDoctorImpression() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          const Text(
            "DOCTOR'S IMPRESSION",
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 8),
          // Quote text — Medium 16px, Neutral 950
          const Text(
            '"TSH elevated. Anti-TPO borderline positive. Patient on Eltroxin 50mcg — consider dose titration to 75mcg. Retest TSH and Anti-TPO after 6 weeks. Continue current diet and sleep schedule."',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          // Attribution — Regular 14px, Neutral 600
          const Text(
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
        // Section label — SemiBold 14px, Neutral 500, UPPERCASE, 0.56 tracked
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : const Border(
                      bottom: BorderSide(color: Color(0xFFF5F5F5))),
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

  // ── Vitals cards ───────────────────────────────────────────────────────────

  static const _cardShadow = BoxShadow(
    color: Color(0x05000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  Widget _buildVitals() {
    return Row(
      children: [
        // Weight — monitor_weight Material icon
        Expanded(child: _buildVitalCard(
          icon: Icons.monitor_weight_outlined,
          value: '58',
          unit: 'kg',
          label: 'Weight',
        )),
        const SizedBox(width: 8),
        // BMI — commit icon
        Expanded(child: _buildVitalCard(
          icon: Icons.commit,
          value: '20.3',
          label: 'BMI',
        )),
        const SizedBox(width: 8),
        // BP — bloodtype icon
        Expanded(child: _buildVitalCard(
          icon: Icons.bloodtype_outlined,
          value: '118/76',
          label: 'BP',
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
        boxShadow: const [_cardShadow],
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
          // Header row
          IntrinsicHeight(
            child: Row(
              children: [
                _buildTableCell('PARAMETER', isHeader: true),
                _buildTableCell('RESULT', isHeader: true),
                _buildTableCell('NORMAL RANGE', isHeader: true),
              ],
            ),
          ),
          // Data rows
          ..._results.map((r) => IntrinsicHeight(
                child: Row(
                  children: [
                    _buildTableCell(
                      r.parameter,
                      sub: r.parameterSub,
                      isAbnormal: r.isAbnormal,
                      isLast: _results.last == r,
                    ),
                    _buildTableCell(
                      r.result,
                      sub: r.unit,
                      isAbnormal: r.isAbnormal,
                      isLast: _results.last == r,
                    ),
                    _buildTableCell(
                      r.normalRange,
                      isAbnormal: r.isAbnormal,
                      isLast: _results.last == r,
                    ),
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
    if (isAbnormal) bg = const Color(0xFFFEFCE8); // yellow/50
    if (isHeader) bg = Colors.white;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg,
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(color: Color(0xFFF5F5F5)),
                ),
        ),
        child: isHeader
            ? SizedBox(
                height: 42,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF737373),
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A0A0A),
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    if (sub != null)
                      Text(
                        sub,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF737373),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  // ── Prescriptions ──────────────────────────────────────────────────────────

  Widget _buildPrescriptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (i) => Padding(
          padding: EdgeInsets.only(right: i < 2 ? 12 : 0),
          child: _buildPrescriptionCard(),
        )),
      ),
    );
  }

  Widget _buildPrescriptionCard() {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prescription image container — aspect 1:1 clipped
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Name — Medium 16px
          const Text(
            'Thyrox 50 Tablet',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
            ),
          ),
          // Timing — Regular 14px, Neutral 500
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
          // Dosage dots — (empty, filled) × 2
          Row(
            children: _dosageFilled.map((filled) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? const Color(0xFF3B82F6) : Colors.transparent,
                  border: filled
                      ? null
                      : Border.all(color: const Color(0xFFA3A3A3)),
                ),
              ),
            )).toList(),
          ),
        ],
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
            boxShadow: const [_cardShadow],
          ),
          child: Row(
            children: [
              // Icon: picture_as_pdf for PDF, image for image files (Material)
              Icon(
                a.isPdf ? Icons.picture_as_pdf : Icons.image_outlined,
                size: 24,
                color: const Color(0xFF0A0A0A),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.name,
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
                      a.size,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF737373),
                      ),
                    ),
                  ],
                ),
              ),
              // arrow_outward = open_in_new Material icon
              const Icon(
                Icons.open_in_new,
                size: 24,
                color: Color(0xFF0A0A0A),
              ),
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
          // Ask AI — gradient pill
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
                    Text(
                      'Ask AI',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Share — outlined black pill
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
                  child: Text(
                    'Share',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
