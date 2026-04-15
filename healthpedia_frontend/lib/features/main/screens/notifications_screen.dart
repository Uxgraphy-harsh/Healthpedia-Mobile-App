import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg', width: 24)),
        title: Row(children: [
          SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/Notifications big icon.svg', width: 24),
          const SizedBox(width: 8),
          Text('Notifications', style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600)),
        ]),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGroup([
            _buildRow('Reminder alerts', 'Medicines, appointments, reports', true),
            _buildRow('Report processed', 'When your uploaded report is ready', true),
            _buildRow('Weekly digest', 'Your Sunday health summary', true, last: true),
          ]),
          const SizedBox(height: 16),
          _buildGroup([
            _buildRow('Daily AI summary', 'Morning health digest to your inbox', false, last: true),
          ]),
          const SizedBox(height: 16),
          _buildGroup([
            _buildRow('Notification sound', 'Play sound for reminders', true),
            _buildRow('Vibration', 'Vibrate on reminder alerts', true),
            _buildRow('Show on lock screen', 'Display reminders when locked', true, last: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
      child: Column(children: children),
    );
  }

  Widget _buildRow(String title, String sub, bool val, {bool last = false}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.label1.copyWith(fontWeight: FontWeight.w600)),
            Text(sub, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          ])),
          Switch(value: val, onChanged: (v) {}, activeColor: AppColors.blue600),
        ]),
      ),
      if (!last) const Divider(height: 1, indent: 16, endIndent: 16),
    ]);
  }
}
