import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/features/main/screens/family_friend_detail_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/family_friends_screen.dart';
import 'main_scaffold.dart';
import '../widgets/reminder_checkbox.dart';
import 'package:healthpedia_frontend/core/widgets/kinetic_interaction.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';

class SummaryScreen extends StatefulWidget {
  final List<ReminderItem> reminders;
  final Function(String) onToggle;
  final VoidCallback? onNavigateToReminders;

  const SummaryScreen({
    super.key,
    required this.reminders,
    required this.onToggle,
    this.onNavigateToReminders,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    _precacheIcons();
  }

  void _precacheIcons() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png'), context);
      precacheImage(const AssetImage('assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 83.png'), context);
    });
  }

  List<ReminderItem> get _pendingReminders => widget.reminders
      .where((r) => r.status == ReminderStatus.pending || r.isAwaitingRemoval)
      .take(3)
      .toList();

  @override
  Widget build(BuildContext context) {
    final pendingReminders = _pendingReminders;

    return Container(
      color: const Color(0xFF2C0011),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ── TOP HEADER (PINK 950 + GRADIENTS + METRICS) ────────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF2C0011), // Pink 950
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // 1. Background Gradients/Glows
                  Positioned(
                    right: -100,
                    top: -50,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFF96BE).withOpacity(0.3),
                            const Color(0xFFFF96BE).withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -50,
                    top: 0,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF60A5FA).withOpacity(0.2),
                            const Color(0xFF60A5FA).withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 2. Content
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0, 
                      24 + MediaQuery.of(context).padding.top, 
                      0, 
                      30
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Label
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Text(
                            'TODAY’S SUMMARY',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF737373),
                              letterSpacing: 0.48,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Health Score
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '74',
                                      style: TextStyle(
                                        fontFamily: 'Geist',
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                    ),
                                    const Text(
                                      'Health score',
                                      style: TextStyle(
                                        fontFamily: 'Geist',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFD4D4D4),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Week comparison
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0x1ABBF7C8),
                                        borderRadius: BorderRadius.circular(999),
                                        border: Border.all(
                                          color: const Color(0x1ABBF7C8),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 14,
                                            color: Color(0xFF4ADE80),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '+3 from last week',
                                            style: TextStyle(
                                              fontFamily: 'Geist',
                                              fontSize: 12,
                                              color: Color(0xFF4ADE80),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Customise Button
                              KineticInteraction(
                                onTap: () {}, // TODO: Implementation
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 14,
                                        color: Color(0xFFA3A3A3),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Customise',
                                        style: TextStyle(
                                          fontFamily: 'Geist',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFA3A3A3),
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 8),

                        // Sync info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 6,
                                color: Color(0xFF4ADE80),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Synced 4 mins ago',
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 12,
                                  color: Color(0xFFA3A3A3),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Health Stats Scrollable Cards
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              _buildHealthStatCard(
                                '72',
                                'bpm',
                                'Heart Rate',
                                'Normal',
                                Icons.monitor_heart,
                                const Color(0xFFEF4444), // Red/500
                                const Color(0xFF4ADE80),
                              ),
                              const SizedBox(width: 12),
                              _buildHealthStatCard(
                                '6,240',
                                '',
                                'Steps',
                                'Below Goal',
                                Icons.directions_run,
                                const Color(0xFF3B82F6), // Blue/500
                                const Color(0xFFFB923C),
                              ),
                              const SizedBox(width: 12),
                              _buildHealthStatCard(
                                '7 hr 23',
                                'min',
                                'Sleep',
                                'Below Goal',
                                Icons.nights_stay,
                                const Color(0xFF8B5CF6), // Purple/500
                                const Color(0xFFFB923C),
                              ),
                              const SizedBox(width: 12),
                              _buildHealthStatCard(
                                '1,847',
                                'kcal',
                                'Calories',
                                'Below Goal',
                                Icons.whatshot,
                                const Color(0xFFF59E0B), // Amber/500
                                const Color(0xFFFB923C),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── MAIN CONTENT (WHITE RADIUS 40 SHEET) ───────────────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Reminders Header ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'REMINDERS',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF737373),
                            letterSpacing: 0.56,
                          ),
                        ),
                        KineticInteraction(
                          onTap: widget.onNavigateToReminders,
                          child: const Row(
                            children: [
                              Text(
                                'View all',
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF737373),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xFF737373),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reminders List (Interactive)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pendingReminders.isEmpty)
                          _buildEmptyState('No pending reminders')
                        else
                          ...pendingReminders.map((r) => _buildReminderItem(r)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Family & Friends ──
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'FAMILY & FRIENDS',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF737373),
                        letterSpacing: 0.56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        _buildMemberCard(
                          'Sujoy Sahu',
                          'Father • 79 Years',
                          'Active Today',
                          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
                        ),
                        const SizedBox(width: 8),
                        _buildMemberCard(
                          'Arko Sahu',
                          'Brother • 47 Years',
                          '2 days ago',
                          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 83.png',
                        ),
                        const SizedBox(width: 8),
                        _buildAddMemberCard(),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Need Action ──
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'NEED ACTION',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF737373),
                        letterSpacing: 0.56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF5F5F5)),
                      ),
                      child: Column(
                        children: [
                          _buildActionRow(
                            'TSH (Thyroid)',
                            '14 Jan 2025',
                            '6.2',
                            'mIU/L',
                            'Above range',
                          ),
                          const Divider(color: Color(0xFFF5F5F5), height: 1),
                          _buildActionRow(
                            'Fasting Blood Sugar',
                            '14 Jan 2025',
                            '128',
                            'mg/dL',
                            'High',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Upload Prompt
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171717),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Upload your latest report',
                                  style: TextStyle(
                                    fontFamily: 'Geist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Some values are over 60 days old',
                                  style: TextStyle(
                                    fontFamily: 'Geist',
                                    fontSize: 12,
                                    color: Color(0xFF737373),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          KineticInteraction(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE0E9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Upload',
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2C0011),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 120), // Bottom nav clearance
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sub-widgets ---

  Widget _buildHealthStatCard(
    String value,
    String unit,
    String label,
    String status,
    IconData iconData,
    Color iconColor,
    Color statusColor,
  ) {
    return Container(
      width: 125,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  color: Color(0xFFA3A3A3),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              color: Color(0xFFD4D4D4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: statusColor.withOpacity(0.1)),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 10,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderItem(ReminderItem data) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: data.status == ReminderStatus.pending ? 1.0 : 0.6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: () {
            widget.onToggle(data.id);
            HapticFeedback.lightImpact();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Row(
              children: [
                ReminderCheckbox(
                  status: data.status,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: data.status == ReminderStatus.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: data.status == ReminderStatus.completed
                              ? const Color(0xFFA3A3A3)
                              : const Color(0xFF0A0A0A),
                        ),
                      ),
                      Text(
                        data.time,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 12,
                          color: Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(String name, String desc, String status, String img) {
    return KineticInteraction(
      onTap: () {
        context.pushPremium(
          FamilyFriendDetailScreen(
            name: name,
            hpid: 'HPID: #8836477253',
            ageLabel: desc.split('•').last.trim().replaceAll('Years', 'yo'),
            genderLabel: 'Male',
            imagePath: img,
            avatarBackgroundColor: _avatarBackgroundForImage(img),
            allowedSections: kDefaultFamilyFriendSections,
            healthpediaId: '#9039443124',
            abhaId: '70-7463-2446-5247',
          ),
        );
      },
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Column(
          children: [
            Hero(
              tag: 'avatar_$img',
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(img),
                backgroundColor: const Color(0xFFF3F4F6),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 12,
                color: Color(0xFF737373),
                letterSpacing: -0.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0x1A22C55E),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  color: Color(0xFF15803D),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMemberCard() {
    return KineticInteraction(
      onTap: () {
        context.pushPremium(const FamilyFriendsScreen());
      },
      child: Container(
        width: 140,
        height: 180, // Adjusted for consistency
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFCD577F),
            width: 1.5,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Color(0xFFCD577F),
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Add a member',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFCD577F),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _avatarBackgroundForImage(String img) {
    if (img.contains('M 81')) return AppColors.red100;
    if (img.contains('M 83')) return AppColors.orange100;
    return AppColors.neutral200;
  }

  Widget _buildActionRow(
    String title,
    String date,
    String val,
    String unit,
    String status,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  color: Color(0xFF737373),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    val,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      color: Color(0xFF737373),
                    ),
                  ),
                ],
              ),
              Text(
                status,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  color: Color(0xFFC2410C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.grey)),
    );
  }
}
