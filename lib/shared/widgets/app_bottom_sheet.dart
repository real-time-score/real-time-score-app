import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_button.dart';

/// 기본 바텀 시트
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.showHandle = true,
    this.showCloseButton = false,
    this.padding,
    this.maxHeight,
    this.isScrollable = false,
  });

  final String? title;
  final Widget child;
  final bool showHandle;
  final bool showCloseButton;
  final EdgeInsets? padding;
  final double? maxHeight;
  final bool isScrollable;

  /// 바텀 시트 표시
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool showHandle = true,
    bool showCloseButton = false,
    EdgeInsets? padding,
    double? maxHeight,
    bool isScrollable = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        title: title,
        showHandle: showHandle,
        showCloseButton: showCloseButton,
        padding: padding,
        maxHeight: maxHeight,
        isScrollable: isScrollable,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxSheetHeight = maxHeight ?? mediaQuery.size.height * 0.9;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 핸들 & 헤더
        if (showHandle || title != null || showCloseButton)
          _buildHeader(context),
        // 컨텐츠
        if (isScrollable)
          Flexible(
            child: SingleChildScrollView(
              padding: padding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
            ),
          )
        else
          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        // 하단 안전 영역
        SizedBox(height: mediaQuery.padding.bottom),
      ],
    );

    return Container(
      constraints: BoxConstraints(maxHeight: maxSheetHeight),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: content,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        children: [
          if (showHandle)
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (title != null || showCloseButton) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
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
          ],
        ],
      ),
    );
  }
}

/// 액션 바텀 시트 (버튼 포함)
class AppActionBottomSheet extends StatelessWidget {
  const AppActionBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.isPrimaryDisabled = false,
    this.showHandle = true,
  });

  final String? title;
  final Widget child;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool isPrimaryDisabled;
  final bool showHandle;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool isPrimaryDisabled = false,
    bool showHandle = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppActionBottomSheet(
        title: title,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        isPrimaryDisabled: isPrimaryDisabled,
        showHandle: showHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 핸들
          if (showHandle)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          // 헤더
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                title!,
                style: AppTextStyles.h4Bold,
              ),
            ),
          // 컨텐츠
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
          // 버튼 영역
          if (primaryButtonText != null || secondaryButtonText != null)
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + mediaQuery.padding.bottom),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
                ),
              ),
              child: Row(
                children: [
                  if (secondaryButtonText != null) ...[
                    Expanded(
                      child: AppButton.outlined(
                        text: secondaryButtonText!,
                        size: AppButtonSize.large,
                        onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (primaryButtonText != null)
                    Expanded(
                      child: AppButton(
                        text: primaryButtonText!,
                        status: isPrimaryDisabled ? AppButtonStatus.disabled : AppButtonStatus.active,
                        size: AppButtonSize.large,
                        onPressed: onPrimaryPressed,
                      ),
                    ),
                ],
              ),
            )
          else
            SizedBox(height: mediaQuery.padding.bottom),
        ],
      ),
    );
  }
}

/// 옵션 선택 바텀 시트
class AppOptionBottomSheet<T> extends StatelessWidget {
  const AppOptionBottomSheet({
    super.key,
    required this.options,
    required this.onSelected,
    this.title,
    this.selectedValue,
    this.showHandle = true,
  });

  final List<AppOptionItem<T>> options;
  final ValueChanged<T> onSelected;
  final String? title;
  final T? selectedValue;
  final bool showHandle;

  static Future<T?> show<T>(
    BuildContext context, {
    required List<AppOptionItem<T>> options,
    String? title,
    T? selectedValue,
    bool showHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AppOptionBottomSheet<T>(
        options: options,
        title: title,
        selectedValue: selectedValue,
        showHandle: showHandle,
        onSelected: (value) => Navigator.of(context).pop(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 핸들
          if (showHandle)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          // 헤더
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title!,
                style: AppTextStyles.h4Bold,
              ),
            ),
          // 옵션 리스트
          ...options.map((option) => _buildOptionItem(context, option)),
          // 하단 안전 영역
          SizedBox(height: mediaQuery.padding.bottom + 8),
        ],
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, AppOptionItem<T> option) {
    final isSelected = selectedValue == option.value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: option.isDisabled ? null : () => onSelected(option.value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (option.icon != null) ...[
                Icon(
                  option.icon,
                  size: 22,
                  color: option.isDisabled
                      ? AppColors.textHint
                      : (option.color ?? AppColors.textPrimary),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: option.isDisabled
                            ? AppColors.textHint
                            : (option.color ?? AppColors.textPrimary),
                      ),
                    ),
                    if (option.description != null)
                      Text(
                        option.description!,
                        style: AppTextStyles.caption1Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check,
                  size: 20,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 옵션 아이템
class AppOptionItem<T> {
  const AppOptionItem({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.color,
    this.isDisabled = false,
  });

  final T value;
  final String label;
  final String? description;
  final IconData? icon;
  final Color? color;
  final bool isDisabled;
}
