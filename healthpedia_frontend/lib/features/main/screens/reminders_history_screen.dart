import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main_scaffold.dart'; // To access ReminderItem and ReminderStatus

class RemindersHistoryScreen extends StatefulWidget {
  final List<ReminderItem> reminders;
  final Function(String) onToggle;

  const RemindersHistoryScreen({
    super.key,
    required this.reminders,
    required this.onToggle,
  });

  @override
  State<RemindersHistoryScreen> createState() => _RemindersHistoryScreenState();
}

class _RemindersHistoryScreenState extends State<RemindersHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Appointments', 'Medicines', 'Reports', 'Food', 'General'];

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
    final historyItems = widget.reminders.where((r) => r.status != ReminderStatus.pending).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Figma Neutral/50
      body: SafeArea(
        child: Column(
          children: [
            // --- CUSTOM HEADER ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD4D4D4)),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Reminders History',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 24, // Consistent with design scale
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                ],
              ),
            ),

            // --- TAB BAR ---
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.only(left: 16),
              labelColor: const Color(0xFF3B82F6), // Figma Blue/500
              unselectedLabelColor: const Color(0xFF737373), // Figma Neutral/500
              indicatorColor: const Color(0xFF3B82F6),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(right: 24),
              labelStyle: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
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
              child: historyItems.isEmpty
                  ? Center(
                      child: Text(
                        'No history yet',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text(
                          'TODAY • 22 MAR'.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF737373),
                            letterSpacing: 0.48,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...historyItems.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildHistoryCard(item),
                            )),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(ReminderItem item) {
    final bool isMissed = item.status == ReminderStatus.missed;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onToggle(item.id);
          HapticFeedback.lightImpact();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Figma Neutral/100
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Row(
          children: [
            // Status Icon
            isMissed 
              ? SvgPicture.asset(
                  'assets/Figma MCP Assets/CommonAssets/Icons/Warning Container.svg',
                  width: 24,
                  height: 24,
                )
              : SvgPicture.asset(
                  'assets/Figma MCP Assets/CommonAssets/Icons/Reminder Icon Placeholder 3.svg',
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
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA3A3A3), // Neutral/400
                      decoration: TextDecoration.lineThrough,
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
