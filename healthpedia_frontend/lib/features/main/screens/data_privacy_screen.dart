import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class DataPrivacyScreen extends StatelessWidget {
  const DataPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg', width: 24)),
        title: Row(children: [
          SvgPicture.asset('assets/Figma MCP Assets/CommonAssets/Icons/Data & Privacy big icon.svg', width: 24),
          const SizedBox(width: 8),
          Text('Data & Privacy', style: AppTypography.h6.copyWith(fontWeight: FontWeight.w600)),
        ]),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('HOW WE PROTECT YOUR DATA', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
              const SizedBox(height: 16),
              _buildInfoRow('End-to-end encryption', 'All health data is encrypted at rest and in transit. No one — including us — can read your data.', Icons.lock_person_outlined),
              const Divider(height: 32),
              _buildInfoRow('Data stored in India', 'All your health data is stored on servers located within India, compliant with DPDP Act 2023.', Icons.location_on_outlined, isFlag: true),
            ]),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.red500, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)), elevation: 0),
            child: Text('Delete my Account', style: AppTypography.label1.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String desc, IconData icon, {bool isFlag = false}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      isFlag 
          ? Padding(padding: const EdgeInsets.only(top: 4), child: Image.asset('assets/Figma MCP Assets/CommonAssets/Icons/India Flag.png', width: 20))
          : Icon(icon, color: AppColors.blue500, size: 24),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTypography.label1.copyWith(fontWeight: FontWeight.w600)),
        Text(desc, style: AppTypography.label2.copyWith(color: AppColors.neutral500)),
      ])),
    ]);
  }
}
