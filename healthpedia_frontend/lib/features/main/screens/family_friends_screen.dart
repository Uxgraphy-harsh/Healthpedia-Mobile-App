import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/main/widgets/add_member_bottom_sheet.dart';
import 'package:healthpedia_frontend/features/main/widgets/family_friends_about_dialog.dart';
import 'package:healthpedia_frontend/features/main/widgets/share_access_bottom_sheet.dart';
import 'package:healthpedia_frontend/features/main/screens/family_friend_detail_screen.dart';

class FamilyFriendsScreen extends StatefulWidget {
  const FamilyFriendsScreen({super.key});

  @override
  State<FamilyFriendsScreen> createState() => _FamilyFriendsScreenState();
}

class _FamilyFriendsScreenState extends State<FamilyFriendsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTabIndex = 0;

  static const List<_FamilyMember> _members = [
    _FamilyMember(
      relation: 'Father',
      ageLabel: '79 Years',
      name: 'Sujoy Sahu',
      status: 'Active Today',
      statusType: _MemberStatusType.active,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
      backgroundColor: AppColors.red100,
    ),
    _FamilyMember(
      relation: 'Brother',
      ageLabel: '47 Years',
      name: 'Arko Sahu',
      status: '2 days ago',
      statusType: _MemberStatusType.inactive,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 83.png',
      backgroundColor: AppColors.orange100,
    ),
    _FamilyMember(
      relation: 'Friend',
      ageLabel: '44 Years',
      name: 'Kaustav Dutta',
      status: '1 day ago',
      statusType: _MemberStatusType.inactive,
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 84.png',
      backgroundColor: AppColors.neutral200,
    ),
  ];

  static const List<_AccessRequest> _requests = [
    _AccessRequest(
      date: '04/02/2026',
      time: '8:30 AM',
      name: 'Sujoy Sahu',
      phoneNumber: '+91 7588495772',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
      backgroundColor: AppColors.red100,
    ),
    _AccessRequest(
      date: '04/02/2026',
      time: '8:30 AM',
      name: 'Sujoy Sahu',
      phoneNumber: '+91 7588495772',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
      backgroundColor: AppColors.red100,
    ),
  ];

  static const List<_SharedAccess> _sharedAccessList = [
    _SharedAccess(
      grantedDate: '04/02/2026',
      name: 'Sujoy Sahu',
      phoneNumber: '+91 7588495772',
      imagePath:
          'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
      backgroundColor: AppColors.red100,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                _FamilyFriendsHeader(tabController: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _YourListTab(members: _members),
                      _RequestsTab(requests: _requests),
                      _SharedTab(sharedAccessList: _sharedAccessList),
                    ],
                  ),
                ),
              ],
            ),
            if (_currentTabIndex == 0)
              Positioned(
                right: AppSpacing.space16,
                bottom: AppSpacing.space40,
                child: SafeArea(
                  top: false,
                  child: _AddMemberButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      showAddMemberBottomSheet(context);
                    },
                    label: 'Invite Member',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FamilyFriendsHeader extends StatelessWidget {
  const _FamilyFriendsHeader({required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space8,
            ),
            child: Row(
              children: [
                _HeaderIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: AppSpacing.space16),
                Expanded(
                  child: Text(
                    'Family & Friends',
                    style: AppTypography.h6SemiBold.copyWith(
                      color: AppColors.neutral950,
                    ),
                  ),
                ),
                _HeaderIconButton(
                  icon: Icons.info_outline,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    showFamilyFriendsAboutDialog(context);
                  },
                ),
              ],
            ),
          ),
          _FamilyFriendsTabs(tabController: tabController),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      onTap: onTap,
      child: SizedBox(
        width: AppSpacing.size40,
        height: AppSpacing.size40,
        child: Icon(icon, size: AppSpacing.size24, color: AppColors.neutral600),
      ),
    );
  }
}

class _FamilyFriendsTabs extends StatelessWidget {
  const _FamilyFriendsTabs({required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicatorColor: AppColors.blue500,
      indicatorWeight: 1,
      labelColor: AppColors.blue500,
      unselectedLabelColor: AppColors.neutral500,
      labelStyle: AppTypography.label1.copyWith(fontWeight: FontWeight.w400),
      unselectedLabelStyle: AppTypography.label1.copyWith(
        fontWeight: FontWeight.w400,
      ),
      tabs: const [
        Tab(text: 'Your List'),
        _RequestsTabLabel(count: 2),
        Tab(text: 'Shared'),
      ],
    );
  }
}

class _RequestsTabLabel extends StatelessWidget {
  const _RequestsTabLabel({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Requests'),
          const SizedBox(width: AppSpacing.space4),
          Container(
            width: AppSpacing.size20,
            height: AppSpacing.size20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.red500,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$count',
              style: AppTypography.label3.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _YourListTab extends StatelessWidget {
  const _YourListTab({required this.members});

  final List<_FamilyMember> members;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        120,
      ),
      itemCount: members.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.space8),
      itemBuilder: (context, index) =>
          _FamilyMemberCard(member: members[index]),
    );
  }
}

class _RequestsTab extends StatelessWidget {
  const _RequestsTab({required this.requests});

  final List<_AccessRequest> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        120,
      ),
      itemCount: requests.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.space24),
      itemBuilder: (context, index) => _RequestCard(request: requests[index]),
    );
  }
}

class _SharedTab extends StatelessWidget {
  const _SharedTab({required this.sharedAccessList});

