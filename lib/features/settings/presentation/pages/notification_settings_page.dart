import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 알림 설정 페이지
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // 알림 설정 상태
  bool _allNotifications = true;
  bool _matchStart = false;
  bool _matchResult = false;
  bool _predictionDeadline = false;
  bool _newExpertPick = false;
  bool _popularPost = false;
  bool _attendanceReminder = false;
  bool _temperatureWarning = false;
  bool _participationResult = false;
  bool _likeComment = false;
  bool _rankingEntry = false;
  bool _cheerReaction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: '알림 설정',
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 설정 리스트
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildToggleItem('전체 알림', _allNotifications, (value) {
                      setState(() => _allNotifications = value);
                    }),
                    _buildToggleItem('경기 시작 전 알림', _matchStart, (value) {
                      setState(() => _matchStart = value);
                    }),
                    _buildToggleItem('경기 결과 알림', _matchResult, (value) {
                      setState(() => _matchResult = value);
                    }),
                    _buildToggleItem('예측게임 마감 임박', _predictionDeadline, (value) {
                      setState(() => _predictionDeadline = value);
                    }),
                    _buildToggleItem('픽 전문가 신규 등록', _newExpertPick, (value) {
                      setState(() => _newExpertPick = value);
                    }),
                    _buildToggleItem('게시글 인기 상승 중', _popularPost, (value) {
                      setState(() => _popularPost = value);
                    }),
                    _buildToggleItem('출석 독려', _attendanceReminder, (value) {
                      setState(() => _attendanceReminder = value);
                    }),
                    _buildToggleItem('안전온도 하락 경고', _temperatureWarning, (value) {
                      setState(() => _temperatureWarning = value);
                    }),
                    _buildToggleItem('답 참여 결과 발표', _participationResult, (value) {
                      setState(() => _participationResult = value);
                    }),
                    _buildToggleItem('좋아요, 댓글 알림', _likeComment, (value) {
                      setState(() => _likeComment = value);
                    }),
                    _buildToggleItem('랭킹 진입 알림', _rankingEntry, (value) {
                      setState(() => _rankingEntry = value);
                    }),
                    _buildToggleItem('응원메시지 반응 알림', _cheerReaction, (value) {
                      setState(() => _cheerReaction = value);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 토글 아이템
  Widget _buildToggleItem(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          _buildCustomSwitch(value, onChanged),
        ],
      ),
    );
  }

  /// 커스텀 스위치
  Widget _buildCustomSwitch(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: value ? AppColors.primaryFigma : AppColors.containerNeutral,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
