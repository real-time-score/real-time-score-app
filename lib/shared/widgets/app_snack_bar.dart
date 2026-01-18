import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 스낵바 상태 타입
enum AppSnackBarStatus {
  /// 실패/에러 상태 (빨간색 아이콘)
  negative,

  /// 성공 상태 (초록색 아이콘)
  positive,
}

/// 스낵바 컴포넌트
///
/// Figma 디자인 기반의 커스텀 스낵바 위젯입니다.
/// - 검은색 배경에 둥근 모서리 (24px)
/// - 상태에 따른 아이콘 색상 (negative: 빨간색, positive: 초록색)
/// - 흰색 텍스트
class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    super.key,
    required this.message,
    this.status = AppSnackBarStatus.negative,
  });

  /// 표시할 메시지
  final String message;

  /// 스낵바 상태 (negative/positive)
  final AppSnackBarStatus status;

  /// 성공 스낵바 팩토리
  factory AppSnackBar.positive(String message) {
    return AppSnackBar(
      message: message,
      status: AppSnackBarStatus.positive,
    );
  }

  /// 실패 스낵바 팩토리
  factory AppSnackBar.negative(String message) {
    return AppSnackBar(
      message: message,
      status: AppSnackBarStatus.negative,
    );
  }

  Color _getIconColor() {
    switch (status) {
      case AppSnackBarStatus.negative:
        return AppColors.negative;
      case AppSnackBarStatus.positive:
        return AppColors.positiveGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 원형 체크 아이콘
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getIconColor(),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          // 메시지 텍스트
          Flexible(
            child: Text(
              message,
              style: AppTextStyles.label1NormalMedium.copyWith(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// 스낵바 표시 헬퍼 함수들
class AppSnackBarHelper {
  AppSnackBarHelper._();

  /// 성공 스낵바 표시
  static void showPositive(BuildContext context, String message) {
    _showSnackBar(context, message, AppSnackBarStatus.positive);
  }

  /// 실패 스낵바 표시
  static void showNegative(BuildContext context, String message) {
    _showSnackBar(context, message, AppSnackBarStatus.negative);
  }

  /// 커스텀 스낵바 표시
  static void show(
    BuildContext context,
    String message, {
    AppSnackBarStatus status = AppSnackBarStatus.negative,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(context, message, status, duration: duration);
  }

  static void _showSnackBar(
    BuildContext context,
    String message,
    AppSnackBarStatus status, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: AppSnackBar(
            message: message,
            status: status,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        margin: const EdgeInsets.only(
          bottom: 24,
          left: 16,
          right: 16,
        ),
      ),
    );
  }
}

/// BuildContext extension으로 간편하게 스낵바 표시
extension AppSnackBarExtension on BuildContext {
  /// 성공 스낵바 표시
  void showSuccessSnackBar(String message) {
    AppSnackBarHelper.showPositive(this, message);
  }

  /// 실패 스낵바 표시
  void showErrorSnackBar(String message) {
    AppSnackBarHelper.showNegative(this, message);
  }

  /// 커스텀 스낵바 표시
  void showSnackBar(
    String message, {
    AppSnackBarStatus status = AppSnackBarStatus.negative,
    Duration duration = const Duration(seconds: 3),
  }) {
    AppSnackBarHelper.show(this, message, status: status, duration: duration);
  }
}
