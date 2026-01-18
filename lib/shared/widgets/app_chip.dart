import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// ============================================
// FIGMA DESIGN SYSTEM CHIPS
// ============================================

/// Figma 디자인 시스템 기반 칩 상태
enum ChipStatus {
  /// Default: border만 있는 기본 상태
  defaultStatus,

  /// Active: primary 배경, 흰색 텍스트
  active,

  /// Active2: primary container 배경, primary 텍스트
  active2,

  /// ON: 검정 배경, 흰색 텍스트
  on,

  /// Disabled: 회색 배경, 회색 텍스트
  disabled,

  /// Hot: 빨간 컨테이너 배경, 빨간 텍스트
  hot,

  /// Cool: 파란 컨테이너 배경, 파란 텍스트
  cool,

  /// Contents1: 연회색 배경, 흰색 텍스트
  contents1,

  /// Contents2: 진회색 배경, 흰색 텍스트
  contents2,

  /// Error/Increase: 빨간 배경, 흰색 텍스트
  errorIncrease,

  /// Decrease: 파란 배경, 흰색 텍스트
  decrease,

  /// Gas/Bad (Positive Green): 초록 배경, 흰색 텍스트
  gasBad,

  /// Electric/Normal: 노란 배경, 흰색 텍스트
  electricNormal,
}

/// Figma 디자인 시스템 기반 칩 폰트 타입
enum ChipFontType {
  /// Medium (500)
  mid,

  /// Bold (700)
  bold,
}

/// Figma 디자인 시스템 기반 Chips 컴포넌트
class Chips extends StatelessWidget {
  const Chips({
    super.key,
    required this.label,
    this.status = ChipStatus.defaultStatus,
    this.fontType = ChipFontType.mid,
    this.onTap,
  });

  final String label;
  final ChipStatus status;
  final ChipFontType fontType;
  final VoidCallback? onTap;

  Color _getBackgroundColor() {
    switch (status) {
      case ChipStatus.defaultStatus:
        return Colors.transparent;
      case ChipStatus.active:
        return AppColors.primaryFigma;
      case ChipStatus.active2:
        return AppColors.primaryContainer;
      case ChipStatus.on:
        return AppColors.labelNormal;
      case ChipStatus.disabled:
        return AppColors.containerDisabled;
      case ChipStatus.hot:
        return AppColors.negativeContainer;
      case ChipStatus.cool:
        return AppColors.positiveContainer;
      case ChipStatus.contents1:
        return AppColors.contentsNormal;
      case ChipStatus.contents2:
        return AppColors.contentsNeutral;
      case ChipStatus.errorIncrease:
        return AppColors.negative;
      case ChipStatus.decrease:
        return AppColors.positive;
      case ChipStatus.gasBad:
        return AppColors.positiveGreen;
      case ChipStatus.electricNormal:
        return AppColors.yellow;
    }
  }

  Color _getTextColor() {
    switch (status) {
      case ChipStatus.defaultStatus:
        return AppColors.labelNeutral;
      case ChipStatus.active:
      case ChipStatus.on:
      case ChipStatus.contents1:
      case ChipStatus.contents2:
      case ChipStatus.errorIncrease:
      case ChipStatus.decrease:
      case ChipStatus.gasBad:
      case ChipStatus.electricNormal:
        return AppColors.white;
      case ChipStatus.active2:
        return AppColors.primaryFigma;
      case ChipStatus.disabled:
        return AppColors.labelDisabled;
      case ChipStatus.hot:
        return AppColors.negative;
      case ChipStatus.cool:
        return AppColors.positive;
    }
  }

  Color? _getBorderColor() {
    if (status == ChipStatus.defaultStatus) {
      return AppColors.borderNormal;
    }
    return null;
  }

  TextStyle _getTextStyle() {
    // Figma: 14px, line-height 20px, letter-spacing -1%
    final baseStyle = const TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: -0.14,
    );

