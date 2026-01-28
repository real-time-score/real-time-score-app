import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../live_score/presentation/pages/live_score_main_page.dart';
import '../../../pick_expert/presentation/pages/pick_expert_page.dart';
import '../../../community/presentation/pages/community_page.dart';
import '../../../ranking/presentation/pages/ranking_page.dart';
import '../../../my/presentation/pages/my_page.dart';

/// 메인 탭 페이지 (하단 탭 네비게이션)
class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key, this.initialIndex = 0});

  /// 초기 선택 탭 인덱스
  final int initialIndex;

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          LiveScoreMainPage(showBottomNav: false),
          PickExpertPage(showBottomNav: false),
          CommunityPage(showBottomNav: false),
          RankingPage(showBottomNav: false),
          MyPage(showBottomNav: false),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  /// 하단 네비게이션
  Widget _buildBottomNavigation() {
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
              _buildNavItem(0, AppIcons.home, l10n.home),
              _buildNavItem(1, AppIcons.check, l10n.pickExpert),
              _buildNavItem(2, AppIcons.persons, l10n.community),
              _buildNavItem(3, AppIcons.trophy, l10n.ranking),
              _buildNavItem(4, AppIcons.person, l10n.my),
            ],
          ),
        ),
      ),
    );
  }

  /// 네비게이션 아이템
  Widget _buildNavItem(int index, String iconPath, String label) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
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
                  ? AppTextStyles.label1NormalBold.copyWith(
                      color: AppColors.primaryFigma,
                    )
                  : AppTextStyles.label1NormalMedium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
