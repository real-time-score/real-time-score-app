import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 활동온도 페이지
class ActivityTemperaturePage extends StatelessWidget {
  const ActivityTemperaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context, l10n),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 온도 카드
                    _buildTemperatureCard(l10n),
                    const SizedBox(height: 24),
                    // 상세 활동 온도
                    _buildDetailSection(l10n),
                    const SizedBox(height: 24),
                    // 설명
                    _buildDescription(l10n),
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
  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return AppHeader.withTitle(
      title: l10n.activityTemperature,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 온도 카드
  Widget _buildTemperatureCard(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 활동온도 라벨
          Text(
            l10n.activityTemperature,
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(height: 8),
          // 온도 값
          Text(
            '42.9°C',
            style: AppTextStyles.h1Bold.copyWith(
              color: const Color(0xFFFF9500),
            ),
          ),
          const SizedBox(height: 12),
          // 프로그레스 바
          _buildTemperatureProgressBar(),
          const SizedBox(height: 8),
          // 첫 온도
          Center(
            child: Text(
              l10n.initialTemperature,
              style: AppTextStyles.caption1Medium.copyWith(
                color: const Color(0xFFFF9500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 온도 프로그레스 바
  Widget _buildTemperatureProgressBar() {
    const double progress = 0.65; // 42.9 / ~65 정도로 가정

    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFD700),
                Color(0xFFFF9500),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  /// 상세 활동 온도 섹션
  Widget _buildDetailSection(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 타이틀
          Text(
            l10n.detailActivityTemperature,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 16),
          // 테이블
          _buildActivityTable(l10n),
        ],
      ),
    );
  }

  /// 활동 테이블
  Widget _buildActivityTable(AppLocalizations l10n) {
    final activities = [
      {'name': l10n.cheer, 'value': 'NN.N°C'},
      {'name': l10n.predictionGame, 'value': 'NN.N°C'},
      {'name': l10n.posts, 'value': 'NN.N°C'},
      {'name': l10n.likes, 'value': 'NN.N°C'},
      {'name': l10n.commentLabel, 'value': 'NN.N°C'},
      {'name': l10n.attendance, 'value': 'NN.N°C'},
      {'name': l10n.pickExpertShort, 'value': 'NN.N°C'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: activities.asMap().entries.map((entry) {
          final index = entry.key;
          final activity = entry.value;
          final isLast = index == activities.length - 1;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : Border(
                      bottom: BorderSide(color: AppColors.borderNormal),
                    ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activity['name']!,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
                Text(
                  activity['value']!,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 설명
  Widget _buildDescription(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        l10n.activityTemperatureDescription,
        style: AppTextStyles.caption1Medium.copyWith(
          color: AppColors.labelNeutral,
          height: 1.5,
        ),
      ),
    );
  }
}
