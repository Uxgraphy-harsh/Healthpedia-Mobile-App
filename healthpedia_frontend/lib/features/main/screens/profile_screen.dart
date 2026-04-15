import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'family_friends_screen.dart';
import '../widgets/change_profile_photo_bottom_sheet.dart';
import 'personal_information_screen.dart';
import 'conditions_screen.dart';
import 'allergies_screen.dart';
import 'family_history_screen.dart';
import 'insurance_screen.dart';
import 'abha_id_screen.dart';
import 'devices_apps_screen.dart';
import 'notifications_screen.dart';
import 'app_settings_screen.dart';
import 'data_privacy_screen.dart';
import 'legals_screen.dart';
import '../widgets/blood_group_bottom_sheet.dart';
import '../widgets/city_autocomplete_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space16,
            AppSpacing.space24,
            AppSpacing.space16,
            120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _ProfileHero(),
              SizedBox(height: AppSpacing.space24),
              _PremiumCards(),
              SizedBox(height: AppSpacing.space24),
              _PrimaryProfileSection(),
              SizedBox(height: AppSpacing.space12),
              _SingleItemSection(
                items: [
                  _ProfileMenuData(
                    label: 'Devices & Apps',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Devices & Apps big icon.svg',
                    iconBackground: const Color(0xFFA855F7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DevicesAppsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space12),
              _SingleItemSection(
                items: [
                  _ProfileMenuData(
                    label: 'Notifications',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Notifications big icon.svg',
                    iconBackground: const Color(0xFFF97316),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                  _ProfileMenuData(
                    label: 'App Settings',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/App Settings big icon.svg',
                    iconBackground: const Color(0xFF737373),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppSettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space12),
              _SingleItemSection(
                items: [
                  _ProfileMenuData(
                    label: 'Data & Privacy',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Data & Privacy big icon.svg',
                    iconBackground: const Color(0xFF6366F1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DataPrivacyScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space12),
              _SingleItemSection(
                items: [
                  _ProfileMenuData(
                    label: 'Help us Improve Healthpedia',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Help us Improve Healthpedia big icon.svg',
                    trailingType: _TrailingType.external,
                    iconBackground: Color(0xFFFF96BE),
                  ),
                  _ProfileMenuData(
                    label: 'Legals',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Legals big icon.svg',
                    iconBackground: const Color(0xFF06B6D4),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LegalsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space12),
              _SingleItemSection(
                items: [
                  _ProfileMenuData(
                    label: 'Rate us on Playstore',
                    iconType: _ProfileIconType.svg,
                    iconPath:
                        'assets/Figma MCP Assets/CommonAssets/Icons/Rate us on Playstore big icon.svg',
                    trailingType: _TrailingType.none,
                    iconBackground: Color(0xFFFF96BE),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space12),
              _LogoutSection(),
              SizedBox(height: AppSpacing.space20),
              _SocialLinks(),
              SizedBox(height: AppSpacing.space20),
              _AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            showChangeProfilePhotoSheet(context);
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 136,
                height: 136,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.pink200, width: 3),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange200,
                    border: Border.all(color: AppColors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 84.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 4,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neutral300, width: 2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/Figma MCP Assets/CommonAssets/Icons/edit.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0x193B82F6),
            border: Border.all(color: const Color(0x193B82F6)),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Text(
            'Health Score: 74',
            style: AppTypography.label2.copyWith(
              color: AppColors.blue600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        Text(
          'Mahesh Sahu',
          style: AppTypography.h2.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          'HPID: #9039443124',
          style: AppTypography.h6.copyWith(
            color: AppColors.pink500,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          '45 yo • Male',
          style: AppTypography.h6.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PremiumCards extends StatelessWidget {
  const _PremiumCards();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: [
          _PromoCard(
            iconPath:
                'assets/Figma MCP Assets/CommonAssets/Icons/Upgrade to Premium icon.svg',
            title: 'Upgrade to Premium',
            subtitle: '7 days free trial',
            titleColor: AppColors.purple950,
            subtitleColor: AppColors.purple600,
            borderColor: AppColors.purple500,
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.white, AppColors.purple50],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radius2xl),
              topRight: Radius.circular(AppSpacing.radius2xl),
            ),
          ),
          _PromoCard(
            iconPath:
                'assets/Figma MCP Assets/CommonAssets/Icons/Refer & Earn icon.svg',
            title: 'Refer & Earn',
            subtitle: 'Extend trial by 1 month on each referral.',
            titleColor: AppColors.amber950,
            subtitleColor: AppColors.amber600,
            borderColor: AppColors.amber400,
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.white, AppColors.amber50],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppSpacing.radius2xl),
              bottomRight: Radius.circular(AppSpacing.radius2xl),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
    required this.borderColor,
    required this.gradient,
    required this.borderRadius,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final Color borderColor;
  final Gradient gradient;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border.all(color: borderColor),
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconPath, width: 44, height: 44),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.label1.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    subtitle,
                    style: AppTypography.label2.copyWith(
                      color: subtitleColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryProfileSection extends StatelessWidget {
  const _PrimaryProfileSection();

  @override
  Widget build(BuildContext context) {
    return _SingleItemSection(
      items: [
        _ProfileMenuData(
          label: 'Personal Information',
          iconType: _ProfileIconType.svg,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Personal Information big icon.svg',
          iconBackground: AppColors.blue500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalInformationScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Conditions',
          iconType: _ProfileIconType.svg,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Conditions big icon.svg',
          iconBackground: AppColors.rose500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConditionsScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Allergies',
          iconType: _ProfileIconType.svg,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Allergies big icon.svg',
          iconBackground: AppColors.orange500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllergiesScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Family History',
          iconType: _ProfileIconType.svg,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Family History big icon.svg',
          iconBackground: AppColors.indigo500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FamilyHistoryScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Insurance',
          iconType: _ProfileIconType.svg,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Insurance big icon.svg',
          iconBackground: AppColors.teal500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InsuranceScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Family & Friends',
          iconType: _ProfileIconType.image,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Family & Friends big icon.png',
          trailingType: _TrailingType.chevron,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FamilyFriendsScreen(),
              ),
            );
          },
        ),
        _ProfileMenuData(
          label: 'Abha ID',
          secondaryLabel: '(Ayushman Bharat)',
          iconType: _ProfileIconType.image,
          iconPath:
              'assets/Figma MCP Assets/CommonAssets/Icons/Abha ID (Ayushman Bharat) icon.png',
          trailingType: _TrailingType.chevron,
          secondaryColor: AppColors.orange500,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AbhaIdScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SingleItemSection extends StatelessWidget {
  const _SingleItemSection({required this.items});

  final List<_ProfileMenuData> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final showDivider = index < items.length - 1;
          return _ProfileMenuRow(data: item, showDivider: showDivider);
        }),
      ),
    );
  }
}

class _ProfileMenuRow extends StatelessWidget {
  const _ProfileMenuRow({required this.data, required this.showDivider});

  final _ProfileMenuData data;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        data.onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            _ProfileLeadingIcon(data: data),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: showDivider
                      ? const Border(
                          bottom: BorderSide(color: AppColors.neutral200),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: data.secondaryLabel == null
                          ? Text(
                              data.label,
                              style: AppTypography.label1.copyWith(
                                color: AppColors.neutral950,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                style: AppTypography.label1.copyWith(
                                  color: AppColors.neutral950,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(text: data.label),
                                  TextSpan(
                                    text: ' ${data.secondaryLabel}',
                                    style: AppTypography.label1.copyWith(
                                      color:
                                          data.secondaryColor ??
                                          AppColors.neutral950,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    if (data.trailingType == _TrailingType.chevron)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          'assets/Figma MCP Assets/CommonAssets/Icons/Field Icon V1.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    if (data.trailingType == _TrailingType.external)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          'assets/Figma MCP Assets/CommonAssets/Icons/arrow_upward.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileLeadingIcon extends StatelessWidget {
  const _ProfileLeadingIcon({required this.data});

  final _ProfileMenuData data;

  @override
  Widget build(BuildContext context) {
    if (data.iconType == _ProfileIconType.image &&
        data.iconBackground == null) {
      return Image.asset(
        data.iconPath,
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: data.iconBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: data.iconType == _ProfileIconType.svg
          ? Center(
              child: SvgPicture.asset(data.iconPath, width: 24, height: 24),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: Image.asset(data.iconPath, fit: BoxFit.cover),
            ),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.5),
        child: Row(
          children: [
            SizedBox(width: 32, height: 32, child: _LogoutIcon()),
            SizedBox(width: AppSpacing.space12),
            Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.red500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutIcon extends StatelessWidget {
  const _LogoutIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/Figma MCP Assets/CommonAssets/Icons/Logout icon.svg',
      width: 32,
      height: 32,
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    const links = [
      _SocialData(
        label: 'LinkedIN',
        assetPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/LinkedIN icon.png',
      ),
      _SocialData(
        label: 'Instagram',
        assetPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Instagram icon.png',
      ),
      _SocialData(
        label: 'Facebook',
        assetPath:
            'assets/Figma MCP Assets/CommonAssets/Icons/Facebook icon.png',
      ),
      _SocialData(
        label: 'X',
        assetPath: 'assets/Figma MCP Assets/CommonAssets/Icons/X icon.png',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: links
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(
                right: item == links.last ? 0 : AppSpacing.space24,
              ),
              child: _SocialIcon(data: item),
            ),
          )
          .toList(),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.data});

  final _SocialData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      child: Column(
        children: [
          Image.asset(
            data.assetPath,
            width: 54,
            height: 54,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSpacing.space10),
          Text(
            data.label,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF381700),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/Figma MCP Assets/CommonAssets/Icons/Flower company icon.png',
          width: 44,
          height: 44,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          'SECURE • SAFE • TRUSTED',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            letterSpacing: 0.48,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          'App Version 1.0.0 • Build 0001',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          '© 2026 NATARAJA VENTURES PVT LTD.',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          'All Rights Reserved',
          style: AppTypography.label3.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.space8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Made with',
              style: AppTypography.label3.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: AppSpacing.space4),
            const Icon(Icons.favorite, size: 18, color: Color(0xFFFF6B35)),
            const SizedBox(width: AppSpacing.space4),
            Text(
              'in India',
              style: AppTypography.label3.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileMenuData {
  const _ProfileMenuData({
    required this.label,
    required this.iconType,
    required this.iconPath,
    this.trailingType = _TrailingType.chevron,
    this.iconBackground,
    this.secondaryLabel,
    this.secondaryColor,
    this.onTap,
  });

  final String label;
  final _ProfileIconType iconType;
  final String iconPath;
  final _TrailingType trailingType;
  final Color? iconBackground;
  final String? secondaryLabel;
  final Color? secondaryColor;
  final VoidCallback? onTap;
}

class _SocialData {
  const _SocialData({required this.label, required this.assetPath});

  final String label;
  final String assetPath;
}

enum _ProfileIconType { svg, image }

enum _TrailingType { chevron, external, none }
