import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_navigation_bar.dart';
import '../../../../shared/widgets/app_toggle.dart';
import '../../../../shared/widgets/app_chip.dart';

/// 라이브 스코어 메인 페이지 (홈 탭)
class LiveScoreMainPage extends StatefulWidget {
  const LiveScoreMainPage({
    super.key,
    this.showBanner = true,
    this.showBottomNav = true,
  });

  /// 배너 표시 여부
  final bool showBanner;

  /// 하단 네비게이션 표시 여부
  final bool showBottomNav;

  @override
  State<LiveScoreMainPage> createState() => _LiveScoreMainPageState();
}

class _LiveScoreMainPageState extends State<LiveScoreMainPage> {
  // 탭 인덱스
  int _toggleIndex = 0; // LIVE / 프로토
  int _sportCategoryIndex = 2; // 전체, e스포츠, 축구, 야구, 농구...
  int _subCategoryIndex = 1; // 전체, 카테고리1, 카테고리2...
  int _bottomNavIndex = 0; // 하단 네비게이션

  // 스포츠 카테고리 목록
  final List<String> _sportCategories = ['전체', 'e스포츠', '축구', '야구', '농구', '배구', '하키', '테니스'];

  // 서브 카테고리 목록
  final List<String> _subCategories = ['전체', '카테고리1', '카테고리2', '카테고리3', '카테고리4'];

  // 배너 페이지
  final int _bannerPage = 0;
  final int _totalBannerPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 스크롤 가능한 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 배너 (옵션)
                    if (widget.showBanner) ...[
                      _buildBanner(),
                      const SizedBox(height: 8),
                    ],
                    // LIVE / 프로토 토글
                    _buildToggle(),
                    const SizedBox(height: 8),
                    // 토글에 따라 LIVE 또는 프로토 콘텐츠 표시
                    if (_toggleIndex == 0) ...[
                      // LIVE 콘텐츠
                      // 스포츠 카테고리 탭
                      _buildSportCategoryTabs(),
                      const SizedBox(height: 8),
                      // 서브 카테고리 칩
                      _buildSubCategoryChips(),
                      const SizedBox(height: 8),
                      // 날짜 네비게이션
                      _buildDateNavigation(),
                      const SizedBox(height: 8),
                      // 경기 리스트
                      _buildMatchList(),
                    ] else ...[
                      // 프로토 콘텐츠
                      const SizedBox(height: 8),
                      // 프로모션 카드들
                      _buildProtoPromotionCards(),
                      const SizedBox(height: 16),
                      // 경기 섹션
                      _buildProtoMatchSection(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNav
          ? AppNavigationBar(
              currentIndex: _bottomNavIndex,
              onTap: (index) {
                if (index == _bottomNavIndex) return;
                Navigator.of(context).pushReplacementNamed('/main');
              },
            )
          : null,
    );
  }

