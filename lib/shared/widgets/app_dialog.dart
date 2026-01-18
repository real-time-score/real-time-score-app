import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_button.dart';

/// 기본 다이얼로그
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.content,
    this.contentWidget,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.isDanger = false,
    this.showCloseButton = false,
  });

  final String title;
  final String? content;
  final Widget? contentWidget;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool isDanger;
  final bool showCloseButton;

  /// 알림 다이얼로그 표시
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    String? content,
    String buttonText = '확인',
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        primaryButtonText: buttonText,
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          onPressed?.call();
        },
      ),
    );
  }

  /// 확인 다이얼로그 표시
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    String? content,
    String confirmText = '확인',
    String cancelText = '취소',
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        primaryButtonText: confirmText,
        secondaryButtonText: cancelText,
        isDanger: isDanger,
        onPrimaryPressed: () => Navigator.of(context).pop(true),
        onSecondaryPressed: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.h4Bold,
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
            // 컨텐츠
            if (content != null || contentWidget != null) ...[
              const SizedBox(height: 16),
              contentWidget ??
                  Text(
                    content!,
                    style: AppTextStyles.body1NormalRegular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
            ],
            // 버튼
            if (primaryButtonText != null || secondaryButtonText != null) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  if (secondaryButtonText != null) ...[
                    Expanded(
                      child: AppButton.outlined(
                        text: secondaryButtonText!,
                        onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (primaryButtonText != null)
                    Expanded(
                      child: isDanger
                          ? AppButton.error(
                              text: primaryButtonText!,
                              onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
                            )
                          : AppButton.primary(
                              text: primaryButtonText!,
                              onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
                            ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 로딩 다이얼로그
class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({
    super.key,
    this.message,
  });

  final String? message;

  static Future<void> show(BuildContext context, {String? message}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppLoadingDialog(message: message),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppColors.primary,
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: AppTextStyles.body1NormalMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
