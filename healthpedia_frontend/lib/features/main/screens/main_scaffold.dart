import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:healthpedia_frontend/features/main/screens/summary_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/reminders_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/ask_ai_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/records_screen.dart';
import 'package:healthpedia_frontend/features/main/screens/profile_screen.dart';
import 'package:healthpedia_frontend/core/widgets/kinetic_interaction.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';

enum ReminderStatus { pending, completed, missed }

class ReminderItem {
  final String id;
  final String title;
  final String time;
  final String category;
  final Color categoryColor;
  final Color categoryBg;
  ReminderStatus status;

  ReminderItem({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.categoryColor,
    required this.categoryBg,
    this.status = ReminderStatus.pending,
  });
}

/// The root scaffold containing the sticky bottom navigation bar.
/// This acts as the shell wrapping the Home Page (Summary), Reminders, Ask AI, Records, and Profile.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _configureSystemUI();
  }

  void _configureSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  final List<ReminderItem> _reminders = [
    ReminderItem(
      id: '1',
      title: 'Dr. Meena Sharma - Apollo Clinic Pune',
      time: 'Tomorrow • 11:30 AM',
      category: 'Appointment',
      categoryColor: const Color(0xFF2563EB),
      categoryBg: const Color(0x1A3B82F6),
    ),
    ReminderItem(
      id: '2',
      title: 'Eltroxin 50mcg',
      time: 'Everyday',
      category: 'Medicine',
      categoryColor: const Color(0xFFC2410C),
      categoryBg: const Color(0x40FED7AA),
    ),
    ReminderItem(
      id: '3',
      title: 'Collect TSH Report - SRL Diagnostics...',
      time: 'Wed, 26 • After 5 PM',
      category: 'Report collection',
      categoryColor: const Color(0xFF15803D),
      categoryBg: const Color(0x1A22C55E),
    ),
    ReminderItem(
      id: '4',
      title: 'Have breakfast',
      time: 'Everyday • 8:30 AM',
      category: 'Food',
      categoryColor: const Color(0xFF15803D),
      categoryBg: const Color(0x1A22C55E),
    ),
  ];

  void _toggleReminder(String id) {
    setState(() {
      final index = _reminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        if (_reminders[index].status == ReminderStatus.completed) {
          _reminders[index].status = ReminderStatus.pending;
        } else {
          _reminders[index].status = ReminderStatus.completed;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFAFAFA,
      ), // neutral/50 background for main pages
      extendBody:
          true, // Allow content to scroll perfectly behind the glass bottom nav
      body: Stack(
        children: [
          SafeArea(
            bottom: false, // Pages handle their own bottom padding/clearance
            child: _buildPage(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  /// Resolve view based on selected bottom nav tab
  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return SummaryScreen(
          reminders: _reminders,
          onToggle: _toggleReminder,
          onNavigateToReminders: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        );
      case 1:
        return RemindersScreen(
          reminders: _reminders,
          onToggle: _toggleReminder,
        );
      case 2:
        return const RecordsScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const SummaryScreen(
          reminders: [],
          onToggle: _noopToggle,
          onNavigateToReminders: _noopNavigate,
        );
    }
  }

  static void _noopToggle(String _) {}

  static void _noopNavigate() {}

  /// Builds the unique custom glass-morphism sticky bottom navigation panel mapped from Figma
  Widget _buildBottomNav() {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      height: 85 + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Background Glass Layer (Full screen width, includes safe area)
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xE6F5F5F5), // 90% opacity #f5f5f5
                  ),
                ),
              ),
            ),
          ),
          
          // 2. Interactive Navigation Items (Centered higher to account for safe area)
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavItem(0, 'stacks.svg', 'stacks-1.svg', 'Summary'),
                _buildNavItem(1, 'event_list-1.svg', 'event_list.svg', 'Reminders'),
                const SizedBox(width: 80), // Gap for Ask AI button
                _buildNavItem(2, 'folder_open-1.svg', 'folder_open.svg', 'Records'),
                _buildNavItem(3, 'person-1.svg', 'person.svg', 'Profile'),
              ],
            ),
          ),

          // 2. Interactive Content Layer (Unclipped to allow Ask AI to spill out)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNavItem(0, 'stacks.svg', 'stacks-1.svg', 'Summary'),
              _buildNavItem(
                1,
                'event_list-1.svg',
                'event_list.svg',
                'Reminders',
              ),
              const SizedBox(
                width: 80,
              ), // Gap accommodating the bleeding Ask AI button
              _buildNavItem(
                2,
                'folder_open-1.svg',
                'folder_open.svg',
                'Records',
              ),
              _buildNavItem(3, 'person-1.svg', 'person.svg', 'Profile'),
            ],
          ),

          // 3. Super-Elevated "Ask AI" Central Action Button (Overflowing)
          Positioned(
            top: -28, 
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: KineticInteraction(
              onTap: () {
                context.pushPremium(const AskAiScreen());
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AskAiIcon(),
                  SizedBox(height: 4),
                  Text(
                    'Ask AI',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF60A5FA),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Nav discrete button constructor
  Widget _buildNavItem(
    int index,
    String selectedIcon,
    String unselectedIcon,
    String label,
  ) {
    bool isSelected = _selectedIndex == index;
    // Active states map to explicit black border-t & pink/950 text versus neutral/400 disabled
    return Expanded(
      child: KineticInteraction(
        onTap: () {
          setState(() => _selectedIndex = index);
        },
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(top: BorderSide(color: Colors.black, width: 2.0))
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/Figma MCP Assets/CommonAssets/Icons/${isSelected ? selectedIcon : unselectedIcon}',
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? const Color(0xFF2C0011)
                      : const Color(0xFFA3A3A3),
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF2C0011)
                      : const Color(0xFFA3A3A3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AskAiIcon extends StatelessWidget {
  const _AskAiIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF60A5FA).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Color(0xFF60A5FA),
          BlendMode.srcIn,
        ),
        child: Transform.scale(
          scale: 1.1,
          child: Image.asset(
            'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Flower.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
