import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 배지 타입
enum AppBadgeType {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  live,
  custom,
}

/// 배지 사이즈
enum AppBadgeSize {
  small, // height: 16
  medium, // height: 20
  large, // height: 24
}

/// 배지 컴포넌트
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.text,
    this.type = AppBadgeType.primary,
    this.size = AppBadgeSize.medium,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isOutlined = false,
  });

  final String text;
  final AppBadgeType type;
  final AppBadgeSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isOutlined;

  /// 라이브 배지 팩토리
  factory AppBadge.live({String text = 'LIVE'}) {
    return AppBadge(
      text: text,
      type: AppBadgeType.live,
      size: AppBadgeSize.small,
    );
  }

  /// 숫자 배지 팩토리
  factory AppBadge.count(int count, {AppBadgeType type = AppBadgeType.error}) {
    return AppBadge(
      text: count > 99 ? '99+' : count.toString(),
      type: type,
      size: AppBadgeSize.small,
    );
  }

  /// 상태 배지 팩토리
  factory AppBadge.status(String text, {required bool isActive}) {
    return AppBadge(
      text: text,
      type: isActive ? AppBadgeType.success : AppBadgeType.error,
      size: AppBadgeSize.small,
    );
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    if (isOutlined) return Colors.transparent;

    switch (type) {
      case AppBadgeType.primary:
        return AppColors.primary;
      case AppBadgeType.secondary:
        return AppColors.secondary;
      case AppBadgeType.success:
        return AppColors.success;
      case AppBadgeType.warning:
        return AppColors.warning;
      case AppBadgeType.error:
        return AppColors.error;
      case AppBadgeType.info:
        return AppColors.info;
      case AppBadgeType.live:
        return AppColors.live;
      case AppBadgeType.custom:
        return AppColors.primary;
    }
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    if (isOutlined) return _getBorderColor();
    return Colors.white;
  }

  Color _getBorderColor() {
    switch (type) {
      case AppBadgeType.primary:
        return AppColors.primary;
      case AppBadgeType.secondary:
        return AppColors.secondary;
      case AppBadgeType.success:
        return AppColors.success;
      case AppBadgeType.warning:
        return AppColors.warning;
      case AppBadgeType.error:
        return AppColors.error;
      case AppBadgeType.info:
        return AppColors.info;
      case AppBadgeType.live:
        return AppColors.live;
      case AppBadgeType.custom:
        return backgroundColor ?? AppColors.primary;
    }
  }

  double _getHeight() {
    switch (size) {
      case AppBadgeSize.small:
        return 16;
      case AppBadgeSize.medium:
        return 20;
      case AppBadgeSize.large:
        return 24;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 6);
      case AppBadgeSize.medium:
        return const EdgeInsets.symmetric(horizontal: 8);
      case AppBadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 10);
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppBadgeSize.small:
        return AppTextStyles.caption2Bold;
      case AppBadgeSize.medium:
        return AppTextStyles.caption1Bold;
      case AppBadgeSize.large:
        return AppTextStyles.label2Bold;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppBadgeSize.small:
        return 10;
      case AppBadgeSize.medium:
        return 12;
      case AppBadgeSize.large:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final fgColor = _getTextColor();

    return Container(
      height: _getHeight(),
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_getHeight() / 2),
        border: isOutlined ? Border.all(color: _getBorderColor()) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: _getIconSize(), color: fgColor),
            const SizedBox(width: 2),
          ],
          Text(
            text,
            style: _getTextStyle().copyWith(color: fgColor),
          ),
        ],
      ),
    );
  }
}

/// 도트 배지 (알림 표시용)
class AppDotBadge extends StatelessWidget {
  const AppDotBadge({
    super.key,
    required this.child,
    this.showBadge = true,
    this.count,
    this.color,
    this.position = AppDotBadgePosition.topRight,
    this.offset = const Offset(0, 0),
  });

  final Widget child;
  final bool showBadge;
  final int? count;
  final Color? color;
  final AppDotBadgePosition position;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    if (!showBadge) return child;

    final badgeColor = color ?? AppColors.error;
    final hasCount = count != null && count! > 0;
    final badgeSize = hasCount ? 16.0 : 8.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: position == AppDotBadgePosition.topRight ||
                  position == AppDotBadgePosition.topLeft
              ? -badgeSize / 3 + offset.dy
              : null,
          bottom: position == AppDotBadgePosition.bottomRight ||
                  position == AppDotBadgePosition.bottomLeft
              ? -badgeSize / 3 + offset.dy
              : null,
          right: position == AppDotBadgePosition.topRight ||
                  position == AppDotBadgePosition.bottomRight
              ? -badgeSize / 3 + offset.dx
              : null,
          left: position == AppDotBadgePosition.topLeft ||
                  position == AppDotBadgePosition.bottomLeft
              ? -badgeSize / 3 + offset.dx
              : null,
          child: Container(
            constraints: BoxConstraints(
              minWidth: badgeSize,
              minHeight: badgeSize,
            ),
            padding: hasCount ? const EdgeInsets.symmetric(horizontal: 4) : null,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(badgeSize / 2),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: hasCount
                ? Center(
                    child: Text(
                      count! > 99 ? '99+' : count.toString(),
                      style: AppTextStyles.caption2Bold.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

enum AppDotBadgePosition {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
}

/// 랭킹 배지 (1, 2, 3등)
class AppRankBadge extends StatelessWidget {
  const AppRankBadge({
    super.key,
    required this.rank,
    this.size = 24,
  });

  final int rank;
  final double size;

  Color _getColor() {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _getColor(),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            rank.toString(),
            style: AppTextStyles.caption1Bold.copyWith(
              color: rank <= 3 ? Colors.white : AppColors.textPrimary,
              fontSize: size * 0.5,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          rank.toString(),
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// 스코어 변동 배지 (상승/하락/동일)
class AppScoreChangeBadge extends StatelessWidget {
  const AppScoreChangeBadge({
    super.key,
    required this.change,
    this.showIcon = true,
    this.size = AppBadgeSize.small,
  });

  final int change;
  final bool showIcon;
  final AppBadgeSize size;

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData? icon;
    String text;

    if (change > 0) {
      color = AppColors.win;
      icon = Icons.arrow_drop_up;
      text = '+$change';
    } else if (change < 0) {
      color = AppColors.lose;
      icon = Icons.arrow_drop_down;
      text = change.toString();
    } else {
      color = AppColors.draw;
      icon = Icons.remove;
      text = '-';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) Icon(icon, color: color, size: 16),
        Text(
          text,
          style: AppTextStyles.caption1Bold.copyWith(color: color),
        ),
      ],
    );
  }
}