    return baseStyle.copyWith(
      fontWeight: fontType == ChipFontType.bold ? FontWeight.w700 : FontWeight.w500,
      color: _getTextColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor();
    final borderColor = _getBorderColor();
    final isDisabled = status == ChipStatus.disabled;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(9999),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Text(
          label,
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ============================================
// LEGACY CHIP SYSTEM (기존 호환성 유지)
// ============================================

/// 칩 사이즈
enum AppChipSize {
  small, // height: 24
  medium, // height: 32
  large, // height: 40
}

/// 칩 타입
enum AppChipType {
  filled,
  outlined,
  tonal,
}

/// 기본 칩 컴포넌트 (기존 호환성 유지)
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.onTap,
    this.onDelete,
    this.type = AppChipType.filled,
    this.size = AppChipSize.medium,
    this.isSelected = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.borderColor,
    this.leadingIcon,
    this.leadingSvgIcon,
    this.avatar,
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final AppChipType type;
  final AppChipSize size;
  final bool isSelected;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? borderColor;
  final IconData? leadingIcon;
  final String? leadingSvgIcon;
  final Widget? avatar;

  /// Figma 디자인 시스템 기반 칩으로 변환
  factory AppChip.fromFigma({
    Key? key,
    required String label,
    ChipStatus status = ChipStatus.defaultStatus,
    ChipFontType fontType = ChipFontType.mid,
    VoidCallback? onTap,
  }) {
    // status에 따른 색상 매핑
    Color? bgColor;
    Color? selectedBgColor;
    Color? txtColor;
    Color? selectedTxtColor;
    Color? brdColor;
    bool isSelected = false;
    bool isDisabled = false;
    AppChipType chipType = AppChipType.filled;

    switch (status) {
      case ChipStatus.defaultStatus:
        chipType = AppChipType.outlined;
        brdColor = AppColors.borderNormal;
        txtColor = AppColors.labelNeutral;
        break;
      case ChipStatus.active:
        isSelected = true;
        selectedBgColor = AppColors.primaryFigma;
        selectedTxtColor = AppColors.white;
        break;
      case ChipStatus.active2:
        bgColor = AppColors.primaryContainer;
        txtColor = AppColors.primaryFigma;
        break;
      case ChipStatus.on:
        bgColor = AppColors.labelNormal;
        txtColor = AppColors.white;
        break;
      case ChipStatus.disabled:
        isDisabled = true;
        bgColor = AppColors.containerDisabled;
        txtColor = AppColors.labelDisabled;
        break;
      case ChipStatus.hot:
        bgColor = AppColors.negativeContainer;
        txtColor = AppColors.negative;
        break;
      case ChipStatus.cool:
        bgColor = AppColors.positiveContainer;
        txtColor = AppColors.positive;
        break;
      case ChipStatus.contents1:
        bgColor = AppColors.contentsNormal;
        txtColor = AppColors.white;
        break;
      case ChipStatus.contents2:
        bgColor = AppColors.contentsNeutral;
        txtColor = AppColors.white;
        break;
      case ChipStatus.errorIncrease:
        bgColor = AppColors.negative;
        txtColor = AppColors.white;
        break;
      case ChipStatus.decrease:
        bgColor = AppColors.positive;
        txtColor = AppColors.white;
        break;
      case ChipStatus.gasBad:
        bgColor = AppColors.positiveGreen;
        txtColor = AppColors.white;
        break;
      case ChipStatus.electricNormal:
        bgColor = AppColors.yellow;
        txtColor = AppColors.white;
        break;
    }

    return AppChip(
      key: key,
      label: label,
      type: chipType,
      isSelected: isSelected,
      isDisabled: isDisabled,
      backgroundColor: bgColor,
      selectedBackgroundColor: selectedBgColor,
      textColor: txtColor,
      selectedTextColor: selectedTxtColor,
      borderColor: brdColor,
      onTap: onTap,
    );
  }

  double _getHeight() {
    switch (size) {
      case AppChipSize.small:
        return 24;
      case AppChipSize.medium:
        return 32;
      case AppChipSize.large:
        return 40;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 8);
      case AppChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12);
      case AppChipSize.large:
        return const EdgeInsets.symmetric(horizontal: 16);
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppChipSize.small:
        return 12;
      case AppChipSize.medium:
        return 16;
      case AppChipSize.large:
        return 18;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppChipSize.small:
        return AppTextStyles.caption1Medium;
      case AppChipSize.medium:
        return AppTextStyles.label2Medium;
      case AppChipSize.large:
        return AppTextStyles.label1NormalMedium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled;

    Color bgColor;
    Color fgColor;
    Color? border;

    switch (type) {
      case AppChipType.filled:
        bgColor = isSelected
            ? (selectedBackgroundColor ?? AppColors.primaryFigma)
            : (backgroundColor ?? AppColors.background);
        fgColor = isSelected
            ? (selectedTextColor ?? Colors.white)
            : (textColor ?? AppColors.textPrimary);
        border = null;
        break;
      case AppChipType.outlined:
        bgColor = isSelected
            ? (selectedBackgroundColor ?? AppColors.primaryFigma.withValues(alpha: 0.1))
            : Colors.transparent;
        fgColor = isSelected
            ? (selectedTextColor ?? AppColors.primaryFigma)
            : (textColor ?? AppColors.textSecondary);
        border = isSelected
            ? (borderColor ?? AppColors.primaryFigma)
            : (borderColor ?? AppColors.borderNormal);
        break;
      case AppChipType.tonal:
        bgColor = isSelected
            ? (selectedBackgroundColor ?? AppColors.primaryFigma.withValues(alpha: 0.15))
            : (backgroundColor ?? AppColors.background);
        fgColor = isSelected
            ? (selectedTextColor ?? AppColors.primaryFigma)
            : (textColor ?? AppColors.textSecondary);
        border = null;
        break;
    }

    if (!isEnabled) {
      bgColor = AppColors.containerDisabled;
      fgColor = AppColors.labelDisabled;
    }

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: _getHeight(),
        padding: _getPadding(),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(_getHeight() / 2),
          border: border != null ? Border.all(color: border) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (avatar != null) ...[
              avatar!,
              const SizedBox(width: 6),
            ] else if (leadingIcon != null) ...[
              Icon(leadingIcon, size: _getIconSize(), color: fgColor),
              const SizedBox(width: 4),
            ] else if (leadingSvgIcon != null) ...[
              SvgPicture.asset(
                leadingSvgIcon!,
                width: _getIconSize(),
                height: _getIconSize(),
                colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
            ],
            Text(label, style: _getTextStyle().copyWith(color: fgColor)),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: isEnabled ? onDelete : null,
                child: Icon(Icons.close, size: _getIconSize(), color: fgColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 필터 칩 (선택 가능한 칩 그룹용)
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.size = AppChipSize.medium,
    this.useFigmaStyle = true,
    this.fontType = ChipFontType.mid,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final AppChipSize size;
  final bool useFigmaStyle;
  final ChipFontType fontType;

  @override
  Widget build(BuildContext context) {
    if (useFigmaStyle) {
      return Chips(
        label: label,
        status: isSelected ? ChipStatus.active : ChipStatus.defaultStatus,
        fontType: fontType,
        onTap: () => onSelected(!isSelected),
      );
    }

    return AppChip(
      label: label,
      isSelected: isSelected,
      type: AppChipType.outlined,
      size: size,
      onTap: () => onSelected(!isSelected),
    );
  }
}

/// 선택 칩 그룹 (단일 선택)
class AppChipGroup extends StatelessWidget {
  const AppChipGroup({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.size = AppChipSize.medium,
    this.type = AppChipType.filled,
    this.spacing = 8,
    this.runSpacing = 8,
    this.wrap = true,
    this.useFigmaStyle = true,
    this.fontType = ChipFontType.mid,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final AppChipSize size;
  final AppChipType type;
  final double spacing;
  final double runSpacing;
  final bool wrap;
  final bool useFigmaStyle;
  final ChipFontType fontType;

  @override
  Widget build(BuildContext context) {
    final children = items.asMap().entries.map((entry) {
      final isSelected = entry.key == selectedIndex;

      if (useFigmaStyle) {
        return Chips(
          label: entry.value,
          status: isSelected ? ChipStatus.active : ChipStatus.defaultStatus,
          fontType: fontType,
          onTap: () => onSelected(entry.key),
        );
      }

      return AppChip(
        label: entry.value,
        isSelected: isSelected,
        type: type,
        size: size,
        onTap: () => onSelected(entry.key),
      );
    }).toList();

    if (wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children.map((chip) {
          return Padding(
            padding: EdgeInsets.only(right: spacing),
            child: chip,
          );
        }).toList(),
      ),
    );
  }
}

/// 다중 선택 칩 그룹
class AppMultiSelectChipGroup extends StatelessWidget {
  const AppMultiSelectChipGroup({
    super.key,
    required this.items,
    required this.selectedIndices,
    required this.onSelectionChanged,
    this.size = AppChipSize.medium,
    this.type = AppChipType.outlined,
    this.spacing = 8,
    this.runSpacing = 8,
    this.wrap = true,
    this.maxSelection,
  });

  final List<String> items;
  final Set<int> selectedIndices;
  final ValueChanged<Set<int>> onSelectionChanged;
  final AppChipSize size;
  final AppChipType type;
  final double spacing;
  final double runSpacing;
  final bool wrap;
  final int? maxSelection;

  void _handleTap(int index) {
    final newSelection = Set<int>.from(selectedIndices);
    if (newSelection.contains(index)) {
      newSelection.remove(index);
    } else {
      if (maxSelection == null || newSelection.length < maxSelection!) {
        newSelection.add(index);
      }
    }
    onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final children = items.asMap().entries.map((entry) {
      return AppChip(
        label: entry.value,
        isSelected: selectedIndices.contains(entry.key),
        type: type,
        size: size,
        onTap: () => _handleTap(entry.key),
      );
    }).toList();

    if (wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children.map((chip) {
          return Padding(
            padding: EdgeInsets.only(right: spacing),
            child: chip,
          );
        }).toList(),
      ),
    );
  }
}

/// 입력 칩 (삭제 가능)
class AppInputChip extends StatelessWidget {
  const AppInputChip({
    super.key,
    required this.label,
    required this.onDeleted,
    this.avatar,
    this.size = AppChipSize.medium,
    this.backgroundColor,
    this.textColor,
  });

  final String label;
  final VoidCallback onDeleted;
  final Widget? avatar;
  final AppChipSize size;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: label,
      avatar: avatar,
      type: AppChipType.tonal,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onDelete: onDeleted,
    );
  }
}

/// 액션 칩 (아이콘 + 텍스트)
class AppActionChip extends StatelessWidget {
  const AppActionChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.svgIcon,
    this.size = AppChipSize.medium,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? svgIcon;
  final AppChipSize size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: isLoading ? '로딩...' : label,
      leadingIcon: isLoading ? null : icon,
      leadingSvgIcon: isLoading ? null : svgIcon,
      type: AppChipType.outlined,
      size: size,
      isDisabled: isLoading,
      onTap: onPressed,
    );
  }
}

