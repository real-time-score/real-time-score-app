import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Figma 버튼 사이즈 정의
enum AppButtonSize {
  /// 32px height
  small,

  /// 40px height
  medium,

  /// 48px height
  large,
}

/// Figma 버튼 폰트 사이즈 정의
enum AppButtonFontSize {
  /// 14px
  small,

  /// 16px
  large,
}

/// Figma 버튼 상태(스타일) 정의
enum AppButtonStatus {
  /// 테두리만 있는 버튼 (배경 투명, border: #e7e9ec, text: labelNormal)
  noBg,

  /// Primary 버튼 (배경: #061667, text: white)
  active,

  /// Tonal 버튼 (배경: #f0f1f7, text: #061667)
  active2,

  /// Tonal Outlined 버튼 (배경: #f0f1f7 + border: #061667, text: #061667)
  active3,

  /// 비활성화 버튼 (배경: #e7e9ec, text: #b1b8c0)
  disabled,

  /// Hover 상태 버튼 (배경: #f2f3f5, text: #505866)
  hover,

  /// 에러/위험 버튼 (배경: #e6533e, text: white)
  error,

  /// 일반 버튼 (배경: #fafafb, text: #505866)
  normal,

  /// Contents 버튼 (배경: #6d7582, text: white)
  contents,

  /// Content2 버튼 (배경: #b1b8c0, text: white)
  content2,

  /// Neutral 버튼 (배경: #e7e9ec(48/40) or #f3f4f8(32), text: #505866)
  neutral,
}

