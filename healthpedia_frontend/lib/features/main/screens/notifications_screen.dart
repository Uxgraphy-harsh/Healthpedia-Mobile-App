import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_switch.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Tracking states for the demo
  final Map<String, bool> _settings = {
    'Reminder alerts': true,
    'Report processed': true,
    'Weekly digest': true,
    'Daily AI summary': false,
    'Notification sound': true,
    'Vibration': true,
    'Show on lock screen': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
              width: 24,
            ),
          ),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/Figma MCP Assets/CommonAssets/Icons/Notifications big icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Notifications',
              style: AppTypography.h6.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.neutral200, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGroup([
            _buildRow('Reminder alerts', 'Medicines, appointments, reports'),
            _buildRow('Report processed', 'When your uploaded report is ready'),
            _buildRow(
              'Weekly digest',
              'Your Sunday health summary',
              last: true,
            ),
          ]),
          const SizedBox(height: 16),
          _buildGroup([
            _buildRow(
              'Daily AI summary',
              'Morning health digest to your inbox',
              last: true,
            ),
          ]),
          const SizedBox(height: 16),
          _buildGroup([
            _buildRow('Notification sound', 'Play sound for reminders'),
            _buildRow('Vibration', 'Vibrate on reminder alerts'),
            _buildRow(
              'Show on lock screen',
              'Display reminders when locked',
              last: true,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildRow(String title, String sub, {bool last = false}) {
    final bool currentVal = _settings[title] ?? false;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.label1.copyWith(
                        color: AppColors.neutral950,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      style: AppTypography.label3.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              PremiumSwitch(
                value: currentVal,
                onChanged: (v) {
                  setState(() {
                    _settings[title] = v;
                  });
                },
              ),
            ],
          ),
        ),
        if (!last)
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: AppColors.neutral100,
          ),
      ],
    );
  }
}
