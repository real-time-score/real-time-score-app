import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';
import 'app_button.dart';

/// 모달 타입
enum AppModalType {
  alert, // 단순 알림
  confirm, // 확인/취소
  input, // 입력 모달
  custom, // 커스텀
}

/// 모달 사이즈
enum AppModalSize {
  small, // width: 280
  medium, // width: 320
  large, // width: 360
  fullWidth, // 화면 너비 - 32
}

/// 기본 모달 컴포넌트
class AppModal extends StatelessWidget {
  const AppModal({
    super.key,
    this.title,
    this.message,
    this.content,
    this.icon,
    this.svgIcon,
    this.iconColor,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.primaryButtonType = AppButtonType.primary,
    this.size = AppModalSize.medium,
    this.showCloseButton = false,
    this.isDismissible = true,
    this.padding,
  });

  final String? title;
  final String? message;
  final Widget? content;
  final IconData? icon;
  final String? svgIcon;
  final Color? iconColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final AppButtonType primaryButtonType;
  final AppModalSize size;
  final bool showCloseButton;
  final bool isDismissible;
  final EdgeInsets? padding;

  double _getWidth(BuildContext context) {
    switch (size) {
      case AppModalSize.small:
        return 280;
      case AppModalSize.medium:
        return 320;
      case AppModalSize.large:
        return 360;
      case AppModalSize.fullWidth:
        return MediaQuery.of(context).size.width - 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: _getWidth(context),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 닫기 버튼
            if (showCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppIcons.close,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            // 컨텐츠
            Padding(
              padding: padding ?? EdgeInsets.fromLTRB(
                24,
                showCloseButton ? 0 : 32,
                24,
                24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 아이콘
                  if (icon != null || svgIcon != null) ...[
                    _buildIcon(),
                    const SizedBox(height: 16),
                  ],
                  // 제목
                  if (title != null) ...[
                    Text(
                      title!,
                      style: AppTextStyles.h4Bold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                  // 메시지
                  if (message != null)
                    Text(
                      message!,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  // 커스텀 컨텐츠
                  if (content != null) ...[
                    if (title != null || message != null) const SizedBox(height: 16),
                    content!,
                  ],
                  // 버튼
                  if (primaryButtonText != null || secondaryButtonText != null) ...[
                    const SizedBox(height: 24),
                    _buildButtons(context),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final color = iconColor ?? AppColors.primary;
    final bgColor = color.withValues(alpha: 0.1);

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: 28, color: color)
            : SvgPicture.asset(
                svgIcon!,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (secondaryButtonText == null) {
      // 단일 버튼 (Figma: 40px height - medium)
      return AppButton(
        text: primaryButtonText!,
        type: primaryButtonType,
        size: AppButtonSize.medium,
        isFullWidth: true,
        onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(true),
      );
    }

    // 이중 버튼 (Figma: 48px height - large)
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: secondaryButtonText!,
            type: AppButtonType.neutral,
            size: AppButtonSize.large,
            onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(false),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppButton(
            text: primaryButtonText!,
            type: primaryButtonType,
            size: AppButtonSize.large,
            onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(true),
          ),
        ),
      ],
    );
  }

  // ============================================
  // STATIC SHOW METHODS
  // ============================================

  /// 기본 알림 모달
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = '확인',
    IconData? icon,
    String? svgIcon,
    Color? iconColor,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AppModal(
        title: title,
        message: message,
        icon: icon,
        svgIcon: svgIcon,
        iconColor: iconColor,
        primaryButtonText: buttonText,
        onPrimaryPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// 확인 모달
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    String? message,
    String confirmText = '확인',
    String cancelText = '취소',
    IconData? icon,
    String? svgIcon,
    Color? iconColor,
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AppModal(
        title: title,
        message: message,
        icon: icon,
        svgIcon: svgIcon,
        iconColor: iconColor ?? (isDanger ? AppColors.error : null),
        primaryButtonText: confirmText,
        secondaryButtonText: cancelText,
        primaryButtonType: isDanger ? AppButtonType.danger : AppButtonType.primary,
        onPrimaryPressed: () => Navigator.of(context).pop(true),
        onSecondaryPressed: () => Navigator.of(context).pop(false),
      ),
    );
  }

  /// 성공 모달
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = '확인',
  }) {
    return showAlert(
      context,
      title: title,
      message: message,
      buttonText: buttonText,
      icon: Icons.check_circle_outline,
      iconColor: AppColors.success,
    );
  }

  /// 에러 모달
  static Future<void> showError(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = '확인',
  }) {
    return showAlert(
      context,
      title: title,
      message: message,
      buttonText: buttonText,
      icon: Icons.error_outline,
      iconColor: AppColors.error,
    );
  }

  /// 경고 모달
  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = '확인',
  }) {
    return showAlert(
      context,
      title: title,
      message: message,
      buttonText: buttonText,
      icon: Icons.warning_amber_outlined,
      iconColor: AppColors.warning,
    );
  }

  /// 삭제 확인 모달
  static Future<bool?> showDelete(
    BuildContext context, {
    String title = '삭제하시겠습니까?',
    String? message = '삭제된 항목은 복구할 수 없습니다.',
    String confirmText = '삭제',
    String cancelText = '취소',
  }) {
    return showConfirm(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      icon: Icons.delete_outline,
      isDanger: true,
    );
  }

  /// 커스텀 모달
  static Future<T?> showCustom<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    AppModalSize size = AppModalSize.medium,
    bool showCloseButton = false,
    bool isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => AppModal(
        title: title,
        content: content,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        size: size,
        showCloseButton: showCloseButton,
        isDismissible: isDismissible,
      ),
    );
  }
}

