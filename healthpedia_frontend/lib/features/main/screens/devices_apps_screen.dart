import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/premium_switch.dart';

class DevicesAppsScreen extends StatefulWidget {
  const DevicesAppsScreen({super.key});

  @override
  State<DevicesAppsScreen> createState() => _DevicesAppsScreenState();
}

class _DevicesAppsScreenState extends State<DevicesAppsScreen> {
  late final List<_DeviceItem> _trackers;

  @override
  void initState() {
    super.initState();
    _trackers = [
      _DeviceItem(
        name: 'Google Fit',
        status: 'Connected • Syncing...',
        connected: true,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/image 27.png',
      ),
      _DeviceItem(
        name: 'Apple Health',
        status: 'Not Connected',
        connected: false,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/image 6.png',
      ),
      _DeviceItem(
        name: 'Samsung Health App',
        status: 'Not Connected',
        connected: false,
        iconPath: 'assets/Figma MCP Assets/CommonAssets/Icons/image 7.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.neutral950),
          ),
        ),
        title: Row(
          children: [
            _buildHeaderIcon(),
            const SizedBox(width: 12),
            Text(
              'Devices & Apps',
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
          _buildDeviceSection(
            'Health Trackers',
            _trackers,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return SvgPicture.asset(
      'assets/Figma MCP Assets/CommonAssets/Icons/Devices & Apps big icon.svg',
      width: 24,
      height: 24,
      placeholderBuilder: (_) => const Icon(
        Icons.devices,
        size: 24,
        color: AppColors.blue500,
      ),
    );
  }

  Widget _buildDeviceSection(String title, List<_DeviceItem> devices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        ...devices.map((device) => _buildDeviceCard(device)),
      ],
    );
  }

  Widget _buildDeviceCard(_DeviceItem device) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          _buildDeviceIcon(device.iconPath),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  device.name,
                  style: AppTypography.label1.copyWith(
                    color: AppColors.neutral950,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  device.connected ? 'Connected • Syncing...' : 'Not Connected',
                  style: AppTypography.label3.copyWith(
                    color: device.connected ? AppColors.green700 : AppColors.neutral500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PremiumSwitch(
            value: device.connected,
            onChanged: (v) {
              setState(() {
                device.connected = v;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceIcon(String path) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.neutral100,
          child: const Icon(Icons.image_not_supported,
              size: 20, color: AppColors.neutral400),
        ),
      ),
    );
  }
}

class _DeviceItem {
  final String name;
  final String status;
  final String iconPath;
  bool connected;

  _DeviceItem({
    required this.name,
    required this.status,
    required this.connected,
    required this.iconPath,
  });
}
