import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_navigation_bar.dart';
import '../../../../shared/widgets/app_toggle.dart';
import '../../../../l10n/app_localizations.dart';

/// 프로토 메인 페이지
class ProtoMainPage extends StatefulWidget {
  const ProtoMainPage({super.key});

  @override
  State<ProtoMainPage> createState() => _ProtoMainPageState();
}

class _ProtoMainPageState extends State<ProtoMainPage> {
  // 탭 인덱스
  int _toggleIndex = 1; // LIVE / 프로토 (프로토 선택)
  final int _bottomNavIndex = 0; // 하단 네비게이션

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
                    // 배너
                    _buildBanner(),
                    const SizedBox(height: 8),
                    // LIVE / 프로토 토글
                    _buildToggle(),
                    const SizedBox(height: 16),
                    // 프로모션 카드들
                    _buildPromotionCards(),
                    const SizedBox(height: 16),
                    // 경기 카드
                    _buildMatchSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          if (index == _bottomNavIndex) return;
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/main');
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed('/main/pick-expert');
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed('/main/community');
              break;
            case 3:
              Navigator.of(context).pushReplacementNamed('/main/ranking');
              break;
            case 4:
              Navigator.of(context).pushReplacementNamed('/main/my');
              break;
          }
        },
      ),
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
            AppLocalizations.of(context)!.appTitle,
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppToggle(
        labels: [l10n.live, l10n.proto],
        selectedIndex: _toggleIndex,
        onChanged: (index) {
          setState(() {
            _toggleIndex = index;
          });
          // LIVE 선택 시 라이브 스코어 메인 페이지로 이동
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/main');
          }
        },
        size: AppToggleSize.large,
        colorType: AppToggleColorType.active,
      ),
    );
  }

  /// 프로모션 카드들
  Widget _buildPromotionCards() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 복권형 스포츠 배팅
          _buildPromotionCard(
            title: l10n.easyToto,
            subtitle: l10n.easyToto,
            description: l10n.easyTotoDesc,
            gradientColors: [
              const Color(0xFF6366F1),
              const Color(0xFF8B5CF6),
            ],
          ),
          const SizedBox(height: 12),
          // 실력형 스포츠 복권
          _buildPromotionCard(
            title: l10n.protoMatch,
            subtitle: l10n.protoMatch,
            description: l10n.protoMatchDesc,
            gradientColors: [
              const Color(0xFF3B82F6),
              const Color(0xFF06B6D4),
            ],
          ),
          const SizedBox(height: 12),
          // 스포츠 베팅
          _buildPromotionCard(
            title: l10n.sportsToto,
            subtitle: l10n.sportsToto,
            description: l10n.sportsTotoDesc,
            gradientColors: [
              const Color(0xFF10B981),
              const Color(0xFF34D399),
            ],
          ),
        ],
      ),
    );
  }

  /// 프로모션 카드
  Widget _buildPromotionCard({
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

  /// 경기 섹션
  Widget _buildMatchSection() {
    final l10n = AppLocalizations.of(context)!;
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
            leagueName: l10n.leagueName,
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
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryFigma,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  l10n.pick,
                  style: AppTextStyles.caption2Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              );
            },
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          l10n.adminNotice,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ),
    );
  }

  /// 경기 카드
  Widget _buildMatchCard() {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/live-match-detail');
      },
      child: Row(
        children: [
          // 홈팀
          Expanded(
            child: _buildTeamInfo(
              teamName: l10n.teamName,
              ranking: l10n.rankingTab,
            ),
          ),
          // 스코어
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'NN:NN',
              style: AppTextStyles.h3Bold.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
          // 원정팀
          Expanded(
            child: _buildTeamInfo(
              teamName: l10n.teamName,
              ranking: l10n.rankingTab,
            ),
          ),
        ],
      ),
    );
  }

  /// 팀 정보
  Widget _buildTeamInfo({
    required String teamName,
    required String ranking,
  }) {
    return Column(
      children: [
        // 팀 로고 (플레이스홀더)
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.containerNormal,
            shape: BoxShape.circle,
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
            color: AppColors.labelNeutral,
          ),
        ),
      ],
    );
  }

  /// 배당률 테이블
  Widget _buildOddsTable() {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/match-full-mode');
      },
      child: Column(
        children: [
          // 국내
          _buildOddsRow(
            label: l10n.domestic,
            homeOdds: 'N.NN',
            drawOdds: '-',
            awayOdds: 'N.NN',
            homeUp: true,
            awayUp: false,
          ),
          const SizedBox(height: 4),
          // 해외
          _buildOddsRow(
            label: l10n.overseas,
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
        // 배당률
        Text(
          odds,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ],
    );
  }
}
