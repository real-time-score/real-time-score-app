import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// 사용자 등급 레벨
enum RankLevel {
  newbie, // 뉴비
  bronze, // 브론즈
  silver, // 실버
  gold, // 골드
  diamond, // 다이아
  platinum, // 플래티넘
}

/// 랭크 배지 스타일
enum RankStyle {
  text, // 텍스트만
  badge, // 텍스트 + 아이콘 (진한 배경)
  badgeLight, // 텍스트 + 아이콘 (연한 배경)
}

/// 등급 배지 컴포넌트
class AppRank extends StatelessWidget {
  const AppRank({
    super.key,
    required this.level,
    this.style = RankStyle.text,
  });

  final RankLevel level;
  final RankStyle style;

  /// 뉴비 팩토리
  factory AppRank.newbie({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.newbie, style: style);
  }

  /// 브론즈 팩토리
  factory AppRank.bronze({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.bronze, style: style);
  }

  /// 실버 팩토리
  factory AppRank.silver({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.silver, style: style);
  }

  /// 골드 팩토리
  factory AppRank.gold({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.gold, style: style);
  }

  /// 다이아 팩토리
  factory AppRank.diamond({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.diamond, style: style);
  }

  /// 플래티넘 팩토리
  factory AppRank.platinum({RankStyle style = RankStyle.text}) {
    return AppRank(level: RankLevel.platinum, style: style);
  }

  /// 등급별 라벨
  String get _label {
    switch (level) {
      case RankLevel.newbie:
        return '뉴비';
      case RankLevel.bronze:
        return '브론즈';
      case RankLevel.silver:
        return '실버';
      case RankLevel.gold:
        return '골드';
      case RankLevel.diamond:
        return '다이아';
      case RankLevel.platinum:
        return '플래티넘';
    }
  }

  /// 등급별 배경색 (진한 색)
  Color get _backgroundColor {
    switch (level) {
      case RankLevel.newbie:
        return const Color(0xFF5F4D4D);
      case RankLevel.bronze:
        return const Color(0xFFA4573B);
      case RankLevel.silver:
        return const Color(0xFF8397A0);
      case RankLevel.gold:
        return const Color(0xFFEBB23F);
      case RankLevel.diamond:
        return const Color(0xFF46CFC8);
      case RankLevel.platinum:
        return const Color(0xFF4546DF);
    }
  }

  /// 등급별 배경색 (연한 색 - light 스타일용)
  Color get _backgroundColorLight {
    switch (level) {
      case RankLevel.newbie:
        return const Color(0xFFD4BEBE);
      case RankLevel.bronze:
        return const Color(0xFFFFBAA1);
      case RankLevel.silver:
        return const Color(0xFFCEDCE3);
      case RankLevel.gold:
        return const Color(0xFFFFE0A1);
      case RankLevel.diamond:
        return const Color(0xFFB7FFFB);
      case RankLevel.platinum:
        return const Color(0xFFB7B7FF);
    }
  }

  /// 스타일에 따른 배경색
  Color get _bgColor {
    return style == RankStyle.badgeLight
        ? _backgroundColorLight
        : _backgroundColor;
  }

  /// 스타일에 따른 텍스트 색상
  Color get _textColor {
    return style == RankStyle.badgeLight ? _backgroundColor : Colors.white;
  }

  /// 뱃지 스타일인지 여부 (아이콘 포함)
  bool get _showIcon => style != RankStyle.text;

  /// 등급별 아이콘 에셋 경로
  String? get _iconAsset {
    if (!_showIcon) return null;
    switch (level) {
      case RankLevel.newbie:
        return 'assets/icons/rank/newbie.png';
      case RankLevel.bronze:
        return 'assets/icons/rank/bronze.png';
      case RankLevel.silver:
        return 'assets/icons/rank/silver.png';
      case RankLevel.gold:
        return 'assets/icons/rank/gold.png';
      case RankLevel.diamond:
        return 'assets/icons/rank/diamond.png';
      case RankLevel.platinum:
        return 'assets/icons/rank/platinum.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _showIcon ? 4 : 4,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _label,
            style: const TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.05,
              height: 12 / 10,
            ).copyWith(color: _textColor),
          ),
          if (_showIcon) ...[
            const SizedBox(width: 4),
            _RankIcon(
              level: level,
              assetPath: _iconAsset,
            ),
          ],
        ],
      ),
    );
  }
}

/// 랭크 아이콘 위젯
class _RankIcon extends StatelessWidget {
  const _RankIcon({
    required this.level,
    this.assetPath,
  });

  final RankLevel level;
  final String? assetPath;

  double get _width {
    switch (level) {
      case RankLevel.gold:
        return 19;
      case RankLevel.diamond:
        return 20;
      case RankLevel.platinum:
        return 21;
      default:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (assetPath == null) {
      // 에셋이 없을 경우 기본 아이콘 표시
      return SizedBox(
        width: _width,
        height: 16,
        child: Icon(
          _getDefaultIcon(),
          size: 14,
          color: _getIconColor(),
        ),
      );
    }

    return SizedBox(
      width: _width,
      height: 16,
      child: Image.asset(
        assetPath!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // 에셋 로드 실패시 기본 아이콘 표시
          return Icon(
            _getDefaultIcon(),
            size: 14,
            color: _getIconColor(),
          );
        },
      ),
    );
  }

  IconData _getDefaultIcon() {
    switch (level) {
      case RankLevel.newbie:
        return Icons.person_outline;
      case RankLevel.bronze:
        return Icons.shield_outlined;
      case RankLevel.silver:
        return Icons.shield;
      case RankLevel.gold:
        return Icons.workspace_premium;
      case RankLevel.diamond:
        return Icons.diamond_outlined;
      case RankLevel.platinum:
        return Icons.military_tech;
    }
  }

  Color _getIconColor() {
    switch (level) {
      case RankLevel.newbie:
        return Colors.white70;
      case RankLevel.bronze:
        return const Color(0xFFFFDAC4);
      case RankLevel.silver:
        return Colors.white;
      case RankLevel.gold:
        return const Color(0xFFFFF5DC);
      case RankLevel.diamond:
        return Colors.white;
      case RankLevel.platinum:
        return const Color(0xFFDDDDFF);
    }
  }
}