  /// 헤더 (로고 + 타이틀 + 알림 아이콘)
  Widget _buildHeader() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 로고
          _buildLogo(),
          const SizedBox(width: 8),
          // 타이틀
          Text(
            'リアルタイムスコア',
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.primaryFigma,
            ),
          ),
          const Spacer(),
          // 알림 아이콘
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/alarm-list');
            },
            child: SvgPicture.asset(
              AppIcons.bell,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.labelNormal,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 로고 위젯
  Widget _buildLogo() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.primaryFigma,
          width: 1.5,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'REAL',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 6,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            'TIME',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 6,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 1),
          Text(
            'score',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 5,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryFigma,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  /// 배너 섹션
  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.labelNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // 배너 컨텐츠 (PageView로 확장 가능)
          Container(),
          // 페이지 인디케이터
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_bannerPage + 1}/$_totalBannerPages',
                style: AppTextStyles.caption2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// LIVE / 프로토 토글
  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppToggle(
        labels: const ['LIVE', '프로토'],
        selectedIndex: _toggleIndex,
        onChanged: (index) {
          setState(() {
            _toggleIndex = index;
          });
        },
        size: AppToggleSize.large,
        colorType: AppToggleColorType.active,
      ),
    );
  }

  /// 스포츠 카테고리 탭 (수평 스크롤)
  Widget _buildSportCategoryTabs() {
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _sportCategories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _sportCategoryIndex;
          return Padding(
            padding: EdgeInsets.only(right: index < _sportCategories.length - 1 ? 0 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _sportCategoryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.labelNormal : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    _sportCategories[index],
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.labelNormal)
                        : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelAlternative),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 서브 카테고리 칩 (수평 스크롤)
  Widget _buildSubCategoryChips() {
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _subCategories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _subCategoryIndex;
          return Padding(
            padding: EdgeInsets.only(right: index < _subCategories.length - 1 ? 4 : 0),
            child: Chips(
              label: _subCategories[index],
              status: isSelected ? ChipStatus.active : ChipStatus.defaultStatus,
              onTap: () {
                setState(() {
                  _subCategoryIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  /// 날짜 네비게이션
  Widget _buildDateNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 이전 버튼
          _buildDateNavButton(
            icon: AppIcons.chevronLeft,
            onTap: () {
              // TODO: 이전 날짜로 이동
            },
          ),
          const SizedBox(width: 2),
          // 이전 날짜
          Text(
            'NN',
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(width: 24),
          // TODAY + 캘린더
          Row(
            children: [
              Text(
                'TODAY',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                AppIcons.calendar,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.labelNormal,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // 다음 날짜
          Text(
            'NN',
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(width: 2),
          // 다음 버튼
          _buildDateNavButton(
            icon: AppIcons.chevronRight,
            onTap: () {
              // TODO: 다음 날짜로 이동
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.containerNormal,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.labelNeutral,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  /// 경기 리스트
  Widget _buildMatchList() {
    return Column(
      children: [
        // 첫 번째 리그 경기
        _buildMatchSection(
          leagueName: '리그명',
          hasPick: true,
          temperature: '12°C',
        ),
        const SizedBox(height: 8),
        // 두 번째 리그 경기
        _buildMatchSection(
          leagueName: '리그명',
          hasPick: true,
          temperature: '12°C',
        ),
      ],
    );
  }

  /// 경기 섹션 (리그 헤더 + 경기 카드)
  Widget _buildMatchSection({
    required String leagueName,
    required bool hasPick,
    required String temperature,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 리그 헤더
          _buildLeagueHeader(
            leagueName: leagueName,
            hasPick: hasPick,
            temperature: temperature,
          ),
          const SizedBox(height: 8),
          // 운영자 등록글 노출
          _buildAdminNotice(),
          const SizedBox(height: 12),
          // 경기 카드
          _buildMatchCard(),
          const SizedBox(height: 8),
          // 배당률 테이블
          _buildOddsTable(),
        ],
      ),
    );
  }

  /// 리그 헤더
  Widget _buildLeagueHeader({
    required String leagueName,
    required bool hasPick,
    required String temperature,
  }) {
    return Row(
      children: [
        // 리그명
        Text(
          leagueName,
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(width: 8),
        // 픽 뱃지
        if (hasPick)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.negative,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '픽',
              style: AppTextStyles.caption2Bold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        const SizedBox(width: 8),
        // 날씨 아이콘 + 온도
        SvgPicture.asset(
          AppIcons.sun,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.yellow,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          temperature,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        const Spacer(),
        // 알림 아이콘
        GestureDetector(
          onTap: () {
            // TODO: 리그 알림 설정
          },
          child: SvgPicture.asset(
            AppIcons.bell,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.labelAlternative,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  /// 운영자 등록글 노출 배너
  Widget _buildAdminNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '운영자 등록글 노출',
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ),
    );
  }

  /// 경기 상태 enum
  /// [scheduled] 경기 전, [live] 경기 중, [finished] 경기 후

  /// 경기 카드
  Widget _buildMatchCard({
    String matchStatus = 'live', // 'scheduled', 'live', 'finished'
    int homeScore = 0,
    int awayScore = 0,
  }) {
    // 경기 상태에 따른 색상 결정
    Color statusColor;
    Color scoreColor;
    String statusText;

    switch (matchStatus) {
      case 'scheduled':
        statusColor = AppColors.labelNeutral;
        scoreColor = AppColors.labelNeutral;
        statusText = '예정';
        break;
      case 'live':
        statusColor = AppColors.negative;
        scoreColor = AppColors.negative;
        statusText = 'LIVE';
        break;
      case 'finished':
      default:
        statusColor = AppColors.labelAlternative;
        scoreColor = AppColors.labelNormal;
        statusText = '종료';
        break;
    }

    // 이기고 있는 팀 판별
    bool isHomeWinning = homeScore > awayScore;
    bool isAwayWinning = awayScore > homeScore;
    bool isDraw = homeScore == awayScore;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/live-match-detail');
      },
      child: Column(
        children: [
          // 경기 상태 표시
          if (matchStatus == 'live')
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.negative,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                statusText,
                style: AppTextStyles.caption2Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          Row(
            children: [
              // 홈팀
              Expanded(
                child: _buildTeamInfo(
                  teamName: '팀명',
                  ranking: '순위',
                  isHome: true,
                  isWinning: matchStatus == 'live' && isHomeWinning,
                  isLosing: matchStatus == 'finished' && !isHomeWinning && !isDraw,
                ),
              ),
              // 스코어
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '$homeScore',
                      style: AppTextStyles.h3Bold.copyWith(
                        color: matchStatus == 'live' && isHomeWinning
                            ? AppColors.negative
                            : scoreColor,
                      ),
                    ),
                    Text(
                      ':',
                      style: AppTextStyles.h3Bold.copyWith(
                        color: scoreColor,
                      ),
                    ),
                    Text(
                      '$awayScore',
                      style: AppTextStyles.h3Bold.copyWith(
                        color: matchStatus == 'live' && isAwayWinning
                            ? AppColors.negative
                            : scoreColor,
                      ),
                    ),
                  ],
                ),
              ),
              // 원정팀
              Expanded(
                child: _buildTeamInfo(
                  teamName: '팀명',
                  ranking: '순위',
                  isHome: false,
                  isWinning: matchStatus == 'live' && isAwayWinning,
                  isLosing: matchStatus == 'finished' && !isAwayWinning && !isDraw,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 팀 정보
  Widget _buildTeamInfo({
    required String teamName,
    required String ranking,
    required bool isHome,
    bool isWinning = false,
    bool isLosing = false,
  }) {
    // 이기고 있으면 빨간색, 지고 있으면 투명 처리
    final Color teamNameColor = isWinning
        ? AppColors.negative
        : isLosing
            ? AppColors.labelAlternative.withValues(alpha: 0.5)
            : AppColors.labelNeutral;

    return Opacity(
      opacity: isLosing ? 0.5 : 1.0,
      child: Column(
        children: [
          // 팀 로고 (플레이스홀더)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              shape: BoxShape.circle,
              border: isWinning
                  ? Border.all(color: AppColors.negative, width: 2)
                  : null,
            ),
            child: const Center(
              child: Icon(
                Icons.sports_soccer,
                size: 24,
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // 팀명 (순위)
          Text(
            '$teamName ($ranking)',
            style: AppTextStyles.caption1Medium.copyWith(
              color: teamNameColor,
              fontWeight: isWinning ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 배당률 테이블
  Widget _buildOddsTable() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/match-full-mode');
      },
      child: Column(
        children: [
          // 국내
          _buildOddsRow(
            label: '국내',
            homeOdds: 'N.NN',
            drawOdds: '-',
            awayOdds: 'N.NN',
            homeUp: true,
            awayUp: false,
          ),
          const SizedBox(height: 4),
          // 해외
          _buildOddsRow(
            label: '해외',
            homeOdds: 'N.NN',
            drawOdds: '-',
            awayOdds: 'N.NN',
            homeUp: true,
            awayUp: false,
          ),
        ],
      ),
    );
  }

  /// 배당률 행
  Widget _buildOddsRow({
    required String label,
    required String homeOdds,
    required String drawOdds,
    required String awayOdds,
    required bool homeUp,
    required bool awayUp,
  }) {
    return Row(
      children: [
        // 라벨
        SizedBox(
          width: 32,
          child: Text(
            label,
            style: AppTextStyles.caption2Medium.copyWith(
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 홈 배당
        _buildOddsCell(odds: homeOdds, isUp: homeUp),
        const Spacer(),
        // 무승부 배당
        Text(
          drawOdds,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelAlternative,
          ),
        ),
        const Spacer(),
        // 원정 배당
        _buildOddsCell(odds: awayOdds, isUp: awayUp),
      ],
    );
  }

  /// 배당률 셀
  /// [isUp] true: 역배(빨간색), false: 정배(볼드)
  Widget _buildOddsCell({
    required String odds,
    required bool isUp,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 증감 아이콘
        Icon(
          isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 16,
          color: isUp ? AppColors.negative : AppColors.positive,
        ),
        // 배당률 - 역배는 빨간색, 정배는 볼드
        Text(
          odds,
          style: isUp
              ? AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.negative,
                )
              : AppTextStyles.caption1Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
        ),
      ],
    );
  }

  // ============================================
  // 프로토 콘텐츠 섹션
  // ============================================

  /// 프로토 프로모션 카드들
  Widget _buildProtoPromotionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 복권형 스포츠 배팅
          _buildProtoPromotionCard(
            title: '복권형 스포츠 배팅',
            subtitle: '이지토토',
            description: '소액으로 즐기는\n스포츠 복권',
            gradientColors: [
              const Color(0xFF6366F1),
              const Color(0xFF8B5CF6),
            ],
          ),
          const SizedBox(height: 12),
          // 실력형 스포츠 복권
          _buildProtoPromotionCard(
            title: '실력형 스포츠 복권',
            subtitle: '프로토 승부식',
            description: '나만의 경기 분석으로\n배당률 적중',
            gradientColors: [
              const Color(0xFF3B82F6),
              const Color(0xFF06B6D4),
            ],
          ),
          const SizedBox(height: 12),
          // 스포츠 베팅
          _buildProtoPromotionCard(
            title: '스포츠 베팅',
            subtitle: '스포츠토토',
            description: '간단한 선택으로\n스포츠 즐기기',
            gradientColors: [
              const Color(0xFF10B981),
              const Color(0xFF34D399),
            ],
          ),
        ],
      ),
    );
  }

  /// 프로토 프로모션 카드
  Widget _buildProtoPromotionCard({
    required String title,
    required String subtitle,
    required String description,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 서브타이틀
                Text(
                  subtitle,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 4),
                // 타이틀
                Text(
                  title,
                  style: AppTextStyles.h4Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // 설명
                Text(
                  description,
                  style: AppTextStyles.body2NormalMedium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          // 아이콘 영역
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.sports_soccer,
                size: 32,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 프로토 경기 섹션
  Widget _buildProtoMatchSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 리그 헤더
          _buildLeagueHeader(
            leagueName: '리그명',
            hasPick: true,
            temperature: '12°C',
          ),
          const SizedBox(height: 8),
          // 운영자 등록글 노출
          _buildAdminNotice(),
          const SizedBox(height: 12),
          // 경기 카드
          _buildMatchCard(),
          const SizedBox(height: 8),
          // 배당률 테이블
          _buildOddsTable(),
        ],
      ),
    );
  }
}
