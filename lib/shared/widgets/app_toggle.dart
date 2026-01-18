import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 토글 컴포넌트 크기
enum AppToggleSize {
  /// 기본 크기 (높이 32px)
  medium,

  /// 큰 크기 (높이 48px)
  large,
}

/// 토글 컴포넌트 색상 타입
enum AppToggleColorType {
  /// 기본 색상 (선택 시 흰색 배경)
  defaultColor,

  /// 활성 색상 (선택 시 파란색 배경)
  active,
}

/// Figma 디자인 기반 토글 컴포넌트
///
/// 2개의 옵션 중 하나를 선택하는 세그먼트 컨트롤 스타일의 토글
class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.size = AppToggleSize.medium,
    this.colorType = AppToggleColorType.defaultColor,
    this.width,
  }) : assert(labels.length == 2, 'AppToggle requires exactly 2 labels');

  /// 토글 옵션 라벨 (정확히 2개)
  final List<String> labels;

  /// 현재 선택된 인덱스 (0 또는 1)
  final int selectedIndex;

  /// 선택 변경 콜백
  final ValueChanged<int> onChanged;

  /// 토글 크기
  final AppToggleSize size;

  /// 토글 색상 타입
  final AppToggleColorType colorType;

  /// 토글 너비 (null이면 부모 너비에 맞춤)
  final double? width;

  double get _itemHeight {
    switch (size) {
      case AppToggleSize.medium:
        return 32;
      case AppToggleSize.large:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleItem(
              label: labels[0],
              isSelected: selectedIndex == 0,
              onTap: () => onChanged(0),
              height: _itemHeight,
              colorType: colorType,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ToggleItem(
              label: labels[1],
              isSelected: selectedIndex == 1,
              onTap: () => onChanged(1),
              height: _itemHeight,
              colorType: colorType,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  const _ToggleItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.height,
    required this.colorType,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;
  final AppToggleColorType colorType;

  Color get _backgroundColor {
    if (!isSelected) return Colors.transparent;

    switch (colorType) {
      case AppToggleColorType.defaultColor:
        return AppColors.white;
      case AppToggleColorType.active:
        return AppColors.primaryFigma;
    }
  }

  Color get _textColor {
    if (!isSelected) return AppColors.labelNeutral;

    switch (colorType) {
      case AppToggleColorType.defaultColor:
        return AppColors.labelNeutral;
      case AppToggleColorType.active:
        return AppColors.white;
    }
  }

  TextStyle get _textStyle {
    final baseStyle = isSelected && colorType == AppToggleColorType.active
        ? AppTextStyles.body1NormalBold
        : AppTextStyles.body1NormalMedium;

    return baseStyle.copyWith(color: _textColor);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: _textStyle,
          ),
        ),
      ),
    );
  }
}
