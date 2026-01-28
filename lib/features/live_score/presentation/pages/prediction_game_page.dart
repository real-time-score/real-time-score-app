import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 예측게임 페이지
class PredictionGamePage extends StatefulWidget {
  const PredictionGamePage({super.key});

  @override
  State<PredictionGamePage> createState() => _PredictionGamePageState();
}

class _PredictionGamePageState extends State<PredictionGamePage> {
  int _selectedMainTabIndex = 3; // 예측게임 탭 선택

  List<String> _getMainTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.liveTab, l10n.chart, l10n.lineup, l10n.predictionGame];
  }

  // 예측 선택 상태
  int? _winnerSelection; // 0: 홈팀, 1: 원정팀
  int? _handicapSelection;
  int? _underOverSelection;
  String? _homeRunHomePlayer;
  String? _homeRunAwayPlayer;
  int? _scoreHome;
  int? _scoreAway;
  String? _goalHomePlayer;
  String? _goalAwayPlayer;

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
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
            // 제출 버튼
            _buildSubmitButton(),
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

  /// 메인 탭 네비게이션 처리
  void _navigateToMainTab(int index) {
    switch (index) {
      case 0: // 라이브
        Navigator.of(context).pushReplacementNamed('/live-match-detail');
        break;
      case 1: // 차트
        Navigator.of(context).pushReplacementNamed('/chart-comparison');
        break;
      case 2: // 라인업
        Navigator.of(context).pushReplacementNamed('/lineup');
        break;
      case 3: // 예측게임 (현재 페이지)
        setState(() {
          _selectedMainTabIndex = index;
        });
        break;
    }
  }

  /// 컨텐츠
  Widget _buildContent() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 경기 정보 카드
          _buildMatchInfoCard(),
          const SizedBox(height: 24),
          // 예측 섹션 타이틀
          Text(
            l10n.predictMatch,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 16),
          // 예측 테이블
          _buildPredictionTable(),
        ],
      ),
    );
  }

  /// 경기 정보 카드
  Widget _buildMatchInfoCard() {
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
          // 리그명 + 날짜
          Text(
            '${l10n.leagueName} mm/dd/mm',
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(height: 16),
          // 팀 VS 팀
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 홈팀
              _buildTeamInfo(teamName: l10n.teamName),
              const SizedBox(width: 24),
              // VS
              Text(
                'VS',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 24),
              // 원정팀
              _buildTeamInfo(teamName: l10n.teamName),
            ],
          ),
        ],
      ),
    );
  }

  /// 팀 정보
  Widget _buildTeamInfo({required String teamName}) {
    return Column(
      children: [
        // 팀 로고
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
        const SizedBox(height: 8),
        // 팀명
        Text(
          teamName,
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 예측 테이블
  Widget _buildPredictionTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 헤더 행
          _buildTableHeader(),
          // 승리팀 행
          _buildWinnerRow(),
          // 핸디캡 행
          _buildHandicapRow(),
          // 언더오버 행
          _buildUnderOverRow(),
          // 홈런 행
          _buildHomeRunRow(),
          // 스코어 행
          _buildScoreRow(),
          // 골 행
          _buildGoalRow(),
        ],
      ),
    );
  }

  /// 테이블 헤더
  Widget _buildTableHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          // 빈 셀
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  l10n.teamName,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          ),
          // 홈팀
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  l10n.teamName,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          ),
          // 원정팀
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  l10n.teamName,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 승리팀 행
  Widget _buildWinnerRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildRadioRow(
      label: l10n.victoryTeam,
      homeValue: 'NN%',
      awayValue: 'NN%',
      groupValue: _winnerSelection,
      onHomeSelected: () {
        setState(() {
          _winnerSelection = 0;
        });
      },
      onAwaySelected: () {
        setState(() {
          _winnerSelection = 1;
        });
      },
    );
  }

  /// 핸디캡 행
  Widget _buildHandicapRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildRadioRow(
      label: l10n.handicap,
      subLabel: 'NN',
      subLabelColor: AppColors.primaryFigma,
      homeValue: 'NN%',
      awayValue: 'NN%',
      groupValue: _handicapSelection,
      onHomeSelected: () {
        setState(() {
          _handicapSelection = 0;
        });
      },
      onAwaySelected: () {
        setState(() {
          _handicapSelection = 1;
        });
      },
    );
  }

  /// 언더오버 행
  Widget _buildUnderOverRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildRadioRow(
      label: l10n.underOver,
      subLabel: 'NNN.NN',
      subLabelColor: AppColors.primaryFigma,
      homeValue: 'NN%',
      awayValue: 'NN%',
      groupValue: _underOverSelection,
      onHomeSelected: () {
        setState(() {
          _underOverSelection = 0;
        });
      },
      onAwaySelected: () {
        setState(() {
          _underOverSelection = 1;
        });
      },
    );
  }

  /// 라디오 버튼 행
  Widget _buildRadioRow({
    required String label,
    String? subLabel,
    Color? subLabelColor,
    required String homeValue,
    required String awayValue,
    int? groupValue,
    required VoidCallback onHomeSelected,
    required VoidCallback onAwaySelected,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          // 라벨
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Text(
                    label,
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subLabel,
                      style: AppTextStyles.caption2Medium.copyWith(
                        color: subLabelColor ?? AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // 홈팀 선택
          Expanded(
            child: GestureDetector(
              onTap: onHomeSelected,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRadioButton(isSelected: groupValue == 0),
                    const SizedBox(width: 4),
                    Text(
                      homeValue,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 원정팀 선택
          Expanded(
            child: GestureDetector(
              onTap: onAwaySelected,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRadioButton(isSelected: groupValue == 1),
                    const SizedBox(width: 4),
                    Text(
                      awayValue,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 라디오 버튼
  Widget _buildRadioButton({required bool isSelected}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primaryFigma : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.primaryFigma : AppColors.borderNormal,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.circle,
                size: 8,
                color: AppColors.white,
              ),
            )
          : null,
    );
  }

  /// 홈런 행
  Widget _buildHomeRunRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildDropdownRow(
      label: l10n.homerun,
      homeValue: _homeRunHomePlayer ?? l10n.playerName,
      awayValue: _homeRunAwayPlayer ?? l10n.playerName,
      onHomeTap: () {
        // TODO: 선수 선택 바텀시트
      },
      onAwayTap: () {
        // TODO: 선수 선택 바텀시트
      },
    );
  }

  /// 스코어 행
  Widget _buildScoreRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildDropdownRow(
      label: l10n.score,
      homeValue: _scoreHome?.toString() ?? 'N',
      awayValue: _scoreAway?.toString() ?? 'N',
      onHomeTap: () {
        // TODO: 스코어 선택 바텀시트
      },
      onAwayTap: () {
        // TODO: 스코어 선택 바텀시트
      },
    );
  }

  /// 골 행
  Widget _buildGoalRow() {
    final l10n = AppLocalizations.of(context)!;
    return _buildDropdownRow(
      label: l10n.goal,
      homeValue: _goalHomePlayer ?? l10n.playerName,
      awayValue: _goalAwayPlayer ?? l10n.playerName,
      onHomeTap: () {
        // TODO: 선수 선택 바텀시트
      },
      onAwayTap: () {
        // TODO: 선수 선택 바텀시트
      },
      isLast: true,
    );
  }

  /// 드롭다운 행
  Widget _buildDropdownRow({
    required String label,
    required String homeValue,
    required String awayValue,
    required VoidCallback onHomeTap,
    required VoidCallback onAwayTap,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.borderNormal),
              ),
      ),
      child: Row(
        children: [
          // 라벨
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ),
            ),
          ),
          // 홈팀 드롭다운
          Expanded(
            child: GestureDetector(
              onTap: onHomeTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      homeValue,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: AppColors.labelNeutral,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 원정팀 드롭다운
          Expanded(
            child: GestureDetector(
              onTap: onAwayTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      awayValue,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: AppColors.labelNeutral,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 제출 버튼
  Widget _buildSubmitButton() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            // TODO: 예측 제출
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryFigma,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            l10n.submit,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
