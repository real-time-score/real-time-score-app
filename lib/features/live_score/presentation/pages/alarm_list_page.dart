import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 알람 목록 페이지
class AlarmListPage extends StatefulWidget {
  const AlarmListPage({super.key});

  @override
  State<AlarmListPage> createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  // 탭 인덱스: 0=경기전, 1=경기중, 2=경기 종료
  int _selectedTabIndex = 0;

  List<String> _getTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.beforeMatch, l10n.duringMatch, l10n.afterMatch];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppHeader.withTitle(
        title: l10n.alarmList,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          // 3단 토글
          _buildSegmentedToggle(),
          const SizedBox(height: 8),
          // 알람 리스트
          Expanded(
            child: _buildAlarmList(),
          ),
        ],
      ),
    );
  }

  /// 3단 세그먼트 토글
  Widget _buildSegmentedToggle() {
    final tabs = _getTabs(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = index == _selectedTabIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
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
                    label,
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.white)
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

  /// 알람 리스트
  Widget _buildAlarmList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 4, // 샘플 데이터
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index < 3 ? 8 : 0),
          child: _buildAlarmItem(),
        );
      },
    );
  }

  /// 알람 아이템 카드
  Widget _buildAlarmItem() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 리그 헤더
          _buildLeagueHeader(),
          const SizedBox(height: 12),
          // 경기 정보
          _buildMatchInfo(),
          const SizedBox(height: 8),
          // 배당률 테이블
          _buildOddsTable(),
        ],
      ),
    );
  }

  /// 리그 헤더
  Widget _buildLeagueHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        // 리그명
        Text(
          l10n.leagueName,
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(width: 8),
        // 픽 뱃지
        Container(
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
        ),
        const Spacer(),
        // 알림 아이콘 (활성화)
        GestureDetector(
          onTap: () {
            // TODO: 알림 설정 토글
          },
          child: SvgPicture.asset(
            AppIcons.bellFill,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.labelNormal,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  /// 경기 정보 (팀 + 일정)
  Widget _buildMatchInfo() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        // 홈팀
        Expanded(
          child: _buildTeamInfo(teamName: l10n.teamName),
        ),
        // 일정
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                '7/11 (금)',
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              Text(
                '15:30',
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ],
          ),
        ),
        // 원정팀
        Expanded(
          child: _buildTeamInfo(teamName: l10n.teamName),
        ),
      ],
    );
  }

  /// 팀 정보
  Widget _buildTeamInfo({required String teamName}) {
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
        // 팀명
        Text(
          teamName,
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
    return Column(
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