/// 태그 칩 (해시태그용)
class AppTagChip extends StatelessWidget {
  const AppTagChip({
    super.key,
    required this.tag,
    this.onTap,
    this.size = AppChipSize.small,
    this.showHashSymbol = true,
  });

  final String tag;
  final VoidCallback? onTap;
  final AppChipSize size;
  final bool showHashSymbol;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: showHashSymbol ? '#$tag' : tag,
      type: AppChipType.tonal,
      size: size,
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      textColor: AppColors.primary,
      onTap: onTap,
    );
  }
}

/// 상태 칩 (경기 상태 표시용)
enum AppMatchStatus {
  live,
  upcoming,
  finished,
  postponed,
  cancelled,
}

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.status,
    this.customLabel,
    this.useFigmaStyle = true,
    this.fontType = ChipFontType.mid,
  });

  final AppMatchStatus status;
  final String? customLabel;
  final bool useFigmaStyle;
  final ChipFontType fontType;

  String _getLabel() {
    if (customLabel != null) return customLabel!;
    switch (status) {
      case AppMatchStatus.live:
        return 'LIVE';
      case AppMatchStatus.upcoming:
        return '예정';
      case AppMatchStatus.finished:
        return '종료';
      case AppMatchStatus.postponed:
        return '연기';
      case AppMatchStatus.cancelled:
        return '취소';
    }
  }

  ChipStatus _getFigmaStatus() {
    switch (status) {
      case AppMatchStatus.live:
        return ChipStatus.errorIncrease; // 빨간 배경
      case AppMatchStatus.upcoming:
        return ChipStatus.decrease; // 파란 배경
      case AppMatchStatus.finished:
        return ChipStatus.contents1; // 회색 배경
      case AppMatchStatus.postponed:
        return ChipStatus.electricNormal; // 노란 배경
      case AppMatchStatus.cancelled:
        return ChipStatus.hot; // 빨간 컨테이너 배경
    }
  }

  @override
  Widget build(BuildContext context) {
    if (useFigmaStyle) {
      return Chips(
        label: _getLabel(),
        status: _getFigmaStatus(),
        fontType: fontType,
      );
    }

    // Legacy 스타일
    Color bgColor;
    switch (status) {
      case AppMatchStatus.live:
        bgColor = AppColors.negative;
        break;
      case AppMatchStatus.upcoming:
        bgColor = AppColors.positive;
        break;
      case AppMatchStatus.finished:
        bgColor = AppColors.contentsNormal;
        break;
      case AppMatchStatus.postponed:
        bgColor = AppColors.yellow;
        break;
      case AppMatchStatus.cancelled:
        bgColor = AppColors.negative;
        break;
    }

    return AppChip(
      label: _getLabel(),
      type: AppChipType.filled,
      size: AppChipSize.small,
      backgroundColor: bgColor,
      textColor: Colors.white,
    );
  }
}