/// Figma 디자인 시스템 기반 앱 공통 버튼 컴포넌트
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.status = AppButtonStatus.active,
    this.size = AppButtonSize.large,
    this.fontSize = AppButtonFontSize.large,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
    this.icon,
    this.svgIcon,
    this.showIcon = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonStatus status;
  final AppButtonSize size;
  final AppButtonFontSize fontSize;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final IconData? icon;
  final String? svgIcon;
  final bool showIcon;

  /// 실제 사용할 상태
  AppButtonStatus get _effectiveStatus {
    if (isDisabled) {
      return AppButtonStatus.disabled;
    }
    return status;
  }

  /// noBg (Outlined) 스타일 버튼 팩토리
  factory AppButton.outlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.noBg,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Primary (active) 스타일 버튼 팩토리
  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.active,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Tonal (active2) 스타일 버튼 팩토리
  factory AppButton.tonal({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.active2,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Tonal Outlined (active3) 스타일 버튼 팩토리
  factory AppButton.tonalOutlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.active3,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Error 스타일 버튼 팩토리
  factory AppButton.error({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.error,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Normal 스타일 버튼 팩토리
  factory AppButton.normal({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.normal,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Neutral 스타일 버튼 팩토리
  factory AppButton.neutral({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.neutral,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  /// Contents 스타일 버튼 팩토리
  factory AppButton.contents({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.large,
    AppButtonFontSize fontSize = AppButtonFontSize.large,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      status: AppButtonStatus.contents,
      size: size,
      fontSize: fontSize,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      svgIcon: svgIcon,
      showIcon: showIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStatus = _effectiveStatus;
    final isDisabledStatus = effectiveStatus == AppButtonStatus.disabled;
    final isEnabled = !isDisabledStatus && !isLoading && onPressed != null;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: Material(
        color: _getBackgroundColor(effectiveStatus),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: _getBorder(effectiveStatus),
            ),
            child: _buildContent(effectiveStatus),
          ),
        ),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  Color _getBackgroundColor(AppButtonStatus effectiveStatus) {
    switch (effectiveStatus) {
      case AppButtonStatus.noBg:
        return Colors.transparent;
      case AppButtonStatus.active:
        return AppColors.primaryFigma;
      case AppButtonStatus.active2:
      case AppButtonStatus.active3:
        return AppColors.primaryContainer;
      case AppButtonStatus.disabled:
        return AppColors.containerDisabled;
      case AppButtonStatus.hover:
        return AppColors.containerHover;
      case AppButtonStatus.error:
        return AppColors.negative;
      case AppButtonStatus.normal:
        return AppColors.containerNormal;
      case AppButtonStatus.contents:
        return AppColors.contentsNeutral;
      case AppButtonStatus.content2:
        return AppColors.contentsNormal;
      case AppButtonStatus.neutral:
        return size == AppButtonSize.small
            ? AppColors.containerNeutral
            : AppColors.containerAlternative;
    }
  }

  Border? _getBorder(AppButtonStatus effectiveStatus) {
    switch (effectiveStatus) {
      case AppButtonStatus.noBg:
        return Border.all(color: AppColors.borderNormal, width: 1);
      case AppButtonStatus.active3:
        return Border.all(color: AppColors.primaryFigma, width: 1);
      default:
        return null;
    }
  }

  Color _getTextColor(AppButtonStatus effectiveStatus) {
    switch (effectiveStatus) {
      case AppButtonStatus.noBg:
        return AppColors.labelNormal;
      case AppButtonStatus.active:
      case AppButtonStatus.error:
      case AppButtonStatus.contents:
      case AppButtonStatus.content2:
        return AppColors.white;
      case AppButtonStatus.active2:
      case AppButtonStatus.active3:
        return AppColors.primaryFigma;
      case AppButtonStatus.disabled:
        return AppColors.labelDisabled;
      case AppButtonStatus.hover:
      case AppButtonStatus.normal:
      case AppButtonStatus.neutral:
        return AppColors.labelNeutral;
    }
  }

  TextStyle _getTextStyle(AppButtonStatus effectiveStatus) {
    final color = _getTextColor(effectiveStatus);
    final isBold = _isBoldStatus(effectiveStatus);

    if (fontSize == AppButtonFontSize.large) {
      // 16px, lineHeight 24px
      return isBold
          ? AppTextStyles.body1NormalBold.copyWith(color: color)
          : AppTextStyles.body1NormalMedium.copyWith(color: color);
    } else {
      // 14px, lineHeight 20px
      return AppTextStyles.label1NormalMedium.copyWith(color: color);
    }
  }

  bool _isBoldStatus(AppButtonStatus effectiveStatus) {
    switch (effectiveStatus) {
      case AppButtonStatus.active:
      case AppButtonStatus.active2:
      case AppButtonStatus.active3:
      case AppButtonStatus.disabled:
      case AppButtonStatus.error:
      case AppButtonStatus.contents:
      case AppButtonStatus.content2:
        return true;
      case AppButtonStatus.noBg:
      case AppButtonStatus.hover:
      case AppButtonStatus.normal:
      case AppButtonStatus.neutral:
        return false;
    }
  }

  Widget _buildContent(AppButtonStatus effectiveStatus) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(effectiveStatus)),
          ),
        ),
      );
    }

    final iconColor = _getTextColor(effectiveStatus);
    final textStyle = _getTextStyle(effectiveStatus);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showIcon && (icon != null || svgIcon != null)) ...[
          if (icon != null)
            Icon(icon, size: 24, color: iconColor)
          else if (svgIcon != null)
            SvgPicture.asset(
              svgIcon!,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// 아이콘 전용 버튼
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.svgIcon,
    this.size = 40,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.borderRadius,
    this.border,
    this.isDisabled = false,
    this.tooltip,
  }) : assert(icon != null || svgIcon != null, 'Either icon or svgIcon must be provided');

  final VoidCallback? onPressed;
  final IconData? icon;
  final String? svgIcon;
  final double size;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderRadius;
  final Border? border;
  final bool isDisabled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && onPressed != null;
    final effectiveIconSize = iconSize ?? (size * 0.5);
    final effectiveIconColor = iconColor ?? (isEnabled ? AppColors.labelNormal : AppColors.labelDisabled);

    Widget button = Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
            border: border,
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, size: effectiveIconSize, color: effectiveIconColor)
                : SvgPicture.asset(
                    svgIcon!,
                    width: effectiveIconSize,
                    height: effectiveIconSize,
                    colorFilter: ColorFilter.mode(effectiveIconColor, BlendMode.srcIn),
                  ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// 텍스트 버튼 (밑줄 있는 링크 스타일)
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textStyle,
    this.underline = false,
    this.isDisabled = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final bool underline;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && onPressed != null;
    final effectiveColor = color ?? (isEnabled ? AppColors.primaryFigma : AppColors.labelDisabled);
    final effectiveStyle = (textStyle ?? AppTextStyles.label1NormalMedium).copyWith(
      color: effectiveColor,
      decoration: underline ? TextDecoration.underline : null,
      decorationColor: effectiveColor,
    );

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Text(text, style: effectiveStyle),
    );
  }
}

