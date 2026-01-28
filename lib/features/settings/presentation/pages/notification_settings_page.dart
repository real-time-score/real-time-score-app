import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: l10n.notificationSettings,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 설정 리스트
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildToggleItem(l10n.allNotifications, _allNotifications, (value) {
                      setState(() => _allNotifications = value);
                    }),
                    _buildToggleItem(l10n.matchStartNotification, _matchStart, (value) {
                      setState(() => _matchStart = value);
                    }),
                    _buildToggleItem(l10n.matchResultNotification, _matchResult, (value) {
                      setState(() => _matchResult = value);
                    }),
                    _buildToggleItem(l10n.predictionDeadline, _predictionDeadline, (value) {
                      setState(() => _predictionDeadline = value);
                    }),
                    _buildToggleItem(l10n.newExpertPick, _newExpertPick, (value) {
                      setState(() => _newExpertPick = value);
                    }),
                    _buildToggleItem(l10n.popularPost, _popularPost, (value) {
                      setState(() => _popularPost = value);
                    }),
                    _buildToggleItem(l10n.attendanceReminder, _attendanceReminder, (value) {
                      setState(() => _attendanceReminder = value);
                    }),
                    _buildToggleItem(l10n.temperatureWarning, _temperatureWarning, (value) {
                      setState(() => _temperatureWarning = value);
                    }),
                    _buildToggleItem(l10n.participationResult, _participationResult, (value) {
                      setState(() => _participationResult = value);
                    }),
                    _buildToggleItem(l10n.likeCommentNotification, _likeComment, (value) {
                      setState(() => _likeComment = value);
                    }),
                    _buildToggleItem(l10n.rankingEntryNotification, _rankingEntry, (value) {
                      setState(() => _rankingEntry = value);
                    }),
                    _buildToggleItem(l10n.cheerReactionNotification, _cheerReaction, (value) {
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
