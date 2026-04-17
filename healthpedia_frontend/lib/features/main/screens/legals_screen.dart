import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class LegalsScreen extends StatelessWidget {
  const LegalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0A0A0A))),
        title: Row(children: [
          SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/Legals big icon.svg', width: 24),
          const SizedBox(width: 8),
          Text('Legals', style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600)),
        ]),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
            child: Column(children: [
              _buildRow('Terms & Conditions'),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildRow('Privacy Policy', last: true),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, {bool last = false}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: Text(title, style: AppTypography.label1.copyWith(fontWeight: FontWeight.w500))),
          const Icon(Icons.north_east, color: AppColors.neutral300, size: 20),
        ]),
      ),
    );
  }
}
