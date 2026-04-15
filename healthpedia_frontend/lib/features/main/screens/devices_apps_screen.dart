import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class DevicesAppsScreen extends StatelessWidget {
  const DevicesAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg', width: 24)),
        title: Row(children: [
          SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/Devices & Apps big icon.svg', width: 24),
          const SizedBox(width: 8),
          Text('Devices & Apps', style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600)),
        ]),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDeviceCard('Google Fit', 'Connected • Syncing...', true, 'assets/Figma MCP Assets/CommonAssets/Icons/Google Fit Icon.png'),
          const SizedBox(height: 12),
          _buildDeviceCard('Apple Health', 'Not Connected', false, 'assets/Figma MCP Assets/CommonAssets/Icons/Apple Health Icon.png'),
          const SizedBox(height: 12),
          _buildDeviceCard('Samsung Health App', 'Not Connected', false, 'assets/Figma MCP Assets/CommonAssets/Icons/Samsung Health App Icon.png'),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(String name, String status, bool connected, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
      child: Row(
        children: [
          Image.asset(iconPath, width: 48, height: 48),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: AppTypography.label1.copyWith(fontWeight: FontWeight.w600)),
            Text(status, style: AppTypography.label3.copyWith(color: connected ? AppColors.green600 : AppColors.neutral500)),
          ])),
          Switch(value: connected, onChanged: (v) {}, activeColor: AppColors.blue600),
        ],
      ),
    );
  }
}