/// 리그 칩 (리그 선택용)
class AppLeagueChip extends StatelessWidget {
  const AppLeagueChip({
    super.key,
    required this.name,
    this.logoUrl,
    this.logoAsset,
    this.onTap,
    this.isSelected = false,
    this.size = AppChipSize.medium,
  });

  final String name;
  final String? logoUrl;
  final String? logoAsset;
  final VoidCallback? onTap;
  final bool isSelected;
  final AppChipSize size;

  double _getLogoSize() {
    switch (size) {
      case AppChipSize.small:
        return 14;
      case AppChipSize.medium:
        return 18;
      case AppChipSize.large:
        return 22;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? avatar;
    if (logoAsset != null) {
      avatar = SvgPicture.asset(
        logoAsset!,
        width: _getLogoSize(),
        height: _getLogoSize(),
      );
    } else if (logoUrl != null) {
      avatar = ClipOval(
        child: Image.network(
          logoUrl!,
          width: _getLogoSize(),
          height: _getLogoSize(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.sports_soccer,
            size: _getLogoSize(),
            color: AppColors.textHint,
          ),
        ),
      );
    }

    return AppChip(
      label: name,
      avatar: avatar,
      type: AppChipType.outlined,
      size: size,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

/// 팀 칩 (팀 선택용)
class AppTeamChip extends StatelessWidget {
  const AppTeamChip({
    super.key,
    required this.name,
    this.logoUrl,
    this.logoAsset,
    this.onTap,
    this.onRemove,
    this.isSelected = false,
    this.size = AppChipSize.medium,
  });

  final String name;
  final String? logoUrl;
  final String? logoAsset;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final bool isSelected;
  final AppChipSize size;

  double _getLogoSize() {
    switch (size) {
      case AppChipSize.small:
        return 14;
      case AppChipSize.medium:
        return 18;
      case AppChipSize.large:
        return 22;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? avatar;
    if (logoAsset != null) {
      avatar = SvgPicture.asset(
        logoAsset!,
        width: _getLogoSize(),
        height: _getLogoSize(),
      );
    } else if (logoUrl != null) {
      avatar = ClipOval(
        child: Image.network(
          logoUrl!,
          width: _getLogoSize(),
          height: _getLogoSize(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.shield,
            size: _getLogoSize(),
            color: AppColors.textHint,
          ),
        ),
      );
    }

    return AppChip(
      label: name,
      avatar: avatar,
      type: AppChipType.tonal,
      size: size,
      isSelected: isSelected,
      onTap: onTap,
      onDelete: onRemove,
    );
  }
}

/// 날짜 칩 (날짜 선택용)
class AppDateChip extends StatelessWidget {
  const AppDateChip({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
    this.size = AppChipSize.medium,
    this.format = DateChipFormat.dayMonth,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;
  final AppChipSize size;
  final DateChipFormat format;

  String _formatDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    final difference = targetDate.difference(today).inDays;

    if (difference == 0) return '오늘';
    if (difference == 1) return '내일';
    if (difference == -1) return '어제';

    switch (format) {
      case DateChipFormat.dayMonth:
        return '${date.month}/${date.day}';
      case DateChipFormat.weekday:
        const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
        return weekdays[date.weekday - 1];
      case DateChipFormat.full:
        return '${date.month}/${date.day} (${_getWeekday()})';
    }
  }

  String _getWeekday() {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: _formatDate(),
      type: AppChipType.outlined,
      size: size,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

enum DateChipFormat {
  dayMonth,
  weekday,
  full,
}

/// 시간 필터 칩 그룹
class AppTimeFilterChipGroup extends StatelessWidget {
  const AppTimeFilterChipGroup({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.size = AppChipSize.medium,
    this.filters = const [
      TimeFilter.all,
      TimeFilter.today,
      TimeFilter.thisWeek,
      TimeFilter.thisMonth,
    ],
  });

  final TimeFilter selectedFilter;
  final ValueChanged<TimeFilter> onFilterChanged;
  final AppChipSize size;
  final List<TimeFilter> filters;

  String _getLabel(TimeFilter filter) {
    switch (filter) {
      case TimeFilter.all:
        return '전체';
      case TimeFilter.today:
        return '오늘';
      case TimeFilter.yesterday:
        return '어제';
      case TimeFilter.thisWeek:
        return '이번 주';
      case TimeFilter.lastWeek:
        return '지난 주';
      case TimeFilter.thisMonth:
        return '이번 달';
      case TimeFilter.lastMonth:
        return '지난 달';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AppChip(
              label: _getLabel(filter),
              type: AppChipType.outlined,
              size: size,
              isSelected: selectedFilter == filter,
              onTap: () => onFilterChanged(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

enum TimeFilter {
  all,
  today,
  yesterday,
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
}

/// 스포츠 타입 칩
class AppSportTypeChip extends StatelessWidget {
  const AppSportTypeChip({
    super.key,
    required this.sportType,
    this.onTap,
    this.isSelected = false,
    this.size = AppChipSize.medium,
    this.showIcon = true,
  });

  final SportType sportType;
  final VoidCallback? onTap;
  final bool isSelected;
  final AppChipSize size;
  final bool showIcon;

  String _getLabel() {
    switch (sportType) {
      case SportType.soccer:
        return '축구';
      case SportType.baseball:
        return '야구';
      case SportType.basketball:
        return '농구';
      case SportType.volleyball:
        return '배구';
      case SportType.hockey:
        return '하키';
      case SportType.tennis:
        return '테니스';
      case SportType.esports:
        return 'e스포츠';
    }
  }

  IconData _getIcon() {
    switch (sportType) {
      case SportType.soccer:
        return Icons.sports_soccer;
      case SportType.baseball:
        return Icons.sports_baseball;
      case SportType.basketball:
        return Icons.sports_basketball;
      case SportType.volleyball:
        return Icons.sports_volleyball;
      case SportType.hockey:
        return Icons.sports_hockey;
      case SportType.tennis:
        return Icons.sports_tennis;
      case SportType.esports:
        return Icons.sports_esports;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: _getLabel(),
      leadingIcon: showIcon ? _getIcon() : null,
      type: AppChipType.outlined,
      size: size,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

enum SportType {
  soccer,
  baseball,
  basketball,
  volleyball,
  hockey,
  tennis,
  esports,
}

/// 점수 칩 (승/무/패 표시)
class AppResultChip extends StatelessWidget {
  const AppResultChip({
    super.key,
    required this.result,
    this.useFigmaStyle = true,
    this.fontType = ChipFontType.bold,
  });

  final MatchResult result;
  final bool useFigmaStyle;
  final ChipFontType fontType;

  String _getLabel() {
    switch (result) {
      case MatchResult.win:
        return '승';
      case MatchResult.draw:
        return '무';
      case MatchResult.lose:
        return '패';
    }
  }

  ChipStatus _getFigmaStatus() {
    switch (result) {
      case MatchResult.win:
        return ChipStatus.gasBad; // 초록 배경 (승리)
      case MatchResult.draw:
        return ChipStatus.contents1; // 회색 배경 (무승부)
      case MatchResult.lose:
        return ChipStatus.errorIncrease; // 빨간 배경 (패배)
    }
  }

  @override
  Widget build(BuildContext context) {
    if (useFigmaStyle) {
      return Chips(
        label: _getLabel(),
        status: _getFigmaStatus(),
        fontType: fontType,
      );
    }

    // Legacy 스타일
    Color bgColor;
    switch (result) {
      case MatchResult.win:
        bgColor = AppColors.positiveGreen;
        break;
      case MatchResult.draw:
        bgColor = AppColors.contentsNormal;
        break;
      case MatchResult.lose:
        bgColor = AppColors.negative;
        break;
    }

    return AppChip(
      label: _getLabel(),
      type: AppChipType.filled,
      size: AppChipSize.small,
      backgroundColor: bgColor,
      textColor: Colors.white,
    );
  }
}

enum MatchResult {
  win,
  draw,
  lose,
}

/// 카운트 칩 (숫자 표시)
class AppCountChip extends StatelessWidget {
  const AppCountChip({
    super.key,
    required this.label,
    required this.count,
    this.onTap,
    this.isSelected = false,
    this.size = AppChipSize.medium,
  });

  final String label;
  final int count;
  final VoidCallback? onTap;
  final bool isSelected;
  final AppChipSize size;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: '$label ($count)',
      type: AppChipType.outlined,
      size: size,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

/// 프로토 칩 (배당률 표시)
class AppOddsChip extends StatelessWidget {
  const AppOddsChip({
    super.key,
    required this.label,
    required this.odds,
    this.onTap,
    this.isSelected = false,
    this.size = AppChipSize.medium,
    this.isHighlighted = false,
  });

  final String label;
  final double odds;
  final VoidCallback? onTap;
  final bool isSelected;
  final AppChipSize size;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : isHighlighted
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : isHighlighted
                    ? AppColors.primary
                    : AppColors.border,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.caption1Medium.copyWith(
                color: isSelected
                    ? Colors.white
                    : isHighlighted
                        ? AppColors.primary
                        : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              odds.toStringAsFixed(2),
              style: AppTextStyles.label1NormalBold.copyWith(
                color: isSelected
                    ? Colors.white
                    : isHighlighted
                        ? AppColors.primary
                        : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 뱃지 칩 (NEW, HOT 등)
class AppBadgeChip extends StatelessWidget {
  const AppBadgeChip({
    super.key,
    required this.label,
    this.type = BadgeChipType.primary,
    this.useFigmaStyle = true,
    this.fontType = ChipFontType.bold,
  });

  final String label;
  final BadgeChipType type;
  final bool useFigmaStyle;
  final ChipFontType fontType;

  /// NEW 뱃지
  factory AppBadgeChip.newBadge({bool useFigmaStyle = true}) {
    return AppBadgeChip(
      label: 'NEW',
      type: BadgeChipType.info,
      useFigmaStyle: useFigmaStyle,
    );
  }

  /// HOT 뱃지
  factory AppBadgeChip.hot({bool useFigmaStyle = true}) {
    return AppBadgeChip(
      label: 'HOT',
      type: BadgeChipType.error,
      useFigmaStyle: useFigmaStyle,
    );
  }

  /// 추천 뱃지
  factory AppBadgeChip.recommended({bool useFigmaStyle = true}) {
    return AppBadgeChip(
      label: '추천',
      type: BadgeChipType.success,
      useFigmaStyle: useFigmaStyle,
    );
  }

  /// 인기 뱃지
  factory AppBadgeChip.popular({bool useFigmaStyle = true}) {
    return AppBadgeChip(
      label: '인기',
      type: BadgeChipType.warning,
      useFigmaStyle: useFigmaStyle,
    );
  }

  ChipStatus _getFigmaStatus() {
    switch (type) {
      case BadgeChipType.primary:
        return ChipStatus.active;
      case BadgeChipType.success:
        return ChipStatus.gasBad;
      case BadgeChipType.warning:
        return ChipStatus.electricNormal;
      case BadgeChipType.error:
        return ChipStatus.errorIncrease;
      case BadgeChipType.info:
        return ChipStatus.decrease;
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case BadgeChipType.primary:
        return AppColors.primaryFigma;
      case BadgeChipType.success:
        return AppColors.positiveGreen;
      case BadgeChipType.warning:
        return AppColors.yellow;
      case BadgeChipType.error:
        return AppColors.negative;
      case BadgeChipType.info:
        return AppColors.positive;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (useFigmaStyle) {
      return Chips(
        label: label,
        status: _getFigmaStatus(),
        fontType: fontType,
      );
    }

    // Legacy 스타일
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption2Bold.copyWith(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}

enum BadgeChipType {
  primary,
  success,
  warning,
  error,
  info,
}