/// 토글 버튼
class AppToggleButton extends StatelessWidget {
  const AppToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.text,
    this.size = AppButtonSize.medium,
    this.selectedColor,
    this.unselectedColor,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final String text;
  final AppButtonSize size;
  final Color? selectedColor;
  final Color? unselectedColor;

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? (selectedColor ?? AppColors.primaryFigma)
        : (unselectedColor ?? AppColors.containerNormal);
    final textColor = isSelected ? AppColors.white : AppColors.labelNeutral;
    final borderColor = isSelected ? Colors.transparent : AppColors.borderNormal;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _getHeight(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.body1NormalMedium.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

/// FAB (Floating Action Button)
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.onPressed,
    this.icon,
    this.svgIcon,
    this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.isExtended = false,
    this.size = 56,
  }) : assert(icon != null || svgIcon != null, 'Either icon or svgIcon must be provided');

  final VoidCallback onPressed;
  final IconData? icon;
  final String? svgIcon;
  final String? text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isExtended;
  final double size;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primaryFigma;
    final fgColor = foregroundColor ?? AppColors.white;

    if (isExtended && text != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        icon: icon != null
            ? Icon(icon, color: fgColor)
            : SvgPicture.asset(
                svgIcon!,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
              ),
        label: Text(text!, style: AppTextStyles.body1NormalMedium.copyWith(color: fgColor)),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 4,
        child: icon != null
            ? Icon(icon, color: fgColor, size: size * 0.43)
            : SvgPicture.asset(
                svgIcon!,
                width: size * 0.43,
                height: size * 0.43,
                colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
              ),
      ),
    );
  }
}

/// 소셜 로그인 버튼
class AppSocialButton extends StatelessWidget {
  const AppSocialButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.text,
    this.isLoading = false,
    this.size = AppButtonSize.large,
  });

  final AppSocialType type;
  final VoidCallback onPressed;
  final String? text;
  final bool isLoading;
  final AppButtonSize size;

  factory AppSocialButton.kakao({
    required VoidCallback onPressed,
    String? text,
    bool isLoading = false,
  }) {
    return AppSocialButton(
      type: AppSocialType.kakao,
      onPressed: onPressed,
      text: text ?? '카카오로 시작하기',
      isLoading: isLoading,
    );
  }

  factory AppSocialButton.apple({
    required VoidCallback onPressed,
    String? text,
    bool isLoading = false,
  }) {
    return AppSocialButton(
      type: AppSocialType.apple,
      onPressed: onPressed,
      text: text ?? 'Apple로 시작하기',
      isLoading: isLoading,
    );
  }

  factory AppSocialButton.google({
    required VoidCallback onPressed,
    String? text,
    bool isLoading = false,
  }) {
    return AppSocialButton(
      type: AppSocialType.google,
      onPressed: onPressed,
      text: text ?? 'Google로 시작하기',
      isLoading: isLoading,
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case AppSocialType.kakao:
        return const Color(0xFFFEE500);
      case AppSocialType.apple:
        return Colors.black;
      case AppSocialType.google:
        return AppColors.white;
      case AppSocialType.naver:
        return const Color(0xFF03C75A);
    }
  }

  Color get _foregroundColor {
    switch (type) {
      case AppSocialType.kakao:
        return const Color(0xFF191919);
      case AppSocialType.apple:
        return AppColors.white;
      case AppSocialType.google:
        return const Color(0xFF191919);
      case AppSocialType.naver:
        return AppColors.white;
    }
  }

  String get _iconPath {
    switch (type) {
      case AppSocialType.kakao:
        return 'assets/icons/logo_kakao.svg';
      case AppSocialType.apple:
        return 'assets/icons/logo_apple.svg';
      case AppSocialType.google:
        return 'assets/icons/logo_google_play.svg';
      case AppSocialType.naver:
        return 'assets/icons/logo_naver_blog.svg';
    }
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 40;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 52;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          elevation: type == AppSocialType.google ? 1 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: type == AppSocialType.google
                ? const BorderSide(color: AppColors.borderNormal)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _iconPath,
                    width: 20,
                    height: 20,
                    colorFilter: type == AppSocialType.apple
                        ? ColorFilter.mode(_foregroundColor, BlendMode.srcIn)
                        : null,
                  ),
                  if (text != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      text!,
                      style: AppTextStyles.body1NormalMedium.copyWith(color: _foregroundColor),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

enum AppSocialType { kakao, apple, google, naver }

/// 좋아요/북마크 버튼
class AppLikeButton extends StatelessWidget {
  const AppLikeButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
    this.likeCount,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
    this.showCount = true,
  });

  final bool isLiked;
  final VoidCallback onPressed;
  final int? likeCount;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    final color = isLiked
        ? (activeColor ?? AppColors.negative)
        : (inactiveColor ?? AppColors.labelNeutral);

    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isLiked),
              size: size,
              color: color,
            ),
          ),
          if (showCount && likeCount != null) ...[
            const SizedBox(width: 4),
            Text(
              _formatCount(likeCount!),
              style: AppTextStyles.caption1Medium.copyWith(color: color),
            ),
          ],
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}만';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}천';
    }
    return count.toString();
  }
}