  final List<_SharedAccess> sharedAccessList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        120,
      ),
      itemCount: sharedAccessList.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.space24),
      itemBuilder: (context, index) =>
          _SharedAccessCard(sharedAccess: sharedAccessList[index]),
    );
  }
}

class _SharedAccessCard extends StatelessWidget {
  const _SharedAccessCard({required this.sharedAccess});

  final _SharedAccess sharedAccess;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SharedAvatar(sharedAccess: sharedAccess),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Granted • ${sharedAccess.grantedDate}',
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                sharedAccess.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                sharedAccess.phoneNumber,
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        _RequestActionButton(
          label: 'Revoke Access',
          backgroundColor: AppColors.red500,
          foregroundColor: AppColors.white,
          onTap: () => HapticFeedback.selectionClick(),
        ),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final _AccessRequest request;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _RequestAvatar(request: request),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${request.date} • ${request.time}',
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                request.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                request.phoneNumber,
                style: AppTypography.label3.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        Row(
          children: [
            _RequestActionButton(
              label: 'Accept',
              backgroundColor: AppColors.blue400,
              foregroundColor: AppColors.white,
              onTap: () {
                HapticFeedback.selectionClick();
                showShareAccessBottomSheet(
                  context,
                  name: request.name,
                  phoneNumber: request.phoneNumber,
                  imagePath: request.imagePath,
                  backgroundColor: request.backgroundColor,
                );
              },
            ),
            const SizedBox(width: AppSpacing.space4),
            _RequestActionButton(
              label: 'Delete',
              backgroundColor: AppColors.neutral200,
              foregroundColor: AppColors.neutral950,
              onTap: () => HapticFeedback.selectionClick(),
            ),
          ],
        ),
      ],
    );
  }
}

class _FamilyMemberCard extends StatelessWidget {
  const _FamilyMemberCard({required this.member});

  final _FamilyMember member;

  @override
  Widget build(BuildContext context) {
    final statusStyle = member.statusType == _MemberStatusType.active
        ? const _StatusStyle(
            backgroundColor: Color(0x1A22C55E),
            borderColor: Color(0x1A22C55E),
            textColor: AppColors.green700,
          )
        : const _StatusStyle(
            backgroundColor: AppColors.neutral100,
            borderColor: AppColors.neutral200,
            textColor: AppColors.neutral600,
          );

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FamilyFriendDetailScreen(
              name: member.name,
              hpid: 'HPID: #8836477253',
              ageLabel: member.ageLabel.replaceAll(' Years', ' yo'),
              genderLabel: 'Male',
              imagePath: member.imagePath,
              avatarBackgroundColor: member.backgroundColor,
              allowedSections: kDefaultFamilyFriendSections,
              healthpediaId: '#9039443124',
              abhaId: '70-7463-2446-5247',
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space10,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  _FamilyAvatar(member: member),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${member.relation} • ${member.ageLabel}',
                          style: AppTypography.label3.copyWith(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          member.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.label1.copyWith(
                            color: AppColors.neutral950,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space8,
                            vertical: AppSpacing.space2,
                          ),
                          decoration: BoxDecoration(
                            color: statusStyle.backgroundColor,
                            border: Border.all(color: statusStyle.borderColor),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusFull,
                            ),
                          ),
                          child: Text(
                            member.status,
                            style: AppTypography.label3.copyWith(
                              color: statusStyle.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.space12),
            const Icon(
              Icons.chevron_right,
              color: AppColors.neutral500,
              size: AppSpacing.size24,
            ),
          ],
        ),
      ),
    );
  }
}

class _SharedAvatar extends StatelessWidget {
  const _SharedAvatar({required this.sharedAccess});

  final _SharedAccess sharedAccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(3.6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutral300),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: sharedAccess.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(sharedAccess.imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _RequestAvatar extends StatelessWidget {
  const _RequestAvatar({required this.request});

  final _AccessRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(3.6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutral300),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: request.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(request.imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _FamilyAvatar extends StatelessWidget {
  const _FamilyAvatar({required this.member});

  final _FamilyMember member;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(3.6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutral300),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: member.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(member.imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _RequestActionButton extends StatelessWidget {
  const _RequestActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space8,
            vertical: AppSpacing.space4,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          child: Text(
            label,
            style: AppTypography.body3.copyWith(
              color: foregroundColor,
              fontSize: 15,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton({required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space10,
          ),
          decoration: BoxDecoration(
            color: AppColors.rose50,
            border: Border.all(color: AppColors.pink100),
            borderRadius: BorderRadius.circular(AppSpacing.radius2xl),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add,
                size: AppSpacing.size24,
                color: AppColors.pink500,
              ),
              const SizedBox(width: AppSpacing.space12),
              Text(
                label,
                style: AppTypography.label1.copyWith(
                  color: AppColors.pink500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FamilyMember {
  const _FamilyMember({
    required this.relation,
    required this.ageLabel,
    required this.name,
    required this.status,
    required this.statusType,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String relation;
  final String ageLabel;
  final String name;
  final String status;
  final _MemberStatusType statusType;
  final String imagePath;
  final Color backgroundColor;
}

class _AccessRequest {
  const _AccessRequest({
    required this.date,
    required this.time,
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String date;
  final String time;
  final String name;
  final String phoneNumber;
  final String imagePath;
  final Color backgroundColor;
}

class _SharedAccess {
  const _SharedAccess({
    required this.grantedDate,
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String grantedDate;
  final String name;
  final String phoneNumber;
  final String imagePath;
  final Color backgroundColor;
}

class _StatusStyle {
  const _StatusStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
}

enum _MemberStatusType { active, inactive }
