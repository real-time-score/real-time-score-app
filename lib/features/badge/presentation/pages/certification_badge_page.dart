import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 뱃지 정보 모델
class BadgeInfo {
  final String nameKey;
  final String icon;
  final bool isEarned;

  const BadgeInfo({
    required this.nameKey,
    required this.icon,
    this.isEarned = false,
  });

  String getName(AppLocalizations l10n) {
    switch (nameKey) {
      case 'cheerWarrior':
        return l10n.badgeCheerWarrior;
      case 'predictionMaster':
        return l10n.badgePredictionMaster;
      case 'hotPoster':
        return l10n.badgeHotPoster;
      case 'likeFairy':
        return l10n.badgeLikeFairy;
      case 'commentLeader':
        return l10n.badgeCommentLeader;
      case 'attendanceKing':
        return l10n.badgeAttendanceKing;
      case 'pickConsumer':
        return l10n.badgePickConsumer;
      case 'passionUser':
        return l10n.badgePassionUser;
      case 'temperatureGuardian':
        return l10n.badgeTemperatureGuardian;
      default:
        return nameKey;
    }
  }
}

/// 인증뱃지 페이지
class CertificationBadgePage extends StatelessWidget {
  final bool showUnearned;

  const CertificationBadgePage({
    super.key,
    this.showUnearned = false,
  });

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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // 인증뱃지 획득 수
                    _buildBadgeCount(l10n),
                    const SizedBox(height: 32),
                    // 뱃지 그리드
                    _buildBadgeGrid(l10n),
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
      title: l10n.certificationBadge,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 뱃지 획득 수
  Widget _buildBadgeCount(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.badgeCount,
          style: AppTextStyles.body1NormalMedium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'NN개',
          style: AppTextStyles.h1Bold.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ],
    );
  }

  /// 뱃지 그리드
  Widget _buildBadgeGrid(AppLocalizations l10n) {
    final badges = _getBadges();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        return _buildBadgeItem(badges[index], l10n);
      },
    );
  }

  /// 뱃지 아이템
  Widget _buildBadgeItem(BadgeInfo badge, AppLocalizations l10n) {
    final isEarned = showUnearned ? false : badge.isEarned;

    return GestureDetector(
      onTap: () {
        // 뱃지 상세 보기
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 뱃지 아이콘 컨테이너
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: _buildBadgeIcon(badge.icon, isEarned),
            ),
          ),
          const SizedBox(height: 8),
          // 뱃지 이름
          Text(
            badge.getName(l10n),
            style: AppTextStyles.label1Medium.copyWith(
              color: isEarned ? AppColors.labelNormal : AppColors.labelAlternative,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 뱃지 아이콘
  Widget _buildBadgeIcon(String iconType, bool isEarned) {
    final double size = 40;
    final opacity = isEarned ? 1.0 : 0.4;

    switch (iconType) {
      case 'swords':
        return Opacity(
          opacity: opacity,
          child: Text(
            '⚔️',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'target':
        return Opacity(
          opacity: opacity,
          child: Text(
            '🎯',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'hotspring':
        return Opacity(
          opacity: opacity,
          child: Text(
            '♨️',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'fairy':
        return Opacity(
          opacity: opacity,
          child: Text(
            '🧚',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'bubbles':
        return Opacity(
          opacity: opacity,
          child: Text(
            '💬',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'sun':
        return Opacity(
          opacity: opacity,
          child: Text(
            '🌞',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'document':
        return Opacity(
          opacity: opacity,
          child: Text(
            '📋',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'fire':
        return Opacity(
          opacity: opacity,
          child: Text(
            '🔥',
            style: TextStyle(fontSize: size),
          ),
        );
      case 'thermometer':
        return Opacity(
          opacity: opacity,
          child: Text(
            '🌡️',
            style: TextStyle(fontSize: size),
          ),
        );
      default:
        return Icon(
          Icons.emoji_events,
          size: size,
          color: isEarned ? AppColors.primaryFigma : AppColors.labelAlternative,
        );
    }
  }

  /// 뱃지 목록
  List<BadgeInfo> _getBadges() {
    return const [
      BadgeInfo(nameKey: 'cheerWarrior', icon: 'swords', isEarned: true),
      BadgeInfo(nameKey: 'predictionMaster', icon: 'target', isEarned: true),
      BadgeInfo(nameKey: 'hotPoster', icon: 'hotspring', isEarned: true),
      BadgeInfo(nameKey: 'likeFairy', icon: 'fairy', isEarned: true),
      BadgeInfo(nameKey: 'commentLeader', icon: 'bubbles', isEarned: false),
      BadgeInfo(nameKey: 'attendanceKing', icon: 'sun', isEarned: true),
      BadgeInfo(nameKey: 'pickConsumer', icon: 'document', isEarned: false),
      BadgeInfo(nameKey: 'passionUser', icon: 'fire', isEarned: true),
      BadgeInfo(nameKey: 'temperatureGuardian', icon: 'thermometer', isEarned: false),
    ];
  }
}