/// 입력 모달
class AppInputModal extends StatefulWidget {
  const AppInputModal({
    super.key,
    required this.title,
    this.message,
    this.initialValue,
    this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.confirmText = '확인',
    this.cancelText = '취소',
  });

  final String title;
  final String? message;
  final String? initialValue;
  final String? hintText;
  final int? maxLength;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String confirmText;
  final String cancelText;

  /// 입력 모달 표시
  static Future<String?> show(
    BuildContext context, {
    required String title,
    String? message,
    String? initialValue,
    String? hintText,
    int? maxLength,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    String confirmText = '확인',
    String cancelText = '취소',
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppInputModal(
        title: title,
        message: message,
        initialValue: initialValue,
        hintText: hintText,
        maxLength: maxLength,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }

  @override
  State<AppInputModal> createState() => _AppInputModalState();
}

class _AppInputModalState extends State<AppInputModal> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      if (error != null) {
        setState(() => _errorText = error);
        return;
      }
    }
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(widget.title, style: AppTextStyles.h4Bold),
              // 메시지
              if (widget.message != null) ...[
                const SizedBox(height: 8),
                Text(
                  widget.message!,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              // 입력 필드
              TextField(
                controller: _controller,
                autofocus: true,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                keyboardType: widget.keyboardType,
                style: AppTextStyles.body1NormalRegular,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.body1NormalRegular.copyWith(
                    color: AppColors.labelDisabled,
                  ),
                  errorText: _errorText,
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  counterText: '',
                ),
                onChanged: (_) {
                  if (_errorText != null) {
                    setState(() => _errorText = null);
                  }
                },
              ),
              const SizedBox(height: 24),
              // 버튼 (Figma: 48px height - large)
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: widget.cancelText,
                      type: AppButtonType.neutral,
                      size: AppButtonSize.large,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: widget.confirmText,
                      type: AppButtonType.primary,
                      size: AppButtonSize.large,
                      onPressed: _onConfirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 선택 모달 (라디오 버튼)
class AppSelectModal<T> extends StatefulWidget {
  const AppSelectModal({
    super.key,
    required this.title,
    required this.options,
    this.selectedValue,
    this.message,
    this.confirmText = '확인',
    this.cancelText = '취소',
  });

  final String title;
  final List<AppSelectOption<T>> options;
  final T? selectedValue;
  final String? message;
  final String confirmText;
  final String cancelText;

  /// 선택 모달 표시
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppSelectOption<T>> options,
    T? selectedValue,
    String? message,
    String confirmText = '확인',
    String cancelText = '취소',
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppSelectModal<T>(
        title: title,
        options: options,
        selectedValue: selectedValue,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }

  @override
  State<AppSelectModal<T>> createState() => _AppSelectModalState<T>();
}

class _AppSelectModalState<T> extends State<AppSelectModal<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: 320,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: AppTextStyles.h4Bold),
                  if (widget.message != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.message!,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 옵션 리스트
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.options.map((option) {
                    final isSelected = _selectedValue == option.value;
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => setState(() => _selectedValue = option.value),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                    width: isSelected ? 6 : 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option.label,
                                      style: AppTextStyles.body1NormalMedium.copyWith(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    if (option.description != null)
                                      Text(
                                        option.description!,
                                        style: AppTextStyles.caption1Regular.copyWith(
                                          color: AppColors.labelNeutral,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // 버튼 (Figma: 48px height - large)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: widget.cancelText,
                      type: AppButtonType.neutral,
                      size: AppButtonSize.large,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: widget.confirmText,
                      type: AppButtonType.primary,
                      size: AppButtonSize.large,
                      onPressed: () => Navigator.of(context).pop(_selectedValue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 선택 옵션
class AppSelectOption<T> {
  const AppSelectOption({
    required this.value,
    required this.label,
    this.description,
  });

  final T value;
  final String label;
  final String? description;
}

/// 이미지 모달 (이미지 상세 보기)
class AppImageModal extends StatelessWidget {
  const AppImageModal({
    super.key,
    required this.imageUrl,
    this.title,
    this.heroTag,
  });

  final String imageUrl;
  final String? title;
  final String? heroTag;

  /// 이미지 모달 표시
  static Future<void> show(
    BuildContext context, {
    required String imageUrl,
    String? title,
    String? heroTag,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => AppImageModal(
        imageUrl: imageUrl,
        title: title,
        heroTag: heroTag,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 이미지
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: heroTag != null
                    ? Hero(
                        tag: heroTag!,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            // 상단 바
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: AppTextStyles.body1NormalMedium.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
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

/// 토스트 메시지 (SnackBar 대체)
class AppToast {
  AppToast._();

  /// 일반 토스트
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
    String? svgIcon,
    Color? backgroundColor,
    Color? textColor,
  }) {
    _showSnackBar(
      context,
      message: message,
      duration: duration,
      icon: icon,
      svgIcon: svgIcon,
      backgroundColor: backgroundColor ?? AppColors.textPrimary,
      textColor: textColor ?? Colors.white,
    );
  }

  /// 성공 토스트
  static void success(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message: message,
      duration: duration,
      icon: Icons.check_circle,
      backgroundColor: AppColors.success,
      textColor: Colors.white,
    );
  }

  /// 에러 토스트
  static void error(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(
      context,
      message: message,
      duration: duration,
      icon: Icons.error,
      backgroundColor: AppColors.error,
      textColor: Colors.white,
    );
  }

  /// 경고 토스트
  static void warning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message: message,
      duration: duration,
      icon: Icons.warning,
      backgroundColor: AppColors.warning,
      textColor: Colors.white,
    );
  }

  /// 정보 토스트
  static void info(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message: message,
      duration: duration,
      icon: Icons.info,
      backgroundColor: AppColors.info,
      textColor: Colors.white,
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required Duration duration,
    IconData? icon,
    String? svgIcon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 12),
            ] else if (svgIcon != null) ...[
              SvgPicture.asset(
                svgIcon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.body2NormalMedium.copyWith(color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: duration,
      ),
    );
  }
}
