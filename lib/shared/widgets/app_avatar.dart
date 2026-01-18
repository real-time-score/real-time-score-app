import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 아바타 사이즈
enum AppAvatarSize {
  xs, // 24px
  sm, // 32px
  md, // 40px
  lg, // 48px
  xl, // 56px
  xxl, // 72px
}

/// 아바타 컴포넌트
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppAvatarSize.md,
    this.customSize,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isOnline,
    this.badge,
  });

  final String? imageUrl;
  final String? name;
  final AppAvatarSize size;
  final double? customSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool? isOnline;
  final Widget? badge;

  double _getSize() {
    if (customSize != null) return customSize!;
    switch (size) {
      case AppAvatarSize.xs:
        return 24;
      case AppAvatarSize.sm:
        return 32;
      case AppAvatarSize.md:
        return 40;
      case AppAvatarSize.lg:
        return 48;
      case AppAvatarSize.xl:
        return 56;
      case AppAvatarSize.xxl:
        return 72;
    }
  }

  double _getFontSize() {
    final avatarSize = _getSize();
    if (avatarSize <= 24) return 10;
    if (avatarSize <= 32) return 12;
    if (avatarSize <= 40) return 14;
    if (avatarSize <= 48) return 16;
    if (avatarSize <= 56) return 18;
    return 24;
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) return '?';
    final words = name!.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = _getSize();
    final bgColor = backgroundColor ?? AppColors.primary.withValues(alpha: 0.1);
    final fgColor = foregroundColor ?? AppColors.primary;

    Widget avatar = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: borderColor != null || borderWidth != null
            ? Border.all(
                color: borderColor ?? AppColors.border,
                width: borderWidth ?? 2,
              )
            : null,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                _getInitials(),
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: _getFontSize(),
                  fontWeight: FontWeight.w600,
                  color: fgColor,
                ),
              ),
            )
          : null,
    );

    // 온라인 상태 표시
    if (isOnline != null || badge != null) {
      avatar = Stack(
        children: [
          avatar,
          if (isOnline != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: avatarSize * 0.28,
                height: avatarSize * 0.28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline! ? AppColors.success : AppColors.textHint,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          if (badge != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: badge!,
            ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}

/// 아바타 그룹 (겹쳐진 아바타들)
class AppAvatarGroup extends StatelessWidget {
  const AppAvatarGroup({
    super.key,
    required this.avatars,
    this.maxDisplay = 4,
    this.size = AppAvatarSize.sm,
    this.overlapFactor = 0.3,
    this.onTap,
  });

  final List<AppAvatarData> avatars;
  final int maxDisplay;
  final AppAvatarSize size;
  final double overlapFactor;
  final VoidCallback? onTap;

  double _getSize() {
    switch (size) {
      case AppAvatarSize.xs:
        return 24;
      case AppAvatarSize.sm:
        return 32;
      case AppAvatarSize.md:
        return 40;
      case AppAvatarSize.lg:
        return 48;
      case AppAvatarSize.xl:
        return 56;
      case AppAvatarSize.xxl:
        return 72;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = _getSize();
    final overlap = avatarSize * overlapFactor;
    final displayCount = avatars.length > maxDisplay ? maxDisplay : avatars.length;
    final remaining = avatars.length - maxDisplay;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: avatarSize,
        width: avatarSize + (displayCount - 1) * (avatarSize - overlap) +
            (remaining > 0 ? avatarSize - overlap : 0),
        child: Stack(
          children: [
            for (int i = 0; i < displayCount; i++)
              Positioned(
                left: i * (avatarSize - overlap),
                child: AppAvatar(
                  imageUrl: avatars[i].imageUrl,
                  name: avatars[i].name,
                  size: size,
                  borderColor: Colors.white,
                  borderWidth: 2,
                ),
              ),
            if (remaining > 0)
              Positioned(
                left: displayCount * (avatarSize - overlap),
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '+$remaining',
                      style: AppTextStyles.caption1Bold.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 아바타 데이터 클래스
class AppAvatarData {
  const AppAvatarData({
    this.imageUrl,
    this.name,
  });

  final String? imageUrl;
  final String? name;
}

/// 팀 로고/엠블럼 아바타 (스포츠 앱용)
class AppTeamAvatar extends StatelessWidget {
  const AppTeamAvatar({
    super.key,
    this.imageUrl,
    required this.teamName,
    this.size = 40,
    this.backgroundColor,
    this.borderRadius,
  });

  final String? imageUrl;
  final String teamName;
  final double size;
  final Color? backgroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.contain,
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                teamName.isNotEmpty ? teamName[0].toUpperCase() : '?',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : null,
    );
  }
}
