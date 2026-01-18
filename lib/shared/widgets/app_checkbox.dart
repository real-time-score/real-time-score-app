import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 체크박스 크기
enum AppCheckboxSize {
  /// 16px 텍스트 크기 (기본)
  size16,

  /// 12px 텍스트 크기 (작은)
  size12,
}

/// Figma 디자인 기반 체크박스 컴포넌트
///
/// Figma node: 1:33665
///
/// 사용 예시:
/// ```dart
/// AppCheckbox(
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value),
///   label: '동의합니다',
/// )
/// ```
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.size = AppCheckboxSize.size16,
    this.isDisabled = false,
  });

  /// 체크 상태
  final bool value;

  /// 체크 상태 변경 콜백
  final ValueChanged<bool>? onChanged;

  /// 체크박스 옆에 표시할 라벨
  final String? label;

  /// 체크박스 크기
  final AppCheckboxSize size;

  /// 비활성화 상태
  final bool isDisabled;

  // 체크박스 아이콘 크기 (24x24 컨테이너 내 18x18 아이콘)
  static const double _iconContainerSize = 24.0;
  static const double _iconSize = 18.0;

  TextStyle _getTextStyle() {
    switch (size) {
      case AppCheckboxSize.size16:
        // Body1/M: 16px, lineHeight 24, letterSpacing -1
        return AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelNeutral,
        );
      case AppCheckboxSize.size12:
        // Caption1/M: 12px, lineHeight 16, letterSpacing -0.5
        return AppTextStyles.caption1Medium.copyWith(
          color: AppColors.labelNeutral,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && onChanged != null;

    return GestureDetector(
      onTap: isEnabled ? () => onChanged?.call(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 체크박스 아이콘
            _buildCheckboxIcon(),
            // 라벨
            if (label != null) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label!,
                  style: _getTextStyle(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxIcon() {
    return SizedBox(
      width: _iconContainerSize,
      height: _iconContainerSize,
      child: Center(
        child: value ? _buildCheckedIcon() : _buildUncheckedIcon(),
      ),
    );
  }

  /// 체크된 상태 아이콘 (파란 배경 + 체크마크)
  Widget _buildCheckedIcon() {
    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        color: AppColors.primaryFigma, // #061667
        borderRadius: BorderRadius.circular(2),
      ),
      child: const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      ),
    );
  }

  /// 체크되지 않은 상태 아이콘 (회색 테두리)
  Widget _buildUncheckedIcon() {
    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.contentsNormal, // #B1B8C0
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// 체크박스 타일 (ListTile 스타일)
///
/// 전체 영역을 탭 가능하게 만든 체크박스
class AppCheckboxTile extends StatelessWidget {
  const AppCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.size = AppCheckboxSize.size16,
    this.isDisabled = false,
    this.contentPadding,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;
  final String? subtitle;
  final AppCheckboxSize size;
  final bool isDisabled;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && onChanged != null;

    return GestureDetector(
      onTap: isEnabled ? () => onChanged?.call(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Opacity(
          opacity: isDisabled ? 0.5 : 1.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCheckbox(
                value: value,
                size: size,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: size == AppCheckboxSize.size16
                          ? AppTextStyles.body1NormalMedium.copyWith(
                              color: AppColors.labelNeutral,
                            )
                          : AppTextStyles.caption1Medium.copyWith(
                              color: AppColors.labelNeutral,
                            ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: AppTextStyles.caption1Regular.copyWith(
                          color: AppColors.labelDisabled,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 체크박스 그룹 (다중 선택)
class AppCheckboxGroup extends StatelessWidget {
  const AppCheckboxGroup({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    this.size = AppCheckboxSize.size16,
    this.isDisabled = false,
    this.spacing = 12,
    this.direction = Axis.vertical,
  });

  /// 체크박스 항목 리스트 (label 문자열)
  final List<String> items;

  /// 선택된 항목의 인덱스 Set
  final Set<int> selectedValues;

  /// 선택 상태 변경 콜백
  final ValueChanged<Set<int>> onChanged;

  final AppCheckboxSize size;
  final bool isDisabled;
  final double spacing;
  final Axis direction;

  void _handleToggle(int index) {
    final newSelection = Set<int>.from(selectedValues);
    if (newSelection.contains(index)) {
      newSelection.remove(index);
    } else {
      newSelection.add(index);
    }
    onChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final children = items.asMap().entries.map((entry) {
      return AppCheckbox(
        value: selectedValues.contains(entry.key),
        onChanged: isDisabled ? null : (_) => _handleToggle(entry.key),
        label: entry.value,
        size: size,
        isDisabled: isDisabled,
      );
    }).toList();

    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((child) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: child,
          );
        }).toList(),
      );
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children,
    );
  }
}
