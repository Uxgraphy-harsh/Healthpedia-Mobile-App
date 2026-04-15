import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Data model for a single symptom log entry
class SymptomLogEntry {
  final String timestamp;
  final String note;
  final List<String> alongside;
  final int severity; // 1-5
  final List<String> triggers;
  final String? activeTrigger; // the highlighted one
  final List<_Attachment> attachments;

  const SymptomLogEntry({
    required this.timestamp,
    required this.note,
    required this.alongside,
    required this.severity,
    required this.triggers,
    this.activeTrigger,
    this.attachments = const [],
  });
}

class _Attachment {
  final String name;
  final String size;
  const _Attachment({required this.name, required this.size});
}

class SymptomDetailScreen extends StatefulWidget {
  final String symptomName;
  final int timesLogged;
  final bool isPassed;

  const SymptomDetailScreen({
    super.key,
    required this.symptomName,
    required this.timesLogged,
    required this.isPassed,
  });

  @override
  State<SymptomDetailScreen> createState() => _SymptomDetailScreenState();
}

class _SymptomDetailScreenState extends State<SymptomDetailScreen> {
  late bool _isPassed;

  // Severity colors from Figma
  static const _sevColors = <int, _SevStyle>{
    1: _SevStyle(bg: Color(0xFFEFF6FF), border: Color(0xFF3B82F6)),
    2: _SevStyle(bg: Color(0xFFF0FDFA), border: Color(0xFF14B8A6)),
    3: _SevStyle(bg: Color(0xFFFFFBEB), border: Color(0xFFFBBF24)),
    4: _SevStyle(bg: Color(0xFFFFF7ED), border: Color(0xFFFB923C)),
    5: _SevStyle(bg: Color(0xFFFFFFFF), border: Color(0xFFE5E5E5)),
  };

  @override
  void initState() {
    super.initState();
    _isPassed = widget.isPassed;
  }

  // Mock data matching Figma
  List<SymptomLogEntry> get _entries => [
        SymptomLogEntry(
          timestamp: 'Today, 3:00 PM',
          note: 'Felt very low after lunch. Could barely focus on work.',
          alongside: ['Dizziness', 'Headache', 'After lunch', 'Ongoing'],
          severity: 4,
          triggers: [
            'After meal', 'On waking up', 'After activity',
            'Stress', 'After medication', 'Random',
          ],
          activeTrigger: 'On waking up',
          attachments: [
            const _Attachment(
                name: 'WhatsApp-2338340124732.p...', size: '1.1 MB'),
          ],
        ),
        SymptomLogEntry(
          timestamp: 'Today, 3:00 PM',
          note: 'Felt very low after lunch. Could barely focus on work.',
          alongside: ['Dizziness', 'Headache', 'After lunch', 'Ongoing'],
          severity: 4,
          triggers: [
            'After meal', 'On waking up', 'After activity',
            'Stress', 'After medication', 'Random',
          ],
          activeTrigger: 'On waking up',
        ),
        SymptomLogEntry(
          timestamp: 'Today, 3:00 PM',
          note: 'Felt very low after lunch. Could barely focus on work.',
          alongside: ['Dizziness', 'Headache', 'After lunch'],
          severity: 4,
          triggers: [
            'After meal', 'On waking up', 'After activity',
            'Stress', 'After medication', 'Random',
          ],
          activeTrigger: 'On waking up',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final entries = _entries;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Header ──
            _buildHeader(context),
            const Divider(height: 1, color: Color(0xFFE5E5E5)),

            // ── Timeline ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: entries.length,
                itemBuilder: (_, i) => _buildTimelineEntry(
                  entries[i],
                  isFirst: i == 0,
                  isLast: i == entries.length - 1,
                ),
              ),
            ),

            // ── Bottom bar: Ask AI + Share ──
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Figma: Passed → blue/10% bg + blue/600 text
    //        Ongoing → orange/25% bg (rgba(254,215,170,0.25)) + orange/700 text
    final outerBorderColor = _isPassed
        ? const Color(0x193B82F6)   // rgba(59,130,246,0.1)
        : const Color(0x40FED7AA);  // rgba(254,215,170,0.25)

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back + Title row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(Icons.arrow_back, size: 24,
                        color: Color(0xFF0A0A0A)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.symptomName,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.timesLogged} TIMES LOGGED',
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
          const SizedBox(height: 12),

