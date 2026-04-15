import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import '../widgets/connect_abha_bottom_sheet.dart';

enum AbhaState { info, connecting, dashboard }

class AbhaIdScreen extends StatefulWidget {
  const AbhaIdScreen({super.key});

  @override
  State<AbhaIdScreen> createState() => _AbhaIdScreenState();
}

class _AbhaIdScreenState extends State<AbhaIdScreen> with TickerProviderStateMixin {
  AbhaState _currentState = AbhaState.info;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startConnecting() async {
    setState(() => _currentState = AbhaState.connecting);
    // Simulate connection phases
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) setState(() => _currentState = AbhaState.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == AbhaState.connecting) return _buildConnectingView();
    if (_currentState == AbhaState.dashboard) return _buildDashboardView();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 24),
                  _buildFeaturesList(),
                ],
              ),
            ),
          ),
          _buildStickyButtons(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: SvgPicture.asset(
            'assets/Figma MCP Assets/CommonAssets/Icons/arrow_back.svg',
            width: 24, height: 24,
          ),
        ),
      ),
      title: Row(
        children: [
          Image.asset(
            'assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png',
            width: 24, height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Abha ID',
            style: AppTypography.h6.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Image.asset('assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png', width: 48, height: 48),
          const SizedBox(height: 16),
          Text('Ayushman Bharat Health Account', style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Connect your ABHA ID to automatically import your medical records from government health facilities across India.',
              style: AppTypography.label3.copyWith(color: AppColors.neutral600, height: 1.4), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTag('Govt. Verified'),
              const SizedBox(width: 8),
              _buildTag('End-to-End Encrypted'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFBBF7D0), borderRadius: BorderRadius.circular(99)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label.contains('Encrypted')) const Icon(Icons.lock_outline, size: 12, color: AppColors.green700),
          const SizedBox(width: 4),
          Text(label, style: AppTypography.label3.copyWith(color: AppColors.green700, fontWeight: FontWeight.w500, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WHAT YOU GET WITH ABHA', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 16),
          _buildFeatureRow('Auto-import Medical Records', 'Lab reports, prescriptions, and discharge summaries from ABDM-linked facilities pulled automatically.',
              'assets/Figma MCP Assets/CommonAssets/Icons/medical_records.svg', const Color(0xFFDCFCE7), AppColors.green600),
          const Divider(height: 1, color: AppColors.neutral200),
          _buildFeatureRow('Unified Health History', 'All visits, tests, and treatments from any ABDM-registered hospital in one place.',
              'assets/Figma MCP Assets/CommonAssets/Icons/health_history.svg', const Color(0xFFDBEAFE), AppColors.blue600),
          const Divider(height: 1, color: AppColors.neutral200),
          _buildFeatureRow('Share with Doctors', 'Grant consent-based access to your records at any hospital visit - no paperwork needed.',
              'assets/Figma MCP Assets/CommonAssets/Icons/share_doctors.svg', const Color(0xFFFEF3C7), AppColors.orange600),
          const Divider(height: 1, color: AppColors.neutral200),
          _buildFeatureRow('AI-powered Insights', 'Healthpedia AI can analyse your ABHA records to give you personalised health guidance.',
              'assets/Figma MCP Assets/CommonAssets/Icons/ai_insights.svg', const Color(0xFFF3E8FF), AppColors.indigo600),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String title, String desc, String iconPath, Color iconBg, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36, padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 4),
            Text(desc, style: AppTypography.label3.copyWith(color: AppColors.neutral500, height: 1.4)),
          ])),
        ],
      ),
    );
  }

  Widget _buildStickyButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.white, border: Border(top: BorderSide(color: AppColors.neutral100))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              showConnectAbhaSheet(context, _startConnecting);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green600, minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)), elevation: 0),
            child: Text('Connect ABHA ID', style: AppTypography.label1.copyWith(color: AppColors.white, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () { HapticFeedback.lightImpact(); },
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 56), side: const BorderSide(color: AppColors.neutral950),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
            child: Text('Create new ABHA ID', style: AppTypography.label1.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // --- CONNECTING VIEW ---
  Widget _buildConnectingView() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween(begin: 1.0, end: 1.2).animate(_pulseController),
                    child: Container(
                      width: 160, height: 160,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.green600.withOpacity(0.3), width: 2)),
                    ),
                  ),
                  Image.asset('assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png', width: 80, height: 80),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Connecting to ABDM', style: AppTypography.h6.copyWith(color: AppColors.neutral900, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text('Securely fetching your health records from the Ayushman Bharat network...',
                  textAlign: TextAlign.center, style: AppTypography.label3.copyWith(color: AppColors.neutral600)),
            ),
            const SizedBox(height: 48),
            _buildSyncStep('OTP Verified', true),
            _buildSyncStep('ABHA Account Linked', true),
            _buildSyncStep('Fetching Health Records', false, isChecking: true),
            _buildSyncStep('Organising Files with Ai', false),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStep(String title, bool completed, {bool isChecking = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(completed ? Icons.check_circle : Icons.circle_outlined, 
               color: completed ? AppColors.green600 : (isChecking ? AppColors.orange400 : AppColors.neutral300), 
               size: 20),
          const SizedBox(width: 12),
          Text(title, style: AppTypography.label2.copyWith(color: completed ? AppColors.green700 : AppColors.neutral900, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // --- DASHBOARD VIEW ---
  Widget _buildDashboardView() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAbhaCard(),
            const SizedBox(height: 16),
            _buildSummaryStats(),
            const SizedBox(height: 16),
            _buildSyncStatusRow(),
            const SizedBox(height: 16),
            _buildSyncHistory(),
            const SizedBox(height: 16),
            _buildLinkedFacilities(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => _currentState = AbhaState.info),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red500, minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)), elevation: 0),
              child: Text('Disconnect ABHA ID', style: AppTypography.label1.copyWith(color: AppColors.white)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAbhaCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFBBF7D0).withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [const Color(0xFFBBF7D0), const Color(0xFFBBF7D0).withOpacity(0.8)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text('AYUSHMAN\nBHARAT', style: AppTypography.label3.copyWith(color: AppColors.green800, fontWeight: FontWeight.w700, height: 1.1, fontSize: 10)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                  decoration: BoxDecoration(color: AppColors.green600, borderRadius: BorderRadius.circular(8)),
                  child: Text('Verified', style: AppTypography.label3.copyWith(color: AppColors.white, fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 24),
          Text('91-4829-6371-8294', style: AppTypography.h5.copyWith(color: AppColors.green900, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
          Text('mahesh.sahu@abdm', style: AppTypography.label2.copyWith(color: AppColors.green800)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mahesh Sahu', style: AppTypography.label1.copyWith(color: AppColors.green900, fontWeight: FontWeight.w600)),
                  Text('45 yo  •  Male  •  B+', style: AppTypography.label3.copyWith(color: AppColors.green800)),
                ],
              ),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.white.withOpacity(0.5), shape: BoxShape.circle),
                  child: const Icon(Icons.copy, size: 20, color: AppColors.green800)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Row(
      children: [
        _buildStatCard('340', 'Total Records'),
        const SizedBox(width: 12),
        _buildStatCard('56.1 MB', 'Size'),
        const SizedBox(width: 12),
        _buildStatCard('11', 'Facilities'),
      ],
    );
  }

  Widget _buildStatCard(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.neutral100)),
        child: Column(
          children: [
            Text(val, style: AppTypography.label1.copyWith(color: AppColors.neutral900, fontWeight: FontWeight.w700)),
            Text(label, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatusRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline, color: AppColors.green600, size: 20),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Synced', style: AppTypography.label1.copyWith(color: AppColors.neutral900, fontWeight: FontWeight.w600)),
                Text('Last synced on 1 Jan, 2024', style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
              ]),
              const Spacer(),
              _buildSyncButton(),
            ],
          ),
          const SizedBox(height: 8),
          Padding(padding: const EdgeInsets.only(left: 32), child: Text('312 records added', style: AppTypography.label3.copyWith(color: AppColors.green600, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildSyncButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.green200)),
      child: Row(children: [const Icon(Icons.sync, size: 16, color: AppColors.green700), const SizedBox(width: 4), 
          Text('Sync', style: AppTypography.label2.copyWith(color: AppColors.green700, fontWeight: FontWeight.w600))]),
    );
  }

  Widget _buildSyncHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SYNC HISTORY', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildSyncHistoryItem('Full Sync - 312 records', 'Today, 7:42 AM • Initial import from ABDM', '+312', '48.2 MB'),
          const Divider(),
          _buildSyncHistoryItem('Thyroid Report - SRL Diagnostics', '14 Jan 2025, 9:10 AM', '+3', '2.4 MB'),
          const Divider(),
          _buildSyncHistoryItem('Prescription - Apollo Clinic Pune', '2 Nov 2024, 3:45 PM', '+5', '0.8 MB'),
        ],
      ),
    );
  }

  Widget _buildSyncHistoryItem(String title, String subtitle, String count, String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.label2.copyWith(color: AppColors.neutral900, fontWeight: FontWeight.w600)),
            Text(subtitle, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(count, style: AppTypography.label2.copyWith(color: AppColors.green600, fontWeight: FontWeight.w700)),
            Text(size, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          ]),
        ],
      ),
    );
  }

  Widget _buildLinkedFacilities() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LINKED FACILITIES', style: AppTypography.label3.copyWith(color: AppColors.neutral500, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildFacilityRow('Apollo Clinic Pune', 'Auto-sync enabled • 47 records', true),
          const Divider(),
          _buildFacilityRow('SRL Diagnostics, Baner', 'Auto-sync enabled • 89 records', true),
          const Divider(),
          _buildFacilityRow('Ruby Hall Clinic', 'Auto-sync enabled • 63 records', true),
          const Divider(),
          _buildFacilityRow('Sahyadri Hospital', 'Auto-sync paused', false),
        ],
      ),
    );
  }

  Widget _buildFacilityRow(String title, String sub, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTypography.label2.copyWith(color: AppColors.neutral900, fontWeight: FontWeight.w600)),
            Text(sub, style: AppTypography.label3.copyWith(color: AppColors.neutral500)),
          ]),
          Switch(value: active, onChanged: (v) {}, activeColor: AppColors.blue600),
        ],
      ),
    );
  }
}
