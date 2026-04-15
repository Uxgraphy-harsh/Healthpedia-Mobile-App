import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kPrescriptionCardShadow = BoxShadow(
  color: Color(0x0A000000),
  blurRadius: 4,
  offset: Offset(0, 2),
);

class PrescriptionDetailScreen extends StatelessWidget {
  const PrescriptionDetailScreen({
    super.key,
    this.labName = 'SRL Diagnostics, Baner',
    this.dateLabel = '14 Jan, 2025',
    this.doctorName = 'Dr. Meena Sharma',
  });

  final String labName;
  final String dateLabel;
  final String doctorName;

  static const _linkedFiles = [
    _LinkedFile(name: 'Thyroid_Jan25.pdf', size: '24.4 MB', isPdf: true),
  ];

  static const _linkedRecords = [
    _LinkedRecord(
      title: 'SRL Diagnostics, Baner',
      subtitle: 'Ref. Dr. Meena Sharma',
      meta: '3 files • PDF + 2 photos',
    ),
    _LinkedRecord(
      title: 'SRL Diagnostics, Baner',
      subtitle: 'Ref. Dr. Meena Sharma',
      meta: '3 files • PDF + 2 photos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _PrescriptionDetailHeader(labName: labName, dateLabel: dateLabel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('PRESCRIBED MEDICINES'),
                    const SizedBox(height: 12),
                    const _MedicineCarousel(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('PRESCRIPTION DETAILS'),
                    const SizedBox(height: 12),
                    _buildDetailsTable(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('LINKED FILES'),
                    const SizedBox(height: 12),
                    ..._linkedFiles.map(
                      (file) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _LinkedFileCard(file: file),
                      ),
                    ),
                    ..._linkedRecords.map(
                      (record) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _LinkedRecordCard(record: record),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const _PrescriptionBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.56,
        color: Color(0xFF737373),
      ),
    );
  }

  Widget _buildDetailsTable() {
    const rows = [
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
        children: rows.asMap().entries.map((entry) {
          final isLast = entry.key == rows.length - 1;
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
                    entry.value[0],
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF737373),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    entry.value[1],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PrescriptionDetailHeader extends StatelessWidget {
  const _PrescriptionDetailHeader({
    required this.labName,
    required this.dateLabel,
  });

  final String labName;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
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
}

class _MedicineCarousel extends StatelessWidget {
  const _MedicineCarousel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 2 ? 12 : 0),
            child: const _PrescriptionMedicineCard(),
          ),
        ),
      ),
    );
  }
}

class _PrescriptionMedicineCard extends StatefulWidget {
  const _PrescriptionMedicineCard();

  @override
  State<_PrescriptionMedicineCard> createState() =>
      _PrescriptionMedicineCardState();
}

class _PrescriptionMedicineCardState extends State<_PrescriptionMedicineCard> {
  static const _images = [
    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
    'assets/Figma MCP Assets/CommonAssets/Images/Prescription Image 1.png',
  ];

  static const _timings = [
    _TimingPill(icon: Icons.wb_sunny_rounded, label: null, isActive: true),
    _TimingPill(icon: null, label: 'L', isActive: false),
    _TimingPill(icon: null, label: 'D', isActive: false),
    _TimingPill(icon: Icons.nights_stay_rounded, label: null, isActive: false),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_kPrescriptionCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (_, index) =>
                        Image.asset(_images[index], fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: const [_kPrescriptionCardShadow],
                  ),
                  child: const Text(
                    '1x',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF525252),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(_images.length, (index) {
              final isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: () => _goToPage(index),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < _images.length - 1 ? 4 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0A0A0A)
                          : const Color(0xFFE5E5E5),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Image.asset(_images[index], fit: BoxFit.contain),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
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
          Row(
            children: _timings
                .map(
                  (timing) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: timing.isActive
                            ? const Color(0xFF3B82F6)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: timing.icon != null
                            ? Icon(
                                timing.icon,
                                size: 16,
                                color: timing.isActive
                                    ? Colors.white
                                    : const Color(0xFFA3A3A3),
                              )
                            : Text(
                                timing.label!,
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: timing.isActive
                                      ? Colors.white
                                      : const Color(0xFFA3A3A3),
                                ),
                              ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LinkedFileCard extends StatelessWidget {
  const _LinkedFileCard({required this.file});

  final _LinkedFile file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_kPrescriptionCardShadow],
      ),
      child: Row(
        children: [
          Icon(
            file.isPdf ? Icons.picture_as_pdf_rounded : Icons.insert_drive_file,
            size: 24,
            color: file.isPdf
                ? const Color(0xFFEF4444)
                : const Color(0xFF0083D7),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                Text(
                  file.size,
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
          const Icon(
            Icons.arrow_outward_rounded,
            size: 24,
            color: Color(0xFF737373),
          ),
        ],
      ),
    );
  }
}

class _LinkedRecordCard extends StatelessWidget {
  const _LinkedRecordCard({required this.record});

  final _LinkedRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [_kPrescriptionCardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2C0011),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Text(
                  '14',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'JAN',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF737373),
                  ),
                ),
                Text(
                  '2025',
                  style: TextStyle(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.meta,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF737373),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  record.title,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  record.subtitle,
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
          const Icon(
            Icons.chevron_right_rounded,
            size: 24,
            color: Color(0xFF737373),
          ),
        ],
      ),
    );
  }
}

class _PrescriptionBottomBar extends StatelessWidget {
  const _PrescriptionBottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00F5F5F5), Color(0xFFEFD6E2)],
        ),
      ),
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
          Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.transparent,
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

class _TimingPill {
  const _TimingPill({this.icon, this.label, required this.isActive});

  final IconData? icon;
  final String? label;
  final bool isActive;
}

class _LinkedFile {
  const _LinkedFile({
    required this.name,
    required this.size,
    required this.isPdf,
  });

  final String name;
  final String size;
  final bool isPdf;
}

class _LinkedRecord {
  const _LinkedRecord({
    required this.title,
    required this.subtitle,
    required this.meta,
  });

  final String title;
  final String subtitle;
  final String meta;
}
