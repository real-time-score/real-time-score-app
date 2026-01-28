import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../l10n/app_localizations.dart';

/// MY 페이지
class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
    this.showBottomNav = true,
  });

  /// 하단 네비게이션 표시 여부
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 프로필 섹션
                    _buildProfileSection(context),
                    const SizedBox(height: 16),
                    // 메뉴 리스트
                    _buildMenuList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // 하단 네비게이션
      bottomNavigationBar: showBottomNav ? _buildBottomNavigation(context) : null,
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MY',
            style: AppTextStyles.h3Bold.copyWith(
              color: AppColors.labelStrong,
            ),
          ),
        ],
      ),
    );
  }

  /// 프로필 섹션
  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 정보 (왼쪽)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // 프로필 상단 (이미지 + 닉네임)
                _buildProfileTop(context),
                const SizedBox(height: 16),
                // 통계 카드
                _buildStatCards(context),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 알림 사이드바 (오른쪽)
          Expanded(
            flex: 1,
            child: _buildNotificationSidebar(),
          ),
        ],
      ),
    );
  }

  /// 프로필 상단
  Widget _buildProfileTop(BuildContext context) {
    return Row(
      children: [
        // 프로필 이미지
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile-edit');
          },
          child: Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.containerNormal,
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.labelAlternative,
                ),
              ),
              // 수정 뱃지
              Positioned(
                bottom: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.contentsNeutral,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.edit,
                        style: AppTextStyles.caption1Medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // 닉네임 + 통계
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임
                Text(
                  l10n.nickname,
                  style: AppTextStyles.h3Bold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                const SizedBox(height: 4),
                // 받은 알림
                Row(
                  children: [
                    Text(
                      l10n.receivedNotification,
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NN',
                      style: AppTextStyles.label1Bold.copyWith(
                        color: AppColors.decrease,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 예측성공
                Row(
                  children: [
                    Text(
                      l10n.predictionSuccess,
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NN%/NNN',
                      style: AppTextStyles.label1Bold.copyWith(
                        color: AppColors.negative,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  /// 통계 카드
  Widget _buildStatCards(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // 인증뱃지 + 활동온도
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/certification-badge'),
                child: _buildStatCard(l10n.certificationBadge, 'N개'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/activity-temperature'),
                child: _buildStatCard(l10n.activityTemperature, '42.9°C'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 포인트
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/point-management'),
            child: _buildStatCard(l10n.point, 'NNN,NNN P'),
          ),
        ),
      ],
    );
  }

  /// 통계 카드 위젯
  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.label1Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ],
      ),
    );
  }

  /// 알림 사이드바
  Widget _buildNotificationSidebar() {
    return Row(
      children: [
        // 첫 번째 열 (나를 알림 설정한 사람)
        _buildNotificationColumn(isLeftColumn: true),
        // 두 번째 열 (내가 알림한 사람)
        _buildNotificationColumn(isLeftColumn: false),
      ],
    );
  }

  /// 알림 열
  /// [isLeftColumn] true: 나를 알림 설정한 사람 (빨간색, 왼쪽 화살표)
  ///                false: 내가 알림한 사람 (파란색, 오른쪽 화살표)
  Widget _buildNotificationColumn({required bool isLeftColumn}) {
    final badgeColor = isLeftColumn ? AppColors.negative : AppColors.decrease;
    final arrowIcon = isLeftColumn ? AppIcons.arrowLeft : AppIcons.arrowRight;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 헤더 (벨 아이콘 + 화살표 뱃지)
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.containerNeutral,
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.only(
                topLeft: isLeftColumn ? const Radius.circular(8) : Radius.zero,
                topRight: !isLeftColumn ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.bell,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.labelNeutral,
                    BlendMode.srcIn,
                  ),
                ),
                // 화살표 뱃지
                Positioned(
                  top: 4,
                  right: 10,
                  child: Container(
                    width: 13,
                    height: 13,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      arrowIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 사용자 리스트
          Container(
            height: 188,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.only(
                bottomLeft: isLeftColumn ? const Radius.circular(8) : Radius.zero,
                bottomRight: !isLeftColumn ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildUserAvatar();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 사용자 아바타
  Widget _buildUserAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person,
              size: 20,
              color: AppColors.labelAlternative,
            ),
          ),
          const SizedBox(height: 4),
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Text(
                l10n.nickname,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 메뉴 리스트
  Widget _buildMenuList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMenuItem(AppIcons.megaphone, l10n.notice, () {
            Navigator.pushNamed(context, '/notice');
          }),
          const SizedBox(height: 8),
          _buildMenuItem(AppIcons.sparkle, l10n.event, () {
            Navigator.pushNamed(context, '/event');
          }),
          const SizedBox(height: 8),
          _buildMenuItem(AppIcons.bubble, l10n.inquiry, () {
            Navigator.pushNamed(context, '/inquiry');
          }),
          const SizedBox(height: 8),
          _buildMenuItem(AppIcons.circleQuestion, l10n.faq, () {
            Navigator.pushNamed(context, '/faq');
          }),
          const SizedBox(height: 8),
          _buildMenuItem(AppIcons.setting, l10n.appSettings, () {
            Navigator.pushNamed(context, '/app-settings');
          }),
          const SizedBox(height: 8),
          _buildMenuItem(AppIcons.documentText, l10n.terms, () {
            Navigator.pushNamed(context, '/terms');
          }),
        ],
      ),
    );
  }

  /// 메뉴 아이템
  Widget _buildMenuItem(String iconPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.containerNormal,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.labelNeutral,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 하단 네비게이션
  Widget _buildBottomNavigation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(context, AppIcons.home, l10n.home, '/main', false),
              _buildNavItem(context, AppIcons.check, l10n.pickExpert, '/main/pick-expert', false),
              _buildNavItem(context, AppIcons.persons, l10n.community, '/main/community', false),
              _buildNavItem(context, AppIcons.trophy, l10n.ranking, '/main/ranking', false),
              _buildNavItem(context, AppIcons.person, l10n.my, '', true),
            ],
          ),
        ),
      ),
    );
  }

  /// 네비게이션 아이템
  Widget _buildNavItem(BuildContext context, String iconPath, String label, String route, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (route.isNotEmpty) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        width: 54,
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primaryFigma : AppColors.labelAlternative,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: isActive
                  ? AppTextStyles.label1Bold.copyWith(
                      color: AppColors.primaryFigma,
                    )
                  : AppTextStyles.label1Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
