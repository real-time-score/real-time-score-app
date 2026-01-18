import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 뱃지 정보 모델
class BadgeInfo {
  final String name;
  final String icon;
  final bool isEarned;

  const BadgeInfo({
    required this.name,
    required this.icon,
    this.isEarned = false,
  });
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // 인증뱃지 획득 수
                    _buildBadgeCount(),
                    const SizedBox(height: 32),
                    // 뱃지 그리드
                    _buildBadgeGrid(),
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
      title: '인증뱃지',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 뱃지 획득 수
  Widget _buildBadgeCount() {
    return Column(
      children: [
        Text(
          '인증뱃지 획득 수',
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
  Widget _buildBadgeGrid() {
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
        return _buildBadgeItem(badges[index]);
      },
    );
  }

  /// 뱃지 아이템
  Widget _buildBadgeItem(BadgeInfo badge) {
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
            badge.name,
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
      BadgeInfo(name: '응원의 전사', icon: 'swords', isEarned: true),
      BadgeInfo(name: '예측 마스터', icon: 'target', isEarned: true),
      BadgeInfo(name: '핫게시터', icon: 'hotspring', isEarned: true),
      BadgeInfo(name: '좋아요 요정', icon: 'fairy', isEarned: true),
      BadgeInfo(name: '댓글 리더', icon: 'bubbles', isEarned: false),
      BadgeInfo(name: '출석왕', icon: 'sun', isEarned: true),
      BadgeInfo(name: '픽 소비자', icon: 'document', isEarned: false),
      BadgeInfo(name: '열정유저', icon: 'fire', isEarned: true),
      BadgeInfo(name: '온도 수호자', icon: 'thermometer', isEarned: false),
    ];
  }
}
