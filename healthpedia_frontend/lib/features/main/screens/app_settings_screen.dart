import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg', width: 24)),
        title: Row(children: [
          SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/App Settings big icon.svg', width: 24),
          const SizedBox(width: 8),
          Text('App Settings', style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600)),
        ]),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Accessibility', style: AppTypography.label1.copyWith(fontWeight: FontWeight.w600)),
                Text('Bigger fonts and icons', style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
              ])),
              Switch(value: false, onChanged: (v) {}, activeColor: AppColors.blue600),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
            child: Column(children: [
              _buildRow('Language', 'English'),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildRow('Units', 'Metric'),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildRow('Temprature', 'Celcius', last: true),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String val, {bool last = false}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: Text(title, style: AppTypography.label1.copyWith(color: AppColors.neutral500))),
          Text(val, style: AppTypography.label1.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: AppColors.neutral300),
        ]),
      ),
    );
  }
}