          // ── Passed / Ongoing interactive toggle ──
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _isPassed = !_isPassed);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border.all(color: outerBorderColor),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Passed pill
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: _isPassed
                          ? const Color(0x193B82F6)
                          : Colors.transparent,
                      border: Border.all(
                        color: _isPassed
                            ? const Color(0x193B82F6)
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Passed',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: _isPassed
                            ? const Color(0xFF2563EB)   // blue/600
                            : const Color(0xFF737373),
                      ),
                    ),
                  ),
                  // Ongoing pill
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: !_isPassed
                          ? const Color(0x40FED7AA)  // orange/25%
                          : Colors.transparent,
                      border: Border.all(
                        color: !_isPassed
                            ? const Color(0x40FED7AA)
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Ongoing',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: !_isPassed
                            ? const Color(0xFFC2410C)  // orange/700
                            : const Color(0xFF737373),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Timeline entry: dot + line + card ──
  Widget _buildTimelineEntry(
    SymptomLogEntry entry, {
    required bool isFirst,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator column
          SizedBox(
            width: 24,
            child: Column(
              children: [
                // Top line
                Expanded(
                  child: Container(
                    width: 1,
                    color: isFirst
                        ? Colors.transparent
                        : const Color(0xFFD4D4D4),
                  ),
                ),
                // Dot
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0A0A0A),
                  ),
                ),
                // Bottom line
                Expanded(
                  child: Container(
                    width: 1,
                    color: isLast
                        ? Colors.transparent
                        : const Color(0xFFD4D4D4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _buildLogCard(entry),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogCard(SymptomLogEntry entry) {
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
          // Timestamp
          Text(
            entry.timestamp,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 2),
          // Note
          Text(
            entry.note,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0A0A0A),
            ),
          ),
          const SizedBox(height: 12),

          // ALONGSIDE
          _label('ALONGSIDE'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: entry.alongside
                .map((s) => _chipBadge(s))
                .toList(),
          ),
          const SizedBox(height: 12),

          // ATTACHMENTS (if any)
          if (entry.attachments.isNotEmpty) ...[
            _label('ATTACHMENTS'),
            const SizedBox(height: 10),
            ...entry.attachments.map((a) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5E5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file,
                          size: 24, color: Color(0xFF3B82F6)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          a.name,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0A0A0A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                )),
          ],

          // SEVERITY
          _label('SEVERITY'),
          const SizedBox(height: 10),
          _buildSeverityRow(entry.severity),
          const SizedBox(height: 12),

          // POSSIBLE TRIGGER
          _label('POSSIBLE TRIGGER'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: entry.triggers.map((t) {
              final isActive = t == entry.activeTrigger;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF3B82F6)
                      : Colors.transparent,
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFFE5E5E5),
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  t,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF737373),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityRow(int level) {
    return Row(
      children: List.generate(5, (i) {
        final n = i + 1;
        final isActive = n <= level;
        final style = _sevColors[n]!;
        return Container(
          width: 28,
          height: 24,
          margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
          decoration: BoxDecoration(
            color: isActive ? style.bg : Colors.white,
            border: Border.all(
              color: isActive ? style.border : const Color(0xFFE5E5E5),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            '$n',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0A0A0A),
            ),
          ),
        );
      }),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.48,
        color: Color(0xFF737373),
      ),
    );
  }

  Widget _chipBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Geist',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF525252),
        ),
      ),
    );
  }

  // ── Bottom bar: Ask AI (gradient) + Share (outlined) ──
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF5F5F5).withOpacity(0.9),
            const Color(0xFFF5F5F5).withOpacity(0.9),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              // Ask AI button — gradient
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
                          Color(0xFF791138),
                          Color(0xFF7A0C14),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome, size: 16,
                            color: Colors.white),
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
              // Share button — outlined
              Expanded(
                child: GestureDetector(
                  onTap: () => HapticFeedback.mediumImpact(),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF0A0A0A), width: 1),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
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

class _SevStyle {
  final Color bg;
  final Color border;
  const _SevStyle({required this.bg, required this.border});
}
