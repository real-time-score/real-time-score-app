import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 기본 카드 컴포넌트
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.elevation = 0,
    this.shadowColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final Border? border;
  final double elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        border: border ?? Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withValues(alpha: 0.05),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          child: card,
        ),
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}

/// 리스트 아이템 카드
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.showDivider = false,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool showDivider;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: dense
                    ? AppTextStyles.body2NormalMedium
                    : AppTextStyles.body1NormalMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: AppTextStyles.caption1Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 12),
          trailing!,
        ],
      ],
    );

    Widget tile = Container(
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: 16,
        vertical: dense ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : null,
      ),
      child: content,
    );

    if (onTap != null) {
      tile = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
          child: tile,
        ),
      );
    }

    if (showDivider) {
      tile = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tile,
          const Divider(height: 1, indent: 16, endIndent: 16),
        ],
      );
    }

    return tile;
  }
}

/// 섹션 카드 (헤더 + 컨텐츠)
class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.action,
    this.padding,
    this.headerPadding,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  });

  final String title;
  final Widget child;
  final Widget? action;
  final EdgeInsets? padding;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: padding ?? EdgeInsets.zero,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: headerPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h4Bold,
                ),
                if (action != null) action!,
              ],
            ),
          ),
          Padding(
            padding: contentPadding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// 경기 카드 (스포츠 앱 전용)
class AppMatchCard extends StatelessWidget {
  const AppMatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore,
    this.awayScore,
    this.matchTime,
    this.league,
    this.status,
    this.isLive = false,
    this.onTap,
  });

  final String homeTeam;
  final String awayTeam;
  final int? homeScore;
  final int? awayScore;
  final String? matchTime;
  final String? league;
  final String? status;
  final bool isLive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 리그/시간 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (league != null)
                Text(
                  league!,
                  style: AppTextStyles.caption1Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              Row(
                children: [
                  if (isLive) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.live,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status ?? 'LIVE',
                      style: AppTextStyles.caption1Bold.copyWith(
                        color: AppColors.live,
                      ),
                    ),
                  ] else if (matchTime != null)
                    Text(
                      matchTime!,
                      style: AppTextStyles.caption1Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 팀 정보
          Row(
            children: [
              // 홈팀
              Expanded(
                child: Text(
                  homeTeam,
                  style: AppTextStyles.body1NormalMedium,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 스코어
              if (homeScore != null && awayScore != null) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isLive
                        ? AppColors.live.withValues(alpha: 0.1)
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        homeScore.toString(),
                        style: AppTextStyles.h3Bold.copyWith(
                          color: isLive ? AppColors.live : AppColors.textPrimary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          ':',
                          style: AppTextStyles.h3Bold.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        awayScore.toString(),
                        style: AppTextStyles.h3Bold.copyWith(
                          color: isLive ? AppColors.live : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ] else ...[
                const SizedBox(width: 12),
                Text(
                  'VS',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              // 어웨이팀
              Expanded(
                child: Text(
                  awayTeam,
                  style: AppTextStyles.body1NormalMedium,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 통계 카드
class AppStatCard extends StatelessWidget {
  const AppStatCard({
    super.key,
    required this.label,
    required this.value,
    this.subValue,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  final String label;
  final String value;
  final String? subValue;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.caption1Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 18,
                  color: iconColor ?? AppColors.textSecondary,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h2Bold,
          ),
          if (subValue != null) ...[
            const SizedBox(height: 4),
            Text(
              subValue!,
              style: AppTextStyles.caption1Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
