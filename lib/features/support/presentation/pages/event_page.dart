import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 이벤트 페이지
class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context),
            // 이벤트 리스트
            Expanded(
              child: _buildEventList(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppHeader.withTitle(
      title: l10n.event,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 이벤트 리스트
  Widget _buildEventList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildEventCard(context, index);
      },
    );
  }

  /// 이벤트 카드
  Widget _buildEventCard(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final bool isOngoing = index < 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderNormal),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이벤트 이미지
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.celebration_outlined,
                    size: 48,
                    color: AppColors.labelAlternative,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.eventImage,
                    style: AppTextStyles.body2NormalMedium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 이벤트 정보
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상태 뱃지
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isOngoing
                        ? AppColors.positive.withValues(alpha: 0.1)
                        : AppColors.labelAlternative.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isOngoing ? l10n.ongoing : l10n.finished,
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: isOngoing
                          ? AppColors.positive
                          : AppColors.labelAlternative,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // 이벤트 제목
                Text(
                  '${l10n.eventTitle} ${index + 1}',
                  style: AppTextStyles.body1NormalBold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                const SizedBox(height: 4),
                // 이벤트 기간
                Text(
                  '2025.01.01 ~ 2025.01.31',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
