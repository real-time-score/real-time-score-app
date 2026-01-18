import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 선수 상세 페이지
class PlayerDetailPage extends StatelessWidget {
  const PlayerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: '선수명',
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 선수 정보 영역
                      _buildPlayerInfoSection(),
                      const SizedBox(height: 24),
                      // 출전결과 타이틀
                      Text(
                        '출전결과',
                        style: AppTextStyles.h4Bold.copyWith(
                          color: AppColors.labelNormal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 경기 리스트
                      _buildMatchHistoryList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 선수 정보 영역 (사진 + 스탯)
  Widget _buildPlayerInfoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 선수 사진
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 80,
                color: AppColors.labelAlternative,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 스탯 박스
        Expanded(
          child: SizedBox(
            height: 180,
            child: Column(
              children: [
                _buildStatItem(label: '득점', value: 'NN'),
                const SizedBox(height: 8),
                _buildStatItem(label: '도움', value: 'NN'),
                const SizedBox(height: 8),
                _buildStatItem(label: '평득', value: 'NN'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 스탯 아이템
  Widget _buildStatItem({required String label, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.containerNormal,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.label1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
            Text(
              value,
              style: AppTextStyles.body1NormalBold.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 경기 히스토리 리스트
  Widget _buildMatchHistoryList() {
    return Column(
      children: [
        _buildMatchHistoryCard(
          leagueName: '리그명 mm/dd/mm',
          starterInfo: '선발(NN)',
          homeTeam: '팀명',
          awayTeam: '팀명',
          homeScore: 1,
          awayScore: 5,
        ),
        const SizedBox(height: 8),
        _buildMatchHistoryCard(
          leagueName: '리그명 mm/dd/mm',
          starterInfo: '선발(NN)',
          homeTeam: '팀명',
          awayTeam: '팀명',
          homeScore: 1,
          awayScore: 5,
        ),
        const SizedBox(height: 8),
        _buildMatchHistoryCard(
          leagueName: '리그명 mm/dd/mm',
          starterInfo: '선발(NN)',
          homeTeam: '팀명',
          awayTeam: '팀명',
          homeScore: 1,
          awayScore: 5,
        ),
      ],
    );
  }

  /// 경기 히스토리 카드
  Widget _buildMatchHistoryCard({
    required String leagueName,
    required String starterInfo,
    required String homeTeam,
    required String awayTeam,
    required int homeScore,
    required int awayScore,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 상단: 리그명 + 선발 칩 + 알림
          Row(
            children: [
              // 리그명 칩
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.containerNormal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  leagueName,
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 선발 칩
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  starterInfo,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.primaryFigma,
                  ),
                ),
              ),
              const Spacer(),
              // 알림 버튼
              SvgPicture.asset(
                AppIcons.bell,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.labelAlternative,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 하단: 팀 vs 팀
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 홈팀
              _buildTeamItem(teamName: homeTeam),
              const SizedBox(width: 16),
              // 스코어
              _buildScoreBox(homeScore: homeScore, awayScore: awayScore),
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
    return Column(
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
        const SizedBox(height: 8),
        Text(
          teamName,
          style: AppTextStyles.label1Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 스코어 박스
  Widget _buildScoreBox({required int homeScore, required int awayScore}) {
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '종료',
            style: AppTextStyles.label1Medium.copyWith(
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
}
