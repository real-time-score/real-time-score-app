import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';

/// 경기 배당률 모드 타입
enum OddsMode {
  /// 승무패
  winDrawLose,

  /// 승1패
  win1Lose,

  /// 핸디캡
  handicap,

  /// 언더오버
  underOver,
}

/// 경기 리스트 풀 모드 페이지
class MatchFullModePage extends StatefulWidget {
  const MatchFullModePage({
    super.key,
    this.initialMode = OddsMode.winDrawLose,
  });

  /// 초기 선택된 모드
  final OddsMode initialMode;

  @override
  State<MatchFullModePage> createState() => _MatchFullModePageState();
}

class _MatchFullModePageState extends State<MatchFullModePage> {
  late OddsMode _selectedMode;

  final List<String> _modeLabels = ['승무패', '승1패', '핸디캡', '언더오버'];

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더 (닫기 버튼)
            _buildHeader(),
            // 4단 토글
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildModeToggle(),
            ),
            const SizedBox(height: 16),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    // 경기 정보
                    _buildMatchInfo(),
                    const SizedBox(height: 40),
                    // 국내 배당률
                    _buildOddsSection(
                      title: '국내',
                      odds: _buildDomesticOdds(),
                    ),
                    const SizedBox(height: 24),
                    // 해외 배당률
                    _buildOddsSection(
                      title: '해외',
                      odds: _buildOverseasOdds(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 용어설명 버튼 (좌측)
          Positioned(
            left: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed('/glossary'),
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.circleQuestion,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.labelNeutral,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 닫기 버튼 (우측)
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.close,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.labelNormal,
                        BlendMode.srcIn,
                      ),
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

  /// 4단 모드 토글
  Widget _buildModeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: OddsMode.values.asMap().entries.map((entry) {
          final index = entry.key;
          final mode = entry.value;
          final isSelected = mode == _selectedMode;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMode = mode;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _modeLabels[index],
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.white)
                        : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelNormal),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 경기 정보 (팀 + 시간)
  Widget _buildMatchInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 홈팀
        _buildTeamInfo(teamName: '팀명'),
        const SizedBox(width: 22),
        // 시간
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '20 : 00',
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ),
        const SizedBox(width: 22),
        // 원정팀
        _buildTeamInfo(teamName: '팀명'),
      ],
    );
  }

  /// 팀 정보
  Widget _buildTeamInfo({required String teamName}) {
    return Column(
      children: [
        // 팀 로고 (플레이스홀더)
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.containerNormal,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.sports_soccer,
              size: 32,
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 팀명
        Text(
          teamName,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 배당률 섹션 (국내/해외)
  Widget _buildOddsSection({
    required String title,
    required Widget odds,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 타이틀
        Text(
          title,
          style: AppTextStyles.h4Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        // 배당률 테이블
        odds,
      ],
    );
  }

  /// 국내 배당률 테이블
  Widget _buildDomesticOdds() {
    return Column(
      children: [
        // 헤더 행
        _buildOddsHeaderRow(),
        // 데이터 행 1 (변동 없음)
        _buildOddsDataRow(
          homeOdds: '-',
          homeChange: OddsChange.negative,
          drawOdds: '-',
          awayOdds: '-',
          awayChange: OddsChange.positive,
          changeTime: '(변동없음)',
        ),
        // 데이터 행 2 (요약)
        _buildOddsSummaryRow(
          homeOdds: 'N.NN',
          drawOdds: '-',
          awayOdds: 'N.NN',
          changeTime: '',
        ),
      ],
    );
  }

  /// 해외 배당률 테이블
  Widget _buildOverseasOdds() {
    return Column(
      children: [
        // 헤더 행
        _buildOddsHeaderRow(),
        // 데이터 행 1
        _buildOddsDataRow(
          homeOdds: 'N.NN',
          homeChange: OddsChange.up,
          drawOdds: '-',
          awayOdds: 'N.NN',
          awayChange: OddsChange.down,
          changeTime: '(변동없음)',
        ),
        // 데이터 행 2
        _buildOddsDataRow(
          homeOdds: 'N.NN',
          homeChange: OddsChange.up,
          drawOdds: '-',
          awayOdds: 'N.NN',
          awayChange: OddsChange.down,
          changeTime: '(변동없음)',
        ),
        // 요약 행
        _buildOddsSummaryRow(
          homeOdds: 'N.NN',
          drawOdds: '-',
          awayOdds: 'N.NN',
          changeTime: '초기',
        ),
      ],
    );
  }

  /// 배당률 헤더 행
  Widget _buildOddsHeaderRow() {
    final headers = _getHeaderLabels();
    return Row(
      children: headers.map((label) {
        return Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 모드에 따른 헤더 라벨 (모든 모드에서 동일)
  List<String> _getHeaderLabels() {
    return ['홈패', '무승부', '홈승', '변동시간'];
  }

  /// 배당률 데이터 행
  Widget _buildOddsDataRow({
    required String homeOdds,
    required OddsChange homeChange,
    required String drawOdds,
    required String awayOdds,
    required OddsChange awayChange,
    required String changeTime,
  }) {
    return Row(
      children: [
        // 홈 배당
        Expanded(
          child: _buildOddsCell(
            odds: homeOdds,
            change: homeChange,
          ),
        ),
        // 무승부/기준
        Expanded(
          child: _buildOddsCell(
            odds: drawOdds,
            change: OddsChange.none,
          ),
        ),
        // 원정 배당
        Expanded(
          child: _buildOddsCell(
            odds: awayOdds,
            change: awayChange,
          ),
        ),
        // 변동시간
        Expanded(
          child: _buildOddsCell(
            odds: changeTime,
            change: OddsChange.none,
          ),
        ),
      ],
    );
  }

  /// 배당률 요약 행 (하이라이트)
  Widget _buildOddsSummaryRow({
    required String homeOdds,
    required String drawOdds,
    required String awayOdds,
    required String changeTime,
  }) {
    return Row(
      children: [
        // 홈 배당
        Expanded(
          child: _buildSummaryCell(odds: homeOdds),
        ),
        // 무승부/기준
        Expanded(
          child: _buildSummaryCell(odds: drawOdds),
        ),
        // 원정 배당
        Expanded(
          child: _buildSummaryCell(odds: awayOdds),
        ),
        // 변동시간
        Expanded(
          child: _buildSummaryCell(odds: changeTime),
        ),
      ],
    );
  }

  /// 배당률 셀
  /// 역배(up): 빨간색 텍스트, 정배(down): 볼드 처리
  Widget _buildOddsCell({
    required String odds,
    required OddsChange change,
  }) {
    Color textColor = AppColors.labelNeutral;
    FontWeight fontWeight = FontWeight.w500;
    Widget? icon;

    if (change == OddsChange.up) {
      // 역배: 빨간색 + 화살표
      icon = const Icon(
        Icons.arrow_drop_up,
        size: 24,
        color: AppColors.negative,
      );
      textColor = AppColors.negative;
    } else if (change == OddsChange.down) {
      // 정배: 볼드 처리 + 화살표
      icon = const Icon(
        Icons.arrow_drop_down,
        size: 24,
        color: AppColors.positiveGreen,
      );
      fontWeight = FontWeight.bold;
      textColor = AppColors.labelNormal;
    } else if (change == OddsChange.negative) {
      textColor = AppColors.negative;
    } else if (change == OddsChange.positive) {
      textColor = AppColors.positiveGreen;
      fontWeight = FontWeight.bold;
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon,
            Text(
              odds,
              style: AppTextStyles.label1NormalMedium.copyWith(
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 요약 셀 (하이라이트 배경)
  Widget _buildSummaryCell({required String odds}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.containerSelected,
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Center(
        child: Text(
          odds,
          style: AppTextStyles.label1NormalMedium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ),
    );
  }
}

/// 배당률 변동 상태
enum OddsChange {
  /// 변동 없음
  none,

  /// 상승 (빨간색 화살표)
  up,

  /// 하락 (초록색 화살표)
  down,

  /// 빨간색 텍스트 (화살표 없음)
  negative,

  /// 초록색 텍스트 (화살표 없음)
  positive,
}
