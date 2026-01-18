import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';

/// 랭킹 타입
enum RankingType { notification, prediction }

/// 랭킹 기간
enum RankingPeriod { today, all }

/// 랭킹 페이지
class RankingPage extends StatefulWidget {
  final RankingType initialType;
  final RankingPeriod initialPeriod;

  /// 하단 네비게이션 표시 여부
  final bool showBottomNav;

  const RankingPage({
    super.key,
    this.initialType = RankingType.notification,
    this.initialPeriod = RankingPeriod.today,
    this.showBottomNav = true,
  });

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late RankingType _selectedType;
  late RankingPeriod _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    _selectedPeriod = widget.initialPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 토글 탭
            _buildToggleTabs(),
            const SizedBox(height: 8),
            // 기간 탭
            _buildPeriodTabs(),
            // 랭킹 리스트
            Expanded(
              child: _buildRankingList(),
            ),
          ],
        ),
      ),
      // 하단 네비게이션
      bottomNavigationBar: widget.showBottomNav ? _buildBottomNavigation() : null,
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
            '랭킹',
            style: AppTextStyles.h3Bold.copyWith(
              color: AppColors.labelStrong,
            ),
          ),
        ],
      ),
    );
  }

  /// 토글 탭 (알림 랭킹 / 예측게임 랭킹)
  Widget _buildToggleTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 알림 랭킹
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = RankingType.notification;
                });
              },
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: _selectedType == RankingType.notification
                      ? AppColors.primaryFigma
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '알림 랭킹',
                    style: _selectedType == RankingType.notification
                        ? AppTextStyles.body1NormalBold.copyWith(
                            color: AppColors.white,
                          )
                        : AppTextStyles.body1NormalMedium.copyWith(
                            color: AppColors.labelNeutral,
                          ),
                  ),
                ),
              ),
            ),
          ),
          // 예측게임 랭킹
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = RankingType.prediction;
                });
              },
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: _selectedType == RankingType.prediction
                      ? AppColors.primaryFigma
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '예측게임 랭킹',
                    style: _selectedType == RankingType.prediction
                        ? AppTextStyles.body1NormalBold.copyWith(
                            color: AppColors.white,
                          )
                        : AppTextStyles.body1NormalMedium.copyWith(
                            color: AppColors.labelNeutral,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 기간 탭 (투데이 / 전체)
  Widget _buildPeriodTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          // 투데이
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPeriod = RankingPeriod.today;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedPeriod == RankingPeriod.today
                        ? AppColors.primaryFigma
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '투데이',
                style: _selectedPeriod == RankingPeriod.today
                    ? AppTextStyles.body1NormalBold.copyWith(
                        color: AppColors.primaryFigma,
                      )
                    : AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
              ),
            ),
          ),
          // 전체
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPeriod = RankingPeriod.all;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedPeriod == RankingPeriod.all
                        ? AppColors.primaryFigma
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '전체',
                style: _selectedPeriod == RankingPeriod.all
                    ? AppTextStyles.body1NormalBold.copyWith(
                        color: AppColors.primaryFigma,
                      )
                    : AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 랭킹 리스트
  Widget _buildRankingList() {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return _buildRankItem(index + 1);
      },
    );
  }

  /// 랭킹 아이템
  Widget _buildRankItem(int rank) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/user-profile');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderNormal),
          ),
        ),
        child: Row(
        children: [
          // 순위 뱃지
          _buildRankBadge(rank),
          const SizedBox(width: 16),
          // 프로필 이미지
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerNormal,
            ),
            child: const Icon(
              Icons.person,
              size: 24,
              color: AppColors.labelAlternative,
            ),
          ),
          const SizedBox(width: 16),
          // 사용자 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임 + 벨 아이콘 + 수
                Row(
                  children: [
                    Text(
                      '닉네임',
                      style: AppTextStyles.body1NormalBold.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      AppIcons.bell,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.labelNeutral,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NNN',
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 예측 성공
                Row(
                  children: [
                    Text(
                      '예측성공',
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NN',
                      style: AppTextStyles.label1Bold.copyWith(
                        color: AppColors.negative,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 알림 아이콘
          SvgPicture.asset(
            AppIcons.bell,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.labelNeutral,
              BlendMode.srcIn,
            ),
          ),
        ],
        ),
      ),
    );
  }

  /// 순위 뱃지
  Widget _buildRankBadge(int rank) {
    if (rank <= 3) {
      // 메달 (금, 은, 동)
      return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: _getMedalWidget(rank),
      );
    } else {
      // 숫자 뱃지
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryBackground,
        ),
        alignment: Alignment.center,
        child: Text(
          '$rank',
          style: AppTextStyles.h3Bold.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      );
    }
  }

  /// 메달 위젯
  Widget _getMedalWidget(int rank) {
    final colors = [
      [const Color(0xFFFFD700), const Color(0xFFFFA500)], // 금
      [const Color(0xFFC0C0C0), const Color(0xFF808080)], // 은
      [const Color(0xFFCD7F32), const Color(0xFF8B4513)], // 동
    ];

    final medalColors = colors[rank - 1];

    return Stack(
      alignment: Alignment.center,
      children: [
        // 메달 원
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: medalColors,
            ),
            boxShadow: [
              BoxShadow(
                color: medalColors[0].withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        // 순위 번호
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.3),
          ),
          alignment: Alignment.center,
          child: Text(
            '$rank',
            style: AppTextStyles.label1Bold.copyWith(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  /// 하단 네비게이션
  Widget _buildBottomNavigation() {
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
              _buildNavItem(AppIcons.home, '홈', false),
              _buildNavItem(AppIcons.check, '픽전문가', false),
              _buildNavItem(AppIcons.persons, '커뮤니티', false),
              _buildNavItem(AppIcons.trophy, '랭킹', true),
              _buildNavItem(AppIcons.person, 'MY', false),
            ],
          ),
        ),
      ),
    );
  }

  /// 네비게이션 아이템
  Widget _buildNavItem(String iconPath, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        // 네비게이션 처리
        if (label == '홈') {
          Navigator.pushReplacementNamed(context, '/main');
        } else if (label == '픽전문가') {
          Navigator.pushReplacementNamed(context, '/pick-expert');
        } else if (label == '커뮤니티') {
          Navigator.pushReplacementNamed(context, '/community');
        } else if (label == 'MY') {
          Navigator.pushReplacementNamed(context, '/my-page');
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
