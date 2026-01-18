import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';

/// 텍스트 필드 사이즈
enum AppTextFieldSize {
  small, // height: 40
  medium, // height: 48
  large, // height: 56
}

/// 기본 텍스트 필드
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.isRequired = false,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.prefixIcon,
    this.prefixSvgIcon,
    this.suffixIcon,
    this.suffixSvgIcon,
    this.prefix,
    this.suffix,
    this.size = AppTextFieldSize.medium,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.fillColor,
    this.borderRadius,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final bool isRequired;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final IconData? prefixIcon;
  final String? prefixSvgIcon;
  final IconData? suffixIcon;
  final String? suffixSvgIcon;
  final Widget? prefix;
  final Widget? suffix;
  final AppTextFieldSize size;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final double? borderRadius;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  double _getHeight() {
    if (widget.maxLines > 1) return double.infinity;
    switch (widget.size) {
      case AppTextFieldSize.small:
        return 40;
      case AppTextFieldSize.medium:
        return 48;
      case AppTextFieldSize.large:
        return 56;
    }
  }

  EdgeInsets _getContentPadding() {
    // Figma: 15px horizontal padding
    switch (widget.size) {
      case AppTextFieldSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case AppTextFieldSize.medium:
        return const EdgeInsets.symmetric(horizontal: 15, vertical: 12);
      case AppTextFieldSize.large:
        return const EdgeInsets.symmetric(horizontal: 15, vertical: 16);
    }
  }

  TextStyle _getTextStyle() {
    // Figma: Body1/M (16px Medium)
    switch (widget.size) {
      case AppTextFieldSize.small:
        return AppTextStyles.body2NormalMedium;
      case AppTextFieldSize.medium:
        return AppTextStyles.body1NormalMedium;
      case AppTextFieldSize.large:
        return AppTextStyles.body1NormalMedium;
    }
  }

  double _getBorderRadius() {
    return widget.borderRadius ?? 8;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final hasSuccess = widget.successText != null && widget.successText!.isNotEmpty;
    final iconSize = widget.size == AppTextFieldSize.small ? 18.0 : 20.0;

    Widget? prefixWidget;
    if (widget.prefix != null) {
      prefixWidget = widget.prefix;
    } else if (widget.prefixIcon != null) {
      prefixWidget = Icon(
        widget.prefixIcon,
        size: iconSize,
        color: AppColors.labelNeutral,
      );
    } else if (widget.prefixSvgIcon != null) {
      prefixWidget = SvgPicture.asset(
        widget.prefixSvgIcon!,
        width: iconSize,
        height: iconSize,
        colorFilter: const ColorFilter.mode(AppColors.labelNeutral, BlendMode.srcIn),
      );
    }

    Widget? suffixWidget;
    if (widget.suffix != null) {
      suffixWidget = widget.suffix;
    } else if (widget.obscureText) {
      suffixWidget = GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: iconSize,
          color: AppColors.labelNeutral,
        ),
      );
    } else if (widget.suffixIcon != null) {
      suffixWidget = Icon(
        widget.suffixIcon,
        size: iconSize,
        color: AppColors.labelNeutral,
      );
    } else if (widget.suffixSvgIcon != null) {
      suffixWidget = SvgPicture.asset(
        widget.suffixSvgIcon!,
        width: iconSize,
        height: iconSize,
        colorFilter: const ColorFilter.mode(AppColors.labelNeutral, BlendMode.srcIn),
      );
    }

    // 헬퍼 텍스트 색상 결정 (Figma: Label2/M)
    Color helperColor;
    String? helperText;
    if (hasError) {
      helperColor = AppColors.negative;
      helperText = widget.errorText;
    } else if (hasSuccess) {
      helperColor = AppColors.primaryFigma;
      helperText = widget.successText;
    } else if (widget.helperText != null) {
      helperColor = AppColors.labelNeutral;
      helperText = widget.helperText;
    } else {
      helperColor = AppColors.labelNeutral;
      helperText = null;
    }

    // 테두리 색상 결정
    final borderColor = hasError ? AppColors.negative : AppColors.borderNormal;
    final focusedBorderColor = hasError ? AppColors.negative : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 라벨 (Figma: Label1/M + 필수 표시)
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              if (widget.isRequired) ...[
                const SizedBox(width: 4),
                Text(
                  '(필수)',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.primaryFigma,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: widget.maxLines == 1 ? _getHeight() : null,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: _getTextStyle().copyWith(color: AppColors.labelNormal),
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: _obscureText,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: _getTextStyle().copyWith(color: AppColors.labelAlternative),
              filled: true,
              fillColor: widget.enabled
                  ? (widget.fillColor ?? AppColors.surface)
                  : AppColors.containerDisabled,
              contentPadding: _getContentPadding(),
              prefixIcon: prefixWidget != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: prefixWidget,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: suffixWidget != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8, right: 12),
                      child: suffixWidget,
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: const BorderSide(color: AppColors.negative),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: const BorderSide(color: AppColors.negative, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                borderSide: const BorderSide(color: AppColors.borderNormal),
              ),
              counterText: '',
            ),
          ),
        ),
        // 헬퍼/에러/성공 텍스트 (Figma: Label2/M)
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: AppTextStyles.label2Medium.copyWith(
              color: helperColor,
            ),
          ),
        ],
      ],
    );
  }
}

/// 검색 바
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hint = '검색',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.enabled = true,
    this.showClearButton = true,
    this.backgroundColor,
    this.borderRadius,
    this.height = 44,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool enabled;
  final bool showClearButton;
  final Color? backgroundColor;
  final double? borderRadius;
  final double height;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController _controller;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _showClear = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClear = _controller.text.isNotEmpty;
    });
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        style: AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelNormal,
        ),
        textInputAction: TextInputAction.search,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppTextStyles.body1NormalMedium.copyWith(
            color: AppColors.labelAlternative,
          ),
          filled: true,
          fillColor: widget.backgroundColor ?? AppColors.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: SvgPicture.asset(
              AppIcons.search,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(AppColors.labelNeutral, BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: widget.showClearButton && _showClear
              ? GestureDetector(
                  onTap: _onClear,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 12),
                    child: SvgPicture.asset(
                      AppIcons.circleCloseFill,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(AppColors.labelAlternative, BlendMode.srcIn),
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// 텍스트 영역 (멀티라인)
class AppTextArea extends StatelessWidget {
  const AppTextArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.minLines = 3,
    this.maxLines = 5,
    this.maxLength,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helperText: helperText,
      errorText: errorText,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: TextInputType.multiline,
    );
  }
}
