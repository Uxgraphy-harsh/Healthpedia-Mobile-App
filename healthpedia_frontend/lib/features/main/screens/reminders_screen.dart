import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main_scaffold.dart';
import 'reminders_history_screen.dart';

class RemindersScreen extends StatefulWidget {
  final List<ReminderItem> reminders;
  final Function(String) onToggle;

  const RemindersScreen({
    super.key,
    required this.reminders,
    required this.onToggle,
  });

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Appointments', 'Medicines', 'Reports', 'Food'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only show pending reminders on this page. Completed/Missed move to History.
    final pendingReminders = widget.reminders.where((r) => r.status == ReminderStatus.pending).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- CUSTOM HEADER ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reminders',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 30, // Specified high-fidelity size
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RemindersHistoryScreen(
                                reminders: widget.reminders,
                                onToggle: widget.onToggle,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD4D4D4)), // Figma Neutral/300
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'History',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- TAB BAR ---
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start, // Align to the left
                  padding: const EdgeInsets.only(left: 16), // Match screen margin
                  labelColor: const Color(0xFF3B82F6), // Figma Blue/500
                  unselectedLabelColor: const Color(0xFF737373), // Figma Neutral/500
                  indicatorColor: const Color(0xFF3B82F6),
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.only(right: 24), // Space between tabs
                  labelStyle: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16, // High-fidelity size from Figma
                    fontWeight: FontWeight.w400, // Geist:Regular
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w400, // Geist:Regular
                  ),
                  tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                  dividerColor: const Color(0xFFE5E5E5),
                ),

                // --- CONTENT ---
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        'TODAY • 22 MAR',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF737373),
                          letterSpacing: 0.48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (pendingReminders.isEmpty)
                        _buildEmptyState()
                      else
                        ...pendingReminders.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildReminderCard(item),
                            )),
                      const SizedBox(height: 150), // Extra space for FAB and Nav
                    ],
                  ),
                ),
              ],
            ),
            // Floating Action Button - Add a reminder (Adjusted Radius and Positioning)
            Positioned(
              right: 16,
              bottom: 126,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(16), // Restored to consistent section radius
                    border: Border.all(color: const Color(0xFFFFC3D7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/Figma MCP Assets/Shared Assets/Icons/add_2.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(Color(0xFFCD577F), BlendMode.srcIn),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Add a reminder',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFCD577F),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              'All caught up!',
              style: TextStyle(fontFamily: 'Geist', color: Colors.grey[500], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(ReminderItem item) {
    return GestureDetector(
      onTap: () {
        widget.onToggle(item.id);
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
            // Checklist Icon (Dotted circle for pending)
            SvgPicture.asset(
              'assets/Figma MCP Assets/Shared Assets/Icons/Reminder Icon Placeholder 1.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.time,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12,
                      color: Color(0xFF737373),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A0A0A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.categoryBg,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      item.category,
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: item.categoryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
