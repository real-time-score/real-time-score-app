import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 활동온도 페이지
class ActivityTemperaturePage extends StatelessWidget {
  const ActivityTemperaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 온도 카드
                    _buildTemperatureCard(),
                    const SizedBox(height: 24),
                    // 상세 활동 온도
                    _buildDetailSection(),
                    const SizedBox(height: 24),
                    // 설명
                    _buildDescription(),
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
  Widget _buildHeader(BuildContext context) {
    return AppHeader.withTitle(
      title: '활동온도',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 온도 카드
  Widget _buildTemperatureCard() {
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
            '활동온도',
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
              '첫 온도 36.5°C',
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
  Widget _buildDetailSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 타이틀
          Text(
            '상세 활동 온도',
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 16),
          // 테이블
          _buildActivityTable(),
        ],
      ),
    );
  }

  /// 활동 테이블
  Widget _buildActivityTable() {
    final activities = [
      {'name': '응원', 'value': 'NN.N°C'},
      {'name': '예측 게임', 'value': 'NN.N°C'},
      {'name': '게시글', 'value': 'NN.N°C'},
      {'name': '좋아요', 'value': 'NN.N°C'},
      {'name': '댓글', 'value': 'NN.N°C'},
      {'name': '출석', 'value': 'NN.N°C'},
      {'name': '픽전문', 'value': 'NN.N°C'},
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
  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '활동온도는 사용자의 활동 참여도를 시각적으로 나타내는 지표로, 예측게임 참여, 응원글 작성, 게시글 작성, 댓글, 좋아요, 출석 체크, 픽 전문가 글 구매 등의 다양한 활동을 통해 상승하며, 반대로 하루 동안 이와 같은 활동이 전혀 없을 경우에는 일정 기준에 따라 점진적으로 하락하여 사용자 활동을 휴도하는 기능입니다.',
        style: AppTextStyles.caption1Medium.copyWith(
          color: AppColors.labelNeutral,
          height: 1.5,
        ),
      ),
    );
  }
}
