import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';

/// 네비게이션 바 메뉴 아이템 정의
enum AppNavigationItem {
  /// 홈
  home,

  /// 픽전문가
  pickExpert,

  /// 커뮤니티
  community,

  /// 랭킹
  ranking,

  /// MY
  my,
}

/// AppNavigationItem 확장
extension AppNavigationItemExtension on AppNavigationItem {
  /// 메뉴 아이템의 한글 라벨
  String get label {
    switch (this) {
      case AppNavigationItem.home:
        return '홈';
      case AppNavigationItem.pickExpert:
        return '픽전문가';
      case AppNavigationItem.community:
        return '커뮤니티';
      case AppNavigationItem.ranking:
        return '랭킹';
      case AppNavigationItem.my:
        return 'MY';
    }
  }

  /// 비활성화 상태 아이콘 경로
  String get icon {
    switch (this) {
      case AppNavigationItem.home:
        return AppIcons.home;
      case AppNavigationItem.pickExpert:
        return AppIcons.check;
      case AppNavigationItem.community:
        return AppIcons.persons;
      case AppNavigationItem.ranking:
        return AppIcons.trophy;
      case AppNavigationItem.my:
        return AppIcons.person;
    }
  }

  /// 활성화 상태 아이콘 경로
  String get activeIcon {
    switch (this) {
      case AppNavigationItem.home:
        return AppIcons.homeFill;
      case AppNavigationItem.pickExpert:
        return AppIcons.checkThick;
      case AppNavigationItem.community:
        return AppIcons.personsFill;
      case AppNavigationItem.ranking:
        return AppIcons.trophyFill;
      case AppNavigationItem.my:
        return AppIcons.personFill;
    }
  }
}

/// Figma 디자인 기반 하단 네비게이션 바 컴포넌트
///
/// 5개의 메뉴 아이템(홈, 픽전문가, 커뮤니티, 랭킹, MY)을 포함하며,
/// 각 메뉴의 활성/비활성 상태에 따라 아이콘과 텍스트 스타일이 변경됩니다.
///
/// 사용 예시:
/// ```dart
/// AppNavigationBar(
///   currentIndex: 0,
///   onTap: (index) {
///     setState(() {
///       _currentIndex = index;
///     });
///   },
/// )
/// ```
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = AppNavigationItem.values,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.showBorder = true,
  });

  /// 현재 선택된 메뉴 인덱스
  final int currentIndex;

  /// 메뉴 탭 콜백
  final ValueChanged<int> onTap;

  /// 표시할 메뉴 아이템 목록 (기본값: 모든 아이템)
  final List<AppNavigationItem> items;

  /// 배경 색상 (기본값: layerElevated)
  final Color? backgroundColor;

  /// 활성화 상태 색상 (기본값: primaryFigma)
  final Color? activeColor;

  /// 비활성화 상태 색상 (기본값: labelAlternative)
  final Color? inactiveColor;

  /// 상단 테두리 표시 여부
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.layerElevated,
        border: showBorder
            ? const Border(
                top: BorderSide(
                  color: AppColors.borderNormal,
                  width: 1,
                ),
              )
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return _NavigationBarItem(
                item: item,
                isSelected: isSelected,
                activeColor: activeColor ?? AppColors.primaryFigma,
                inactiveColor: inactiveColor ?? AppColors.labelAlternative,
                onTap: () => onTap(index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// 네비게이션 바 개별 메뉴 아이템 위젯
class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final AppNavigationItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;
    final textStyle = isSelected
        ? AppTextStyles.label1NormalBold.copyWith(color: color)
        : AppTextStyles.label1NormalMedium.copyWith(color: color);
    final iconPath = isSelected ? item.activeIcon : item.icon;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 54,
        height: 50,
        padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 아이콘
            SizedBox(
              height: 24,
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 2),
            // 라벨
            Text(
              item.label,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Flutter BottomNavigationBar와 호환되는 네비게이션 바
///
/// Scaffold.bottomNavigationBar에서 직접 사용할 수 있습니다.
///
/// 사용 예시:
/// ```dart
/// Scaffold(
///   bottomNavigationBar: AppBottomNavigationBar(
///     currentIndex: _currentIndex,
///     onTap: (index) {
///       setState(() {
///         _currentIndex = index;
///       });
///     },
///   ),
/// )
/// ```
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.showBorder = true,
  });

  /// 현재 선택된 메뉴 인덱스
  final int currentIndex;

  /// 메뉴 탭 콜백
  final ValueChanged<int> onTap;

  /// 커스텀 메뉴 아이템 목록 (null인 경우 기본 아이템 사용)
  final List<AppBottomNavigationBarItem>? items;

  /// 배경 색상 (기본값: layerElevated)
  final Color? backgroundColor;

  /// 활성화 상태 색상 (기본값: primaryFigma)
  final Color? activeColor;

  /// 비활성화 상태 색상 (기본값: labelAlternative)
  final Color? inactiveColor;

  /// 상단 테두리 표시 여부
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    // 기본 아이템 사용
    if (items == null) {
      return AppNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        showBorder: showBorder,
      );
    }

    // 커스텀 아이템 사용
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.layerElevated,
        border: showBorder
            ? const Border(
                top: BorderSide(
                  color: AppColors.borderNormal,
                  width: 1,
                ),
              )
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items!.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return _CustomNavigationBarItem(
                item: item,
                isSelected: isSelected,
                activeColor: activeColor ?? AppColors.primaryFigma,
                inactiveColor: inactiveColor ?? AppColors.labelAlternative,
                onTap: () => onTap(index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// 커스텀 네비게이션 바 아이템 데이터 클래스
class AppBottomNavigationBarItem {
  const AppBottomNavigationBarItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });

  /// 메뉴 라벨
  final String label;

  /// 비활성화 상태 아이콘 경로
  final String icon;

  /// 활성화 상태 아이콘 경로 (null인 경우 icon 사용)
  final String? activeIcon;

  /// 배지 (알림 수 등)
  final int? badge;
}

/// 커스텀 네비게이션 바 아이템 위젯
class _CustomNavigationBarItem extends StatelessWidget {
  const _CustomNavigationBarItem({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final AppBottomNavigationBarItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;
    final textStyle = isSelected
        ? AppTextStyles.label1NormalBold.copyWith(color: color)
        : AppTextStyles.label1NormalMedium.copyWith(color: color);
    final iconPath = isSelected ? (item.activeIcon ?? item.icon) : item.icon;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 54,
        height: 50,
        padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 아이콘 + 배지
            SizedBox(
              height: 24,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                  // 배지
                  if (item.badge != null && item.badge! > 0)
                    Positioned(
                      top: -4,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.negative,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Center(
                          child: Text(
                            item.badge! > 99 ? '99+' : item.badge.toString(),
                            style: AppTextStyles.caption2Bold.copyWith(
                              color: AppColors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            // 라벨
            Text(
              item.label,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}