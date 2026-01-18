import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 라디오 버튼 사이즈
enum AppRadioSize {
  small, // 14
  medium, // 16
}

/// 라디오 버튼 레이아웃 방향
enum AppRadioLayout {
  horizontal, // 가로형
  vertical, // 세로형
}

/// 기본 라디오 버튼 컴포넌트
class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.size = AppRadioSize.medium,
    this.layout = AppRadioLayout.horizontal,
    this.isDisabled = false,
    this.activeColor,
    this.inactiveColor,
    this.labelColor,
  });

  /// 이 라디오 버튼의 값
  final T value;

  /// 그룹에서 선택된 값
  final T? groupValue;

  /// 선택 변경 콜백
  final ValueChanged<T?>? onChanged;

  /// 라벨 텍스트
  final String? label;

  /// 라디오 버튼 사이즈
  final AppRadioSize size;

  /// 레이아웃 방향
  final AppRadioLayout layout;

  /// 비활성화 여부
  final bool isDisabled;

  /// 선택 시 색상
  final Color? activeColor;

  /// 미선택 시 테두리 색상
  final Color? inactiveColor;

  /// 라벨 색상
  final Color? labelColor;

  bool get _isSelected => value == groupValue;

  double get _radioSize => size == AppRadioSize.medium ? 24.0 : 20.0;

  double get _innerDotSize => 10.0;

  double get _gap {
    if (layout == AppRadioLayout.horizontal) {
      return size == AppRadioSize.medium ? 8.0 : 4.0;
    } else {
      return size == AppRadioSize.medium ? 4.0 : 2.0;
    }
  }

  TextStyle get _labelStyle {
    final baseStyle = size == AppRadioSize.medium
        ? AppTextStyles.body1NormalMedium
        : AppTextStyles.label1NormalMedium;
    return baseStyle.copyWith(
      color: isDisabled
          ? AppColors.labelDisabled
          : (labelColor ?? AppColors.labelNeutral),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.primaryFigma;
    final effectiveInactiveColor = inactiveColor ?? AppColors.borderNormal;

    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged?.call(value),
      behavior: HitTestBehavior.opaque,
      child: layout == AppRadioLayout.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRadioCircle(effectiveActiveColor, effectiveInactiveColor),
                if (label != null) ...[
                  SizedBox(width: _gap),
                  Text(label!, style: _labelStyle),
                ],
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRadioCircle(effectiveActiveColor, effectiveInactiveColor),
                if (label != null) ...[
                  SizedBox(height: _gap),
                  Text(
                    label!,
                    style: _labelStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildRadioCircle(Color activeColor, Color inactiveColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: _radioSize,
      height: _radioSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDisabled
              ? AppColors.labelDisabled
              : (_isSelected ? activeColor : inactiveColor),
          width: _isSelected ? 2.0 : 1.5,
        ),
      ),
      child: _isSelected
          ? Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _innerDotSize,
                height: _innerDotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDisabled ? AppColors.labelDisabled : activeColor,
                ),
              ),
            )
          : null,
    );
  }
}

/// 라디오 버튼 그룹 컴포넌트
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.items,
    required this.groupValue,
    required this.onChanged,
    this.size = AppRadioSize.medium,
    this.layout = AppRadioLayout.horizontal,
    this.direction = Axis.horizontal,
    this.spacing = 16,
    this.runSpacing = 8,
    this.wrap = false,
    this.isDisabled = false,
  });

  /// 라디오 아이템 목록 (value, label)
  final List<AppRadioItem<T>> items;

  /// 그룹에서 선택된 값
  final T? groupValue;

  /// 선택 변경 콜백
  final ValueChanged<T?>? onChanged;

  /// 라디오 버튼 사이즈
  final AppRadioSize size;

  /// 개별 라디오 버튼의 레이아웃 방향
  final AppRadioLayout layout;

  /// 그룹 내 라디오 버튼 배치 방향
  final Axis direction;

  /// 라디오 버튼 간 간격
  final double spacing;

  /// 줄 바꿈 시 간격
  final double runSpacing;

  /// 줄 바꿈 여부
  final bool wrap;

  /// 전체 비활성화 여부
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final children = items.map((item) {
      return AppRadio<T>(
        value: item.value,
        groupValue: groupValue,
        onChanged: isDisabled || item.isDisabled ? null : onChanged,
        label: item.label,
        size: size,
        layout: layout,
        isDisabled: isDisabled || item.isDisabled,
      );
    }).toList();

    if (wrap) {
      return Wrap(
        direction: direction,
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children.asMap().entries.map((entry) {
          final isLast = entry.key == children.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : spacing),
            child: entry.value,
          );
        }).toList(),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.asMap().entries.map((entry) {
        final isLast = entry.key == children.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
          child: entry.value,
        );
      }).toList(),
    );
  }
}

/// 라디오 아이템 데이터 클래스
class AppRadioItem<T> {
  const AppRadioItem({
    required this.value,
    required this.label,
    this.isDisabled = false,
  });

  final T value;
  final String label;
  final bool isDisabled;
}

/// 라디오 버튼 리스트 타일 (리스트에서 사용)
class AppRadioListTile<T> extends StatelessWidget {
  const AppRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.isDisabled = false,
    this.contentPadding,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isDisabled;
  final EdgeInsetsGeometry? contentPadding;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : () => onChanged?.call(value),
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: AppTextStyles.body1NormalMedium.copyWith(
                      color: isDisabled
                          ? AppColors.labelDisabled
                          : AppColors.labelNormal,
                    ),
                    child: title,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    DefaultTextStyle(
                      style: AppTextStyles.label1NormalRegular.copyWith(
                        color: isDisabled
                            ? AppColors.labelDisabled
                            : AppColors.labelNeutral,
                      ),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ],
            const SizedBox(width: 12),
            _buildRadioCircle(),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioCircle() {
    final activeColor = AppColors.primaryFigma;
    final inactiveColor = AppColors.borderNormal;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDisabled
              ? AppColors.labelDisabled
              : (_isSelected ? activeColor : inactiveColor),
          width: _isSelected ? 2.0 : 1.5,
        ),
      ),
      child: _isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDisabled ? AppColors.labelDisabled : activeColor,
                ),
              ),
            )
          : null,
    );
  }
}