/// 북마크 버튼
class AppBookmarkButton extends StatelessWidget {
  const AppBookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
  });

  final bool isBookmarked;
  final VoidCallback onPressed;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final color = isBookmarked
        ? (activeColor ?? AppColors.yellow)
        : (inactiveColor ?? AppColors.labelNeutral);

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          key: ValueKey(isBookmarked),
          size: size,
          color: color,
        ),
      ),
    );
  }
}

/// 팔로우 버튼
class AppFollowButton extends StatelessWidget {
  const AppFollowButton({
    super.key,
    required this.isFollowing,
    required this.onPressed,
    this.size = AppButtonSize.small,
    this.followText = '팔로우',
    this.followingText = '팔로잉',
    this.isLoading = false,
  });

  final bool isFollowing;
  final VoidCallback onPressed;
  final AppButtonSize size;
  final String followText;
  final String followingText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isFollowing) {
      return AppButton.outlined(
        text: followingText,
        size: size,
        isLoading: isLoading,
        onPressed: onPressed,
      );
    }

    return AppButton.primary(
      text: followText,
      size: size,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}

/// 카운터 버튼 (+/-)
class AppCounterButton extends StatelessWidget {
  const AppCounterButton({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.minValue = 0,
    this.maxValue = 99,
    this.size = 32,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minValue;
  final int maxValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(
          icon: Icons.remove,
          onPressed: value > minValue ? onDecrement : null,
        ),
        Container(
          width: size * 1.5,
          alignment: Alignment.center,
          child: Text(
            value.toString(),
            style: AppTextStyles.body1NormalBold,
          ),
        ),
        _buildButton(
          icon: Icons.add,
          onPressed: value < maxValue ? onIncrement : null,
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final isEnabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.containerNormal : AppColors.containerNormal.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(size / 4),
          border: Border.all(
            color: isEnabled ? AppColors.borderNormal : AppColors.borderNormal.withValues(alpha: 0.5),
          ),
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: isEnabled ? AppColors.labelNormal : AppColors.labelDisabled,
        ),
      ),
    );
  }
}

/// 뒤로가기 버튼 상태 정의 (Figma 기반)
enum AppBackButtonStatus {
  /// 기본 상태 (검정 아이콘, 투명 배경)
  defaultStatus,

  /// 선택 상태 (검정 아이콘, #fafafb 배경)
  selected,

  /// 비활성화 상태 (회색 아이콘, 투명 배경)
  disabled,

  /// 에러 상태 (빨간 아이콘, 투명 배경)
  error,

  /// Primary 상태 (파란 아이콘, 투명 배경)
  primary,
}

/// 뒤로가기 버튼 크기 정의 (Figma 기반)
enum AppBackButtonSize {
  /// 32px
  small,

  /// 48px
  large,
}

