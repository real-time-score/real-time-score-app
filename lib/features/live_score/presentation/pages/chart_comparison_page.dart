import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 차트 서브 탭 타입
enum ChartSubTab {
  /// 비교
  comparison,

  /// 기록
  record,

  /// 순위
  ranking,
}

/// 차트 비교 페이지
class ChartComparisonPage extends StatefulWidget {
  const ChartComparisonPage({
    super.key,
    this.initialSubTab = ChartSubTab.comparison,
  });

  /// 초기 서브 탭
  final ChartSubTab initialSubTab;

  @override
  State<ChartComparisonPage> createState() => _ChartComparisonPageState();
}

class _ChartComparisonPageState extends State<ChartComparisonPage> {
  int _selectedMainTabIndex = 1; // 차트 탭 선택
  late ChartSubTab _selectedSubTab;
  int _selectedYear = 2025; // 선택된 년도

  List<String> _getMainTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.liveTab, l10n.chart, l10n.lineup, l10n.predictionGame];
  }

  List<String> _getSubTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.comparison, l10n.record, l10n.rankingRecord];
  }
  final List<int> _availableYears = [2025, 2024, 2023, 2022, 2021];

  @override
  void initState() {
    super.initState();
    _selectedSubTab = widget.initialSubTab;
  }

  /// 메인 탭 네비게이션 처리
  void _navigateToMainTab(int index) {
    switch (index) {
      case 0: // 라이브
        Navigator.of(context).pushReplacementNamed('/live-match-detail');
        break;
      case 1: // 차트 (현재 페이지)
        setState(() {
          _selectedMainTabIndex = index;
        });
        break;
      case 2: // 라인업
        Navigator.of(context).pushReplacementNamed('/lineup');
        break;
      case 3: // 예측게임
        Navigator.of(context).pushReplacementNamed('/prediction-game');
        break;
    }
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
            // 메인 탭 토글
            _buildMainTabToggle(),
            const SizedBox(height: 8),
            // 서브 탭
            _buildSubTabToggle(),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return AppHeader(
      showBackButton: true,
      onBackPressed: () => Navigator.of(context).pop(),
      rightButtons: [
        AppHeaderAction(
          type: AppHeaderButtonType.sparkle,
          onPressed: () {
            // TODO: AI
          },
        ),
      ],
    );
  }

  /// 메인 5단 탭 토글
  Widget _buildMainTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: _getMainTabs(context).asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = index == _selectedMainTabIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToMainTab(index);
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
                    label,
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

  /// 서브 3단 탭 토글
  Widget _buildSubTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: ChartSubTab.values.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = tab == _selectedSubTab;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSubTab = tab;
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primaryFigma : AppColors.borderNormal,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    _getSubTabs(context)[index],
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.primaryFigma)
                        : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelNeutral),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 컨텐츠
  Widget _buildContent() {
    switch (_selectedSubTab) {
      case ChartSubTab.comparison:
        return _buildComparisonContent();
      case ChartSubTab.record:
        return _buildRecordContent();
      case ChartSubTab.ranking:
        return _buildRankingContent();
    }
  }

  /// 비교 탭 컨텐츠
  Widget _buildComparisonContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 팀 VS 팀 헤더
          _buildTeamVsHeader(),
          const SizedBox(height: 16),
          // 기본 통계 비교 테이블
          _buildBasicStatsTable(),
          const SizedBox(height: 24),
          // 공격력 비교
          Builder(builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildSectionTitle(l10n.offensiveComparison);
          }),
          const SizedBox(height: 8),
          _buildAttackStatsTable(),
          const SizedBox(height: 24),
          // 수비력 비교
          Builder(builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildSectionTitle(l10n.defensiveComparison);
          }),
          const SizedBox(height: 8),
          _buildDefenseStatsTable(),
          const SizedBox(height: 24),
          // 최근 맞대결 전적
          Builder(builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildSectionTitle(l10n.recentHeadToHead);
          }),
          const SizedBox(height: 8),
          _buildRecentMatchups(),
          const SizedBox(height: 24),
          // 최근 양팀 전적
          Builder(builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildSectionTitle(l10n.recentBothTeamRecord);
          }),
          const SizedBox(height: 8),
          _buildRecentTeamRecords(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 기록 탭 컨텐츠
  Widget _buildRecordContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 스코어 테이블 (전반/후반/연장/승부)
          _buildScoreByPeriodTable(),
          const SizedBox(height: 24),
          // 팀 VS 팀 헤더
          _buildTeamVsHeaderWithPlayers(),
          const SizedBox(height: 16),
          // 경기 기록 비교
          _buildMatchRecordTable(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 순위 탭 컨텐츠
  Widget _buildRankingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // 국가 필터
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildFilterChips(
              items: List.generate(6, (_) => l10n.countryName),
              selectedIndex: 0,
            );
          },
        ),
        const SizedBox(height: 8),
        // 리그 필터
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return _buildFilterChips(
              items: List.generate(6, (_) => l10n.leagueName),
              selectedIndex: 0,
            );
          },
        ),
        const SizedBox(height: 16),
        // 정규시즌 헤더
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildSeasonHeader(),
        ),
        const SizedBox(height: 8),
        // 순위 테이블
        _buildRankingTable(),
      ],
    );
  }

  /// 필터 칩 (가로 스크롤)
  Widget _buildFilterChips({
    required List<String> items,
    required int selectedIndex,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = index == selectedIndex;

          return Padding(
            padding: EdgeInsets.only(right: index < items.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () {
                // TODO: 필터 선택
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryFigma : AppColors.borderNormal,
                  ),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: isSelected ? AppColors.white : AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 시즌 헤더
  Widget _buildSeasonHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.regularSeason,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        GestureDetector(
          onTap: _showYearSelectionBottomSheet,
          child: Row(
            children: [
              Text(
                '$_selectedYear',
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: AppColors.labelNeutral,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 년도 선택 바텀시트 표시
  void _showYearSelectionBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.year,
                      style: AppTextStyles.body1NormalBold.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: AppColors.labelNormal,
                      ),
                    ),
                  ],
                ),
              ),
              // 년도 리스트
              ..._availableYears.map((year) {
                final isSelected = year == _selectedYear;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedYear = year;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.containerSelected : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$year',
                          style: AppTextStyles.body1NormalMedium.copyWith(
                            color: AppColors.labelNormal,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryFigma,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// 순위 테이블
  Widget _buildRankingTable() {
    return Column(
      children: [
        // 테이블 헤더
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderNormal),
            ),
          ),
          child: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      l10n.rankingTab,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.teamName,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.matches,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.points,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.win,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.draw,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // 테이블 행들
        ...List.generate(11, (index) {
          return _buildRankingRow(
            rank: index + 1,
            teamName: 'NNN',
            games: 'NNN',
            points: 'NNN',
            wins: 'NNN',
            draws: 'NNN',
          );
        }),
      ],
    );
  }

  /// 순위 테이블 행
  Widget _buildRankingRow({
    required int rank,
    required String teamName,
    required String games,
    required String points,
    required String wins,
    required String draws,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              teamName,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              games,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              points,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              wins,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              draws,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 스코어 테이블 (전반/후반/연장/승부)
  Widget _buildScoreByPeriodTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 헤더 행
          Container(
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return Row(
                  children: [
                    SizedBox(width: 80, child: Center(child: Text(l10n.teamName, style: AppTextStyles.caption1Medium.copyWith(color: AppColors.labelNeutral)))),
                    Expanded(
                      child: _buildPeriodHeaderCell(l10n.firstHalf),
                    ),
                    Expanded(
                      child: _buildPeriodHeaderCell(l10n.secondHalf),
                    ),
                    Expanded(
                      child: _buildPeriodHeaderCell(l10n.extraTime),
                    ),
                    Expanded(
                      child: _buildPeriodHeaderCell(l10n.shootout),
                    ),
                  ],
                );
              },
            ),
          ),
          // 홈팀 행
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return _buildScoreRow(teamName: l10n.teamName, scores: ['N', 'N', 'N', 'N']);
            },
          ),
          // 원정팀 행
          Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return _buildScoreRow(teamName: l10n.teamName, scores: ['N', 'N', 'N', 'N'], isLast: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodHeaderCell(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRow({
    required String teamName,
    required List<String> scores,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  teamName,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ),
            ),
          ),
          ...scores.map((score) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      score,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  /// 팀 VS 팀 헤더 (선수 아이콘 포함)
  Widget _buildTeamVsHeaderWithPlayers() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // 팀 VS 팀
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeamHeaderItem(teamName: l10n.teamName, flagEmoji: '🇹🇱'),
            Text(
              'VS',
              style: AppTextStyles.body1NormalBold.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
            _buildTeamHeaderItem(teamName: l10n.teamName, flagEmoji: '🇺🇦'),
          ],
        ),
        const SizedBox(height: 16),
        // 선수 아이콘 행
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('🤾', style: TextStyle(fontSize: 24)),
                Text(
                  l10n.players,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
                const Text('🤾', style: TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ],
    );
  }

  /// 경기 기록 비교 테이블
  Widget _buildMatchRecordTable() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildRecordRow(homeValue: 'NN', label: l10n.scoring, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.shooting, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.shotsOnTarget, awayValue: 'NN', isHighlighted: true),
        _buildRecordRow(homeValue: 'NN', label: l10n.saves, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.offside, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.foul, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.yellowCard, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.redCard, awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: l10n.cornerKick, awayValue: 'NN', isHighlighted: true),
        _buildRecordRow(homeValue: 'NN', label: l10n.freeKick, awayValue: 'NN'),
      ],
    );
  }

  Widget _buildRecordRow({
    required String homeValue,
    required String label,
    required String awayValue,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.containerNormal : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              homeValue,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: isHighlighted ? AppColors.primaryFigma : AppColors.labelAlternative,
              ),
            ),
          ),
          Expanded(
            child: Text(
              awayValue,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 팀 VS 팀 헤더
  Widget _buildTeamVsHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 홈팀
        _buildTeamHeaderItem(teamName: l10n.teamName, flagEmoji: '🇺🇦'),
        // VS
        Text(
          'VS',
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        // 원정팀
        _buildTeamHeaderItem(teamName: l10n.teamName, flagEmoji: '🇪🇨'),
      ],
    );
  }

  Widget _buildTeamHeaderItem({required String teamName, required String flagEmoji}) {
    return Column(
      children: [
        // 팀 로고 + 국기
        Stack(
          clipBehavior: Clip.none,
          children: [
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
            Positioned(
              right: -4,
              bottom: -4,
              child: Text(
                flagEmoji,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          teamName,
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 기본 통계 비교 테이블
  Widget _buildBasicStatsTable() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildComparisonRow(homeValue: l10n.leagueName, label: l10n.afterChampionship, awayValue: l10n.leagueName),
        _buildComparisonRow(homeValue: 'N위', label: l10n.rankingTab, awayValue: 'N위'),
        _buildComparisonRow(homeValue: 'N승N패', label: l10n.totalRecord, awayValue: 'N승N패'),
        _buildRecentMatchesRow(),
        _buildComparisonRow(homeValue: 'N승 N패', label: l10n.vsRecord, awayValue: 'N승 N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: l10n.winRate, awayValue: 'N승N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: l10n.homeAwayWinRate, awayValue: 'N승N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: l10n.ratingWinRate, awayValue: 'N승N패'),
      ],
    );
  }

  /// 최근 5경기 행 (승/무/패 컬러 적용)
  Widget _buildRecentMatchesRow() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.containerNormal,
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          // 홈팀 최근 5경기
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatchResultBadge(l10n.win, AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.lose, AppColors.positive),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.win, AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.draw, AppColors.labelNeutral),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.win, AppColors.negative),
              ],
            ),
          ),
          // 라벨
          SizedBox(
            width: 80,
            child: Text(
              l10n.recentMatches,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          // 원정팀 최근 5경기
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatchResultBadge(l10n.lose, AppColors.positive),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.win, AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.draw, AppColors.labelNeutral),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.win, AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge(l10n.lose, AppColors.positive),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 경기 결과 뱃지 (승/무/패)
  Widget _buildMatchResultBadge(String result, Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          result,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  /// 공격력 비교 테이블
  Widget _buildAttackStatsTable() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildVsHeaderRow(homeTeam: l10n.teamName, awayTeam: l10n.teamName),
        _buildComparisonRow(homeValue: 'NNN', label: l10n.scoring, awayValue: 'NNN'),
        _buildComparisonRow(homeValue: 'NN', label: l10n.assist, awayValue: 'NN'),
        _buildComparisonRow(homeValue: 'NN', label: l10n.turnover, awayValue: 'NN'),
      ],
    );
  }

  /// 수비력 비교 테이블
  Widget _buildDefenseStatsTable() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildVsHeaderRow(homeTeam: l10n.teamName, awayTeam: l10n.teamName),
        _buildComparisonRow(homeValue: 'NNN', label: l10n.conceded, awayValue: 'NNN'),
        _buildComparisonRow(homeValue: 'NN', label: 'S%', awayValue: 'NN'),
        _buildComparisonRow(homeValue: 'NN', label: l10n.rebound, awayValue: 'NN'),
      ],
    );
  }

  /// VS 헤더 행
  Widget _buildVsHeaderRow({required String homeTeam, required String awayTeam}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              homeTeam,
              textAlign: TextAlign.center,
              style: AppTextStyles.label1NormalBold.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'VS',
              textAlign: TextAlign.center,
              style: AppTextStyles.label1NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              awayTeam,
              textAlign: TextAlign.center,
              style: AppTextStyles.label1NormalBold.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 비교 행
  Widget _buildComparisonRow({
    required String homeValue,
    required String label,
    required String awayValue,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.containerNormal : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              homeValue,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          Expanded(
            child: Text(
              awayValue,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 섹션 타이틀
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.body1NormalBold.copyWith(
        color: AppColors.labelNormal,
      ),
    );
  }

  /// 최근 맞대결 전적
  Widget _buildRecentMatchups() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.teamName,
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.negative,
                  ),
                ),
                Text(
                  ' N${l10n.win} ',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                Text(
                  'N${l10n.lose}',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.positive,
                  ),
                ),
              ],
            ),
          ),
          // 테이블 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: AppColors.containerNormal,
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${l10n.teamName}N : N ${l10n.teamName}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '(${l10n.league})',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 경기 리스트
          _buildMatchupItemRow(homeTeam: '${l10n.teamName}N', homeScore: 'N', awayTeam: l10n.teamName, league: '(${l10n.league})'),
          _buildMatchupItemRow(homeTeam: '${l10n.teamName}N', homeScore: 'N', awayTeam: l10n.teamName, league: '(${l10n.league})'),
          _buildMatchupItemRow(homeTeam: '${l10n.teamName}N', homeScore: 'N', awayTeam: l10n.teamName, league: '(${l10n.league})'),
          _buildMatchupItemRow(homeTeam: '${l10n.teamName}N', homeScore: 'N', awayTeam: l10n.teamName, league: '(${l10n.league})'),
          _buildMatchupItemRow(homeTeam: '${l10n.teamName}N', homeScore: 'N', awayTeam: l10n.teamName, league: '(${l10n.league})', isLast: true),
        ],
      ),
    );
  }

  Widget _buildMatchupItemRow({
    required String homeTeam,
    required String homeScore,
    required String awayTeam,
    required String league,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast ? BorderSide.none : const BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Text(
              '$homeTeam : $homeScore $awayTeam',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              league,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption2Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 최근 양팀 전적
  Widget _buildRecentTeamRecords() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 우세 표시
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                l10n.homeAdvantage,
                style: AppTextStyles.label1NormalBold.copyWith(
                  color: AppColors.negative,
                ),
              ),
            ),
          ),
          // 팀 전적 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: AppColors.containerNormal,
            child: Center(
              child: Text(
                '${l10n.teamName} (N${l10n.win} N${l10n.lose} / ${l10n.awayTeam} : N${l10n.win} N${l10n.lose})',
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
          // 테이블 헤더
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderNormal),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    l10n.result,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    l10n.homeVsAway,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    l10n.matchDateLeague,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 경기 결과 리스트
          _buildTeamRecordItem(result: l10n.win, resultColor: AppColors.negative, homeTeam: '${l10n.teamName}N', awayTeam: 'N${l10n.teamName}', date: 'mm/dd(${l10n.league})'),
          _buildTeamRecordItem(result: l10n.lose, resultColor: AppColors.positive, homeTeam: '${l10n.teamName}N', awayTeam: 'N${l10n.teamName}', date: 'mm/dd(${l10n.league})'),
          _buildTeamRecordItem(result: l10n.win, resultColor: AppColors.negative, homeTeam: '${l10n.teamName}N', awayTeam: 'N${l10n.teamName}', date: 'mm/dd(${l10n.league})'),
          _buildTeamRecordItem(result: l10n.win, resultColor: AppColors.negative, homeTeam: '${l10n.teamName}N', awayTeam: 'N${l10n.teamName}', date: 'mm/dd(${l10n.league})'),
          _buildTeamRecordItem(result: l10n.win, resultColor: AppColors.negative, homeTeam: '${l10n.teamName}N', awayTeam: 'N${l10n.teamName}', date: 'mm/dd(${l10n.league})'),
        ],
      ),
    );
  }

  Widget _buildTeamRecordItem({
    required String result,
    required Color resultColor,
    required String homeTeam,
    required String awayTeam,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: resultColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption2Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$homeTeam : N $awayTeam',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption2Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
