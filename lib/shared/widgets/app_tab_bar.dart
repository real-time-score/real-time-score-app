import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 커스텀 탭바
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isScrollable = false,
    this.backgroundColor,
    this.indicatorColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.padding,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final bool isScrollable;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.surface,
      padding: padding,
      child: isScrollable ? _buildScrollableTab() : _buildFixedTab(),
    );
  }

  Widget _buildFixedTab() {
    return Row(
      children: tabs.asMap().entries.map((entry) {
        return Expanded(
          child: _TabItem(
            label: entry.value,
            isSelected: entry.key == selectedIndex,
            onTap: () => onTabChanged(entry.key),
            indicatorColor: indicatorColor,
            selectedTextColor: selectedTextColor,
            unselectedTextColor: unselectedTextColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScrollableTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          return _TabItem(
            label: entry.value,
            isSelected: entry.key == selectedIndex,
            onTap: () => onTabChanged(entry.key),
            indicatorColor: indicatorColor,
            selectedTextColor: selectedTextColor,
            unselectedTextColor: unselectedTextColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          );
        }).toList(),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.indicatorColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.padding,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? indicatorColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? (indicatorColor ?? AppColors.primary)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.label1NormalBold.copyWith(
              color: isSelected
                  ? (selectedTextColor ?? AppColors.primary)
                  : (unselectedTextColor ?? AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

/// 세그먼트 컨트롤 (iOS 스타일)
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onSegmentChanged,
    this.backgroundColor,
    this.selectedColor,
    this.borderRadius = 8,
    this.height = 36,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onSegmentChanged;
  final Color? backgroundColor;
  final Color? selectedColor;
  final double borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: segments.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSegmentChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? AppColors.surface)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius - 2),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: AppTextStyles.label2Medium.copyWith(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
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

/// 필터 탭 (수평 스크롤)
class AppFilterTab extends StatelessWidget {
  const AppFilterTab({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.padding,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          return Padding(
            padding: EdgeInsets.only(right: entry.key < items.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => onSelected(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: AppTextStyles.label2Medium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
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

/// 카테고리 크기
enum CategorySize {
  /// H4 스타일 (18px) - labelNormal 색상
  large,

  /// Body1 스타일 (16px) - primary 색상
  medium,
}

/// 카테고리 탭 (Figma 디자인 기반)
/// 선택 시 Bold 텍스트 + 언더라인 인디케이터
/// 미선택 시 Medium 텍스트 + 인디케이터 없음
class AppCategory extends StatelessWidget {
  const AppCategory({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.size = CategorySize.large,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final CategorySize size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? _selectedIndicatorColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label,
            style: isSelected ? _selectedTextStyle : _unselectedTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  TextStyle get _selectedTextStyle {
    switch (size) {
      case CategorySize.large:
        return AppTextStyles.h4Bold.copyWith(
          color: AppColors.labelNormal,
        );
      case CategorySize.medium:
        return AppTextStyles.body1NormalBold.copyWith(
          color: AppColors.primaryFigma,
        );
    }
  }

  TextStyle get _unselectedTextStyle {
    switch (size) {
      case CategorySize.large:
        return AppTextStyles.h4Medium.copyWith(
          color: AppColors.labelAlternative,
        );
      case CategorySize.medium:
        return AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelAlternative,
        );
    }
  }

  Color get _selectedIndicatorColor {
    switch (size) {
      case CategorySize.large:
        return AppColors.labelNormal;
      case CategorySize.medium:
        return AppColors.primaryFigma;
    }
  }
}

/// 카테고리 바 (AppCategory의 리스트)
class AppCategoryBar extends StatelessWidget {
  const AppCategoryBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategoryChanged,
    this.isScrollable = false,
    this.backgroundColor,
    this.padding,
    this.size = CategorySize.large,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategoryChanged;
  final bool isScrollable;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final CategorySize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.surface,
      padding: padding,
      child: isScrollable ? _buildScrollableCategory() : _buildFixedCategory(),
    );
  }

  Widget _buildFixedCategory() {
    return Row(
      children: categories.asMap().entries.map((entry) {
        return Expanded(
          child: AppCategory(
            label: entry.value,
            isSelected: entry.key == selectedIndex,
            onTap: () => onCategoryChanged(entry.key),
            size: size,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScrollableCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.asMap().entries.map((entry) {
          return AppCategory(
            label: entry.value,
            isSelected: entry.key == selectedIndex,
            onTap: () => onCategoryChanged(entry.key),
            size: size,
          );
        }).toList(),
      ),
    );
  }
}

/// 커스텀 디바이더
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height = 1,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  final double height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  /// 섹션 구분용 두꺼운 디바이더
  factory AppDivider.section({double height = 8, Color? color}) {
    return AppDivider(
      height: height,
      color: color ?? AppColors.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (thickness != null || indent != null || endIndent != null) {
      return Divider(
        height: height,
        thickness: thickness ?? 1,
        indent: indent,
        endIndent: endIndent,
        color: color ?? AppColors.divider,
      );
    }

    return Container(
      height: height,
      color: color ?? AppColors.divider,
    );
  }
}