/// Figma 디자인 기반 뒤로가기 버튼 컴포넌트
///
/// 대부분의 경우 뒤로가기 기능을 표현할 때 사용됩니다.
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.status = AppBackButtonStatus.defaultStatus,
    this.size = AppBackButtonSize.large,
    this.svgIcon,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final AppBackButtonStatus status;
  final AppBackButtonSize size;
  /// 커스텀 아이콘 경로 (기본값: chevron_left.svg)
  final String? svgIcon;
  final String? tooltip;

  /// 기본 뒤로가기 버튼
  factory AppBackButton.defaultButton({
    Key? key,
    VoidCallback? onPressed,
    AppBackButtonSize size = AppBackButtonSize.large,
    String? tooltip,
  }) {
    return AppBackButton(
      key: key,
      onPressed: onPressed,
      status: AppBackButtonStatus.defaultStatus,
      size: size,
      tooltip: tooltip,
    );
  }

  /// 배경이 있는 뒤로가기 버튼 (selected 상태)
  factory AppBackButton.filled({
    Key? key,
    VoidCallback? onPressed,
    AppBackButtonSize size = AppBackButtonSize.large,
    String? tooltip,
  }) {
    return AppBackButton(
      key: key,
      onPressed: onPressed,
      status: AppBackButtonStatus.selected,
      size: size,
      tooltip: tooltip,
    );
  }

  /// 비활성화된 뒤로가기 버튼
  factory AppBackButton.disabled({
    Key? key,
    AppBackButtonSize size = AppBackButtonSize.large,
    String? tooltip,
  }) {
    return AppBackButton(
      key: key,
      onPressed: null,
      status: AppBackButtonStatus.disabled,
      size: size,
      tooltip: tooltip,
    );
  }

  /// 에러 상태 뒤로가기 버튼
  factory AppBackButton.error({
    Key? key,
    VoidCallback? onPressed,
    AppBackButtonSize size = AppBackButtonSize.large,
    String? tooltip,
  }) {
    return AppBackButton(
      key: key,
      onPressed: onPressed,
      status: AppBackButtonStatus.error,
      size: size,
      tooltip: tooltip,
    );
  }

  /// Primary 상태 뒤로가기 버튼
  factory AppBackButton.primary({
    Key? key,
    VoidCallback? onPressed,
    AppBackButtonSize size = AppBackButtonSize.large,
    String? tooltip,
  }) {
    return AppBackButton(
      key: key,
      onPressed: onPressed,
      status: AppBackButtonStatus.primary,
      size: size,
      tooltip: tooltip,
    );
  }

  double _getSize() {
    switch (size) {
      case AppBackButtonSize.small:
        return 32;
      case AppBackButtonSize.large:
        return 48;
    }
  }

  Color _getIconColor() {
    switch (status) {
      case AppBackButtonStatus.defaultStatus:
      case AppBackButtonStatus.selected:
        return AppColors.labelNormal;
      case AppBackButtonStatus.disabled:
        return AppColors.labelDisabled;
      case AppBackButtonStatus.error:
        return AppColors.negative;
      case AppBackButtonStatus.primary:
        return AppColors.positive;
    }
  }

  Color _getBackgroundColor() {
    switch (status) {
      case AppBackButtonStatus.selected:
        return AppColors.containerNormal;
      case AppBackButtonStatus.defaultStatus:
      case AppBackButtonStatus.disabled:
      case AppBackButtonStatus.error:
      case AppBackButtonStatus.primary:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getSize();
    final iconColor = _getIconColor();
    final backgroundColor = _getBackgroundColor();
    final isEnabled = status != AppBackButtonStatus.disabled && onPressed != null;
    final iconPath = svgIcon ?? 'assets/icons/chevron_left.svg';

    Widget button = Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// 버튼 그룹 (수평 버튼 세트)
class AppButtonGroup extends StatelessWidget {
  const AppButtonGroup({
    super.key,
    required this.buttons,
    required this.selectedIndex,
    required this.onSelected,
    this.size = AppButtonSize.medium,
    this.isFullWidth = false,
  });

  final List<String> buttons;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final AppButtonSize size;
  final bool isFullWidth;

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getHeight(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: buttons.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          final isSelected = index == selectedIndex;
          final isFirst = index == 0;
          final isLast = index == buttons.length - 1;

          return Expanded(
            flex: isFullWidth ? 1 : 0,
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: isFirst ? const Radius.circular(7) : Radius.zero,
                    right: isLast ? const Radius.circular(7) : Radius.zero,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: isSelected ? AppColors.white : AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 라디오 버튼
class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.activeColor,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;
  final String? label;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final color = activeColor ?? AppColors.primaryFigma;

    return GestureDetector(
      onTap: () => onChanged(value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? color : AppColors.borderNormal,
                width: isSelected ? 6 : 2,
              ),
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              label!,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: isSelected ? AppColors.labelNormal : AppColors.labelNeutral,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 듀얼 버튼 세트 (Figma: 왼쪽 Normal + 오른쪽 Primary 조합)
///
/// 두 버튼이 나란히 배치되는 패턴입니다.
/// 왼쪽은 보조 액션(취소 등), 오른쪽은 주요 액션(확인 등)에 사용됩니다.
class AppDualButton extends StatelessWidget {
  const AppDualButton({
    super.key,
    required this.leftText,
    required this.rightText,
    this.onLeftPressed,
    this.onRightPressed,
    this.leftWidth = 121,
    this.spacing = 8,
    this.leftStatus = AppButtonStatus.normal,
    this.rightStatus = AppButtonStatus.active,
    this.isLeftLoading = false,
    this.isRightLoading = false,
  });

  final String leftText;
  final String rightText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;
  final double leftWidth;
  final double spacing;
  final AppButtonStatus leftStatus;
  final AppButtonStatus rightStatus;
  final bool isLeftLoading;
  final bool isRightLoading;

  /// 취소/확인 패턴 팩토리
  factory AppDualButton.cancelConfirm({
    Key? key,
    String cancelText = '취소',
    String confirmText = '확인',
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isCancelLoading = false,
    bool isConfirmLoading = false,
  }) {
    return AppDualButton(
      key: key,
      leftText: cancelText,
      rightText: confirmText,
      onLeftPressed: onCancel,
      onRightPressed: onConfirm,
      isLeftLoading: isCancelLoading,
      isRightLoading: isConfirmLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 왼쪽 버튼 (고정 너비)
        SizedBox(
          width: leftWidth,
          child: AppButton(
            text: leftText,
            onPressed: onLeftPressed,
            status: leftStatus,
            isLoading: isLeftLoading,
            isFullWidth: true,
          ),
        ),
        SizedBox(width: spacing),
        // 오른쪽 버튼 (나머지 공간)
        Expanded(
          child: AppButton(
            text: rightText,
            onPressed: onRightPressed,
            status: rightStatus,
            isLoading: isRightLoading,
            isFullWidth: true,
          ),
        ),
      ],
    );
  }
}

/// 하단 고정 버튼 컨테이너 (Figma: 그라데이션 배경 + 버튼)
///
/// 화면 하단에 고정되는 버튼 영역입니다.
/// 상단에서 투명 → 흰색으로 그라데이션 효과가 있습니다.
class AppBottomButtonContainer extends StatelessWidget {
  const AppBottomButtonContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showGradient = true,
    this.gradientHeight = 24,
    this.backgroundColor = AppColors.white,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool showGradient;
  final double gradientHeight;
  final Color backgroundColor;

  /// 단일 버튼 팩토리
  factory AppBottomButtonContainer.single({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonStatus status = AppButtonStatus.active,
    bool isLoading = false,
    IconData? icon,
    String? svgIcon,
    bool showIcon = false,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    bool showGradient = true,
  }) {
    return AppBottomButtonContainer(
      key: key,
      padding: padding,
      showGradient: showGradient,
      child: AppButton(
        text: text,
        onPressed: onPressed,
        status: status,
        isLoading: isLoading,
        isFullWidth: true,
        icon: icon,
        svgIcon: svgIcon,
        showIcon: showIcon,
      ),
    );
  }

  /// 듀얼 버튼 팩토리
  factory AppBottomButtonContainer.dual({
    Key? key,
    required String leftText,
    required String rightText,
    VoidCallback? onLeftPressed,
    VoidCallback? onRightPressed,
    double leftWidth = 121,
    bool isLeftLoading = false,
    bool isRightLoading = false,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    bool showGradient = false,
  }) {
    return AppBottomButtonContainer(
      key: key,
      padding: padding,
      showGradient: showGradient,
      child: AppDualButton(
        leftText: leftText,
        rightText: rightText,
        onLeftPressed: onLeftPressed,
        onRightPressed: onRightPressed,
        leftWidth: leftWidth,
        isLeftLoading: isLeftLoading,
        isRightLoading: isRightLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 그라데이션 영역
        if (showGradient)
          Container(
            height: gradientHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColor.withValues(alpha: 0),
                  backgroundColor,
                ],
                stops: const [0.0, 0.6],
              ),
            ),
          ),
        // 버튼 영역
        Container(
          color: backgroundColor,
          padding: padding,
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ],
    );
  }
}

/// 스위치 버튼
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Expanded(
            child: Text(
              label!,
              style: AppTextStyles.body1NormalMedium,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: activeColor ?? AppColors.primaryFigma,
          activeTrackColor: (activeColor ?? AppColors.primaryFigma).withValues(alpha: 0.5),
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: AppColors.borderNormal,
        ),
      ],
    );
  }
}

// ============================================
// LEGACY SUPPORT - 기존 코드 호환성을 위한 타입 별칭
// ============================================

/// @deprecated Use AppButtonSize instead
@Deprecated('Use AppButtonSize instead')
typedef LegacyAppButtonSize = AppButtonSize;
