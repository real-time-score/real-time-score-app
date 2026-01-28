import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 팀 정보 메인 탭 타입
enum TeamInfoTab {
  /// 일정/결과
  schedule,

  /// 순위
  ranking,

  /// 선수
  players,
}

/// 일정/결과 서브 탭 타입
enum ScheduleSubTab {
  /// 전체
  all,

  /// 홈
  home,

  /// 맞대결
  versus,
}

/// 팀 정보 상세 페이지
class TeamInfoPage extends StatefulWidget {
  const TeamInfoPage({
    super.key,
    this.initialTab = TeamInfoTab.schedule,
    this.initialSubTab = ScheduleSubTab.all,
  });

  /// 초기 메인 탭
  final TeamInfoTab initialTab;

  /// 초기 서브 탭
  final ScheduleSubTab initialSubTab;

  @override
  State<TeamInfoPage> createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {
  late TeamInfoTab _selectedTab;
  late ScheduleSubTab _selectedSubTab;
  int _selectedRankingLeague = 0;
  int _selectedPlayersLeague = 0;

  List<String> _getMainTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.scheduleResult, l10n.rankingTab, l10n.players];
  }

  List<String> _getSubTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, l10n.homeMatch, l10n.versus];
  }

  List<String> _getRankingLeagues(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, l10n.leagueName, l10n.leagueName, l10n.leagueName, l10n.leagueName, l10n.leagueName];
  }

  List<String> _getPlayersLeagues(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, l10n.leagueName, l10n.leagueName, l10n.leagueName, l10n.leagueName, l10n.leagueName];
  }

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    _selectedSubTab = widget.initialSubTab;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: l10n.teamName,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 메인 탭 토글
            _buildMainTabToggle(),
            const SizedBox(height: 8),
            // 서브 탭 (일정/결과 탭일 때만)
            if (_selectedTab == TeamInfoTab.schedule) _buildSubTabToggle(),
            // 순위 리그 필터 (순위 탭일 때만)
            if (_selectedTab == TeamInfoTab.ranking) _buildRankingLeagueFilter(),
            // 선수 리그 필터 (선수 탭일 때만)
            if (_selectedTab == TeamInfoTab.players) _buildPlayersLeagueFilter(),
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

  /// 메인 3단 탭 토글
  Widget _buildMainTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: TeamInfoTab.values.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = tab == _selectedTab;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = tab;
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
                    _getMainTabs(context)[index],
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
        children: ScheduleSubTab.values.asMap().entries.map((entry) {
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
    switch (_selectedTab) {
      case TeamInfoTab.schedule:
        return _buildScheduleContent();
      case TeamInfoTab.ranking:
        return _buildRankingContent();
      case TeamInfoTab.players:
        return _buildPlayersContent();
    }
  }

  /// 일정/결과 컨텐츠
  Widget _buildScheduleContent() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 예정된 경기 1
          _buildMatchCard(
            leagueName: l10n.leagueName,
            hasPick: true,
            homeTeam: l10n.teamName,
            awayTeam: l10n.teamName,
            dateTime: '7/11\n15 : 30',
            isFinished: false,
          ),
          const SizedBox(height: 12),
          // 예정된 경기 2
          _buildMatchCard(
            leagueName: l10n.leagueName,
            hasPick: true,
            homeTeam: l10n.teamName,
            awayTeam: l10n.teamName,
            dateTime: '7/11\n15 : 30',
            isFinished: false,
          ),
          const SizedBox(height: 12),
          // 종료된 경기
          _buildMatchCard(
            leagueName: l10n.leagueName,
            hasPick: true,
            homeTeam: l10n.teamName,
            awayTeam: l10n.teamName,
            homeScore: 1,
            awayScore: 5,
            isFinished: true,
          ),
        ],
      ),
    );
  }

  /// 경기 카드
  Widget _buildMatchCard({
    required String leagueName,
    required bool hasPick,
    required String homeTeam,
    required String awayTeam,
    String? dateTime,
    int? homeScore,
    int? awayScore,
    required bool isFinished,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 리그명 + 픽 뱃지 + 알림
          Row(
            children: [
              Text(
                leagueName,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 8),
              if (hasPick)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.negative,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    l10n.pick,
                    style: AppTextStyles.caption2Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // TODO: 알림 설정
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
          ),
          const SizedBox(height: 16),
          // 팀 VS 팀
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 홈팀
              _buildTeamItem(teamName: homeTeam),
              const SizedBox(width: 16),
              // 스코어 또는 날짜
              if (isFinished)
                _buildScoreBox(homeScore: homeScore!, awayScore: awayScore!)
              else
                _buildDateTimeBox(dateTime: dateTime!),
              const SizedBox(width: 16),
              // 원정팀
              _buildTeamItem(teamName: awayTeam),
            ],
          ),
        ],
      ),
    );
  }

  /// 팀 아이템
  Widget _buildTeamItem({required String teamName}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/team-info'),
      child: Column(
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
          const SizedBox(height: 4),
          Text(
            teamName,
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
        ],
      ),
    );
  }

  /// 날짜/시간 박스
  Widget _buildDateTimeBox({required String dateTime}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        dateTime,
        textAlign: TextAlign.center,
        style: AppTextStyles.caption1Medium.copyWith(
          color: AppColors.labelNormal,
        ),
      ),
    );
  }

  /// 스코어 박스
  Widget _buildScoreBox({required int homeScore, required int awayScore}) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          '$homeScore',
          style: AppTextStyles.h4Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            l10n.finished,
            style: AppTextStyles.caption2Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$awayScore',
          style: AppTextStyles.h4Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 순위 리그 필터 (가로 스크롤)
  Widget _buildRankingLeagueFilter() {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal, width: 1),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _getRankingLeagues(context).length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedRankingLeague;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedRankingLeague = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  _getRankingLeagues(context)[index],
                  style: isSelected
                      ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.primaryFigma)
                      : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelAlternative),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 순위 컨텐츠
  Widget _buildRankingContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildRankingTable(),
    );
  }

  /// 순위 테이블
  Widget _buildRankingTable() {
    final l10n = AppLocalizations.of(context)!;
    final columns = [l10n.rankingTab, l10n.teamName, l10n.matches, l10n.points, l10n.win, l10n.draw];

    // 샘플 데이터 (11팀)
    final List<List<String>> rows = List.generate(
      11,
      (index) => [
        '${index + 1}',
        'NNN',
        'NNN',
        'NNN',
        'NNN',
        'NNN',
      ],
    );

    return Column(
      children: [
        // 헤더 행
        _buildRankingTableRow(columns, isHeader: true),
        // 데이터 행들
        ...rows.map((row) => _buildRankingTableRow(row, isHeader: false)),
      ],
    );
  }

  /// 순위 테이블 행
  Widget _buildRankingTableRow(List<String> cells, {required bool isHeader}) {
    return Row(
      children: cells.asMap().entries.map((entry) {
        final index = entry.key;
        final cell = entry.value;
        final isRankColumn = index == 0;

        return Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: isHeader || isRankColumn
                  ? AppColors.containerNormal
                  : AppColors.white,
              border: Border.all(color: AppColors.borderNormal, width: 0.5),
            ),
            child: Center(
              child: Text(
                cell,
                style: isHeader
                    ? AppTextStyles.body2NormalMedium.copyWith(
                        color: AppColors.labelNormal,
                      )
                    : AppTextStyles.label1Medium.copyWith(
                        color: isRankColumn
                            ? AppColors.labelNormal
                            : AppColors.labelNeutral,
                      ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 선수 리그 필터 (가로 스크롤)
  Widget _buildPlayersLeagueFilter() {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal, width: 1),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _getPlayersLeagues(context).length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedPlayersLeague;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPlayersLeague = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  _getPlayersLeagues(context)[index],
                  style: isSelected
                      ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.primaryFigma)
                      : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelAlternative),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 선수 컨텐츠
  Widget _buildPlayersContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildPlayersTable(),
    );
  }

  /// 선수 테이블
  Widget _buildPlayersTable() {
    final l10n = AppLocalizations.of(context)!;
    final columns = [l10n.position, l10n.playerName, l10n.nationality, l10n.age, l10n.defenseRate];

    // 샘플 데이터 (12명)
    final List<List<String>> rows = List.generate(
      12,
      (index) => [l10n.info, l10n.info, l10n.info, l10n.info, l10n.info],
    );

    return Column(
      children: [
        // 헤더 행
        _buildPlayersTableRow(columns, isHeader: true),
        // 데이터 행들
        ...rows.map((row) => _buildPlayersTableRow(row, isHeader: false)),
      ],
    );
  }

  /// 선수 테이블 행
  Widget _buildPlayersTableRow(List<String> cells, {required bool isHeader}) {
    final row = Row(
      children: cells.asMap().entries.map((entry) {
        final cell = entry.value;

        return Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: isHeader ? AppColors.containerNormal : AppColors.white,
              border: Border.all(color: AppColors.borderNormal, width: 0.5),
            ),
            child: Center(
              child: Text(
                cell,
                style: isHeader
                    ? AppTextStyles.body2NormalMedium.copyWith(
                        color: AppColors.labelNormal,
                      )
                    : AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
              ),
            ),
          ),
        );
      }).toList(),
    );

    // 헤더가 아닌 경우 탭하면 선수 상세 페이지로 이동
    if (!isHeader) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/player-detail'),
        child: row,
      );
    }
    return row;
  }
}
