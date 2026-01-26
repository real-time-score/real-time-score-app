import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

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

  final List<String> _mainTabs = ['라이브', '차트', '라인업', '예측게임'];
  final List<String> _subTabs = ['비교', '기록', '순위'];
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
        children: _mainTabs.asMap().entries.map((entry) {
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
                    _subTabs[index],
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
          _buildSectionTitle('공격력 비교'),
          const SizedBox(height: 8),
          _buildAttackStatsTable(),
          const SizedBox(height: 24),
          // 수비력 비교
          _buildSectionTitle('수비력 비교'),
          const SizedBox(height: 8),
          _buildDefenseStatsTable(),
          const SizedBox(height: 24),
          // 최근 맞대결 전적
          _buildSectionTitle('최근 맞대결 전적'),
          const SizedBox(height: 8),
          _buildRecentMatchups(),
          const SizedBox(height: 24),
          // 최근 양팀 전적
          _buildSectionTitle('최근 양팀 전적'),
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
        _buildFilterChips(
          items: ['국가명', '국가명', '국가명', '국가명', '국가명', '국가명'],
          selectedIndex: 0,
        ),
        const SizedBox(height: 8),
        // 리그 필터
        _buildFilterChips(
          items: ['리그명', '리그명', '리그명', '리그명', '리그명', '리그명'],
          selectedIndex: 0,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '정규시즌',
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
                      '년도',
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
              }).toList(),
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
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  '순위',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '팀명',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '경기',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '승점',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '승',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '무',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
            ],
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
            child: Row(
              children: [
                const SizedBox(width: 80), // 팀명 영역
                Expanded(
                  child: _buildPeriodHeaderCell('전반'),
                ),
                Expanded(
                  child: _buildPeriodHeaderCell('후반'),
                ),
                Expanded(
                  child: _buildPeriodHeaderCell('연장'),
                ),
                Expanded(
                  child: _buildPeriodHeaderCell('승부'),
                ),
              ],
            ),
          ),
          // 홈팀 행
          _buildScoreRow(teamName: '팀명', scores: ['N', 'N', 'N', 'N']),
          // 원정팀 행
          _buildScoreRow(teamName: '팀명', scores: ['N', 'N', 'N', 'N'], isLast: true),
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
    return Column(
      children: [
        // 팀 VS 팀
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeamHeaderItem(teamName: '팀명', flagEmoji: '🇹🇱'),
            Text(
              'VS',
              style: AppTextStyles.body1NormalBold.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
            _buildTeamHeaderItem(teamName: '팀명', flagEmoji: '🇺🇦'),
          ],
        ),
        const SizedBox(height: 16),
        // 선수 아이콘 행
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('🤾', style: TextStyle(fontSize: 24)),
            Text(
              '선수',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
            const Text('🤾', style: TextStyle(fontSize: 24)),
          ],
        ),
      ],
    );
  }

  /// 경기 기록 비교 테이블
  Widget _buildMatchRecordTable() {
    return Column(
      children: [
        _buildRecordRow(homeValue: 'NN', label: '득점', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '슈팅', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '유효슛', awayValue: 'NN', isHighlighted: true),
        _buildRecordRow(homeValue: 'NN', label: '세이브', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '오프사이드', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '파울', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '경고', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '퇴장', awayValue: 'NN'),
        _buildRecordRow(homeValue: 'NN', label: '코너킥', awayValue: 'NN', isHighlighted: true),
        _buildRecordRow(homeValue: 'NN', label: '프리킥', awayValue: 'NN'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 홈팀
        _buildTeamHeaderItem(teamName: '팀명', flagEmoji: '🇺🇦'),
        // VS
        Text(
          'VS',
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        // 원정팀
        _buildTeamHeaderItem(teamName: '팀명', flagEmoji: '🇪🇨'),
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
    return Column(
      children: [
        _buildComparisonRow(homeValue: '리그명 노출', label: '우승후', awayValue: '리그명 노출'),
        _buildComparisonRow(homeValue: 'N위', label: '순위', awayValue: 'N위'),
        _buildComparisonRow(homeValue: 'N승N패', label: '전적', awayValue: 'N승N패'),
        _buildRecentMatchesRow(),
        _buildComparisonRow(homeValue: 'N승 N패', label: '상대 전적', awayValue: 'N승 N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: '승률', awayValue: 'N승N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: '홈/원정 승률', awayValue: 'N승N패'),
        _buildComparisonRow(homeValue: 'N승N패', label: '평점 승률', awayValue: 'N승N패'),
      ],
    );
  }

  /// 최근 5경기 행 (승/무/패 컬러 적용)
  Widget _buildRecentMatchesRow() {
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
                _buildMatchResultBadge('승', AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge('패', AppColors.positive),
                const SizedBox(width: 2),
                _buildMatchResultBadge('승', AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge('무', AppColors.labelNeutral),
                const SizedBox(width: 2),
                _buildMatchResultBadge('승', AppColors.negative),
              ],
            ),
          ),
          // 라벨
          SizedBox(
            width: 80,
            child: Text(
              '최근 5경기',
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
                _buildMatchResultBadge('패', AppColors.positive),
                const SizedBox(width: 2),
                _buildMatchResultBadge('승', AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge('무', AppColors.labelNeutral),
                const SizedBox(width: 2),
                _buildMatchResultBadge('승', AppColors.negative),
                const SizedBox(width: 2),
                _buildMatchResultBadge('패', AppColors.positive),
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
    return Column(
      children: [
        _buildVsHeaderRow(homeTeam: '팀명', awayTeam: '팀명'),
        _buildComparisonRow(homeValue: 'NNN', label: '득점', awayValue: 'NNN'),
        _buildComparisonRow(homeValue: 'NN', label: '어시스트', awayValue: 'NN'),
        _buildComparisonRow(homeValue: 'NN', label: '턴오버', awayValue: 'NN'),
      ],
    );
  }

  /// 수비력 비교 테이블
  Widget _buildDefenseStatsTable() {
    return Column(
      children: [
        _buildVsHeaderRow(homeTeam: '팀명', awayTeam: '팀명'),
        _buildComparisonRow(homeValue: 'NNN', label: '실점', awayValue: 'NNN'),
        _buildComparisonRow(homeValue: 'NN', label: 'S%', awayValue: 'NN'),
        _buildComparisonRow(homeValue: 'NN', label: '리바', awayValue: 'NN'),
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
                  '팀명',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.negative,
                  ),
                ),
                Text(
                  ' N승 ',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                Text(
                  'N패',
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
                    '팀명N : N 팀명',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '(리그)',
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
          _buildMatchupItemRow(homeTeam: '팀명N', homeScore: 'N', awayTeam: '팀명', league: '(리그)'),
          _buildMatchupItemRow(homeTeam: '팀명N', homeScore: 'N', awayTeam: '팀명', league: '(리그)'),
          _buildMatchupItemRow(homeTeam: '팀명N', homeScore: 'N', awayTeam: '팀명', league: '(리그)'),
          _buildMatchupItemRow(homeTeam: '팀명N', homeScore: 'N', awayTeam: '팀명', league: '(리그)'),
          _buildMatchupItemRow(homeTeam: '팀명N', homeScore: 'N', awayTeam: '팀명', league: '(리그)', isLast: true),
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
                '홈대 우세',
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
                '팀명 (N승 N패 / 원정 : N승 N패)',
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
                    '결과',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '홈 vs 원정',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption2Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    '경기일(리그)',
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
          _buildTeamRecordItem(result: '승', resultColor: AppColors.negative, homeTeam: '팀명N', awayTeam: 'N팀명', date: 'mm/dd(리그)'),
          _buildTeamRecordItem(result: '패', resultColor: AppColors.positive, homeTeam: '팀명N', awayTeam: 'N팀명', date: 'mm/dd(리그)'),
          _buildTeamRecordItem(result: '승', resultColor: AppColors.negative, homeTeam: '팀명N', awayTeam: 'N팀명', date: 'mm/dd(리그)'),
          _buildTeamRecordItem(result: '승', resultColor: AppColors.negative, homeTeam: '팀명N', awayTeam: 'N팀명', date: 'mm/dd(리그)'),
          _buildTeamRecordItem(result: '승', resultColor: AppColors.negative, homeTeam: '팀명N', awayTeam: 'N팀명', date: 'mm/dd(리그)'),
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
