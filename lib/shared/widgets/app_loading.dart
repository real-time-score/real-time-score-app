import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 로딩 인디케이터
class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.size = 40,
    this.color,
    this.strokeWidth = 3,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }
}

/// 전체 화면 로딩
class AppFullScreenLoading extends StatelessWidget {
  const AppFullScreenLoading({
    super.key,
    this.message,
    this.backgroundColor,
  });

  final String? message;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLoading(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 인라인 로딩 (리스트 등에서 사용)
class AppInlineLoading extends StatelessWidget {
  const AppInlineLoading({
    super.key,
    this.message,
    this.padding,
  });

  final String? message;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLoading(size: 20, strokeWidth: 2),
          if (message != null) ...[
            const SizedBox(width: 12),
            Text(
              message!,
              style: AppTextStyles.body2NormalRegular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 스켈레톤 로더 (쉬머 효과)
class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
  });

  final double? width;
  final double height;
  final double? borderRadius;
  final bool isCircle;

  /// 텍스트용 스켈레톤
  factory AppSkeleton.text({double? width, double height = 14}) {
    return AppSkeleton(
      width: width,
      height: height,
      borderRadius: 4,
    );
  }

  /// 아바타용 스켈레톤
  factory AppSkeleton.avatar({double size = 40}) {
    return AppSkeleton(
      width: size,
      height: size,
      isCircle: true,
    );
  }

  /// 카드용 스켈레톤
  factory AppSkeleton.card({double? width, double height = 120}) {
    return AppSkeleton(
      width: width,
      height: height,
      borderRadius: 12,
    );
  }

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle
                ? null
                : BorderRadius.circular(widget.borderRadius ?? 8),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 빈 상태 화면
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.message,
    this.description,
    this.icon,
    this.iconWidget,
    this.action,
    this.actionText,
    this.onAction,
  });

  final String message;
  final String? description;
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? action;
  final String? actionText;
  final VoidCallback? onAction;

  /// 검색 결과 없음
  factory AppEmptyState.noSearchResults({
    String message = '검색 결과가 없습니다',
    String? description,
  }) {
    return AppEmptyState(
      message: message,
      description: description,
      icon: Icons.search_off_outlined,
    );
  }

  /// 데이터 없음
  factory AppEmptyState.noData({
    String message = '데이터가 없습니다',
    String? description,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return AppEmptyState(
      message: message,
      description: description,
      icon: Icons.inbox_outlined,
      actionText: actionText,
      onAction: onAction,
    );
  }

  /// 네트워크 오류
  factory AppEmptyState.networkError({
    String message = '네트워크 오류가 발생했습니다',
    String? description = '인터넷 연결을 확인해주세요',
    String actionText = '다시 시도',
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      message: message,
      description: description,
      icon: Icons.wifi_off_outlined,
      actionText: actionText,
      onAction: onRetry,
    );
  }

  /// 오류 상태
  factory AppEmptyState.error({
    String message = '오류가 발생했습니다',
    String? description,
    String actionText = '다시 시도',
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      message: message,
      description: description,
      icon: Icons.error_outline,
      actionText: actionText,
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 아이콘
            if (iconWidget != null)
              iconWidget!
            else if (icon != null)
              Icon(
                icon,
                size: 64,
                color: AppColors.textHint,
              ),
            const SizedBox(height: 16),
            // 메시지
            Text(
              message,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            // 설명
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                style: AppTextStyles.body2NormalRegular.copyWith(
                  color: AppColors.textHint,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            // 액션
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ] else if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              TextButton(
                onPressed: onAction,
                child: Text(
                  actionText!,
                  style: AppTextStyles.button.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 새로고침 인디케이터
class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.primary,
      backgroundColor: backgroundColor ?? AppColors.surface,
      child: child,
    );
  }
}
