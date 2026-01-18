import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';

/// Menu 컴포넌트 타입 정의 (Figma 기반)
enum AppMenuType {
  /// 아이콘 + Bold 텍스트 (기본)
  iconWithLabel,

  /// 아이콘 + Bold 텍스트 + 테두리
  iconWithLabelBordered,

  /// Medium 텍스트 + 스위치 토글
  labelWithSwitch,

  /// Medium 텍스트 + 체크 아이콘 (선택됨)
  labelWithCheck,

  /// 텍스트만 (placeholder 스타일)
  labelOnly,

  /// Medium 텍스트 + chevron right
  labelWithChevron,

  /// Primary 배경 + 아이콘 + 텍스트 + chevron
  primaryWithChevron,

  /// Primary 배경 + 아이콘 + 텍스트 (중앙 정렬)
  primaryCenter,

  /// 작은 텍스트 + chevron (48px 높이)
  labelSmallWithChevron,
}

/// Figma 디자인 기반 Menu 컴포넌트
///
/// 설정 화면, 리스트 메뉴, 네비게이션 등에 사용되는 공통 메뉴 아이템 위젯입니다.
class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
    required this.label,
    this.type = AppMenuType.iconWithLabel,
    this.svgIcon,
    this.onTap,
    this.switchValue,
    this.onSwitchChanged,
    this.isSelected = false,
    this.width,
  });

  final String label;
  final AppMenuType type;
  final String? svgIcon;
  final VoidCallback? onTap;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool isSelected;
  final double? width;

  /// 아이콘 + 레이블 기본 메뉴
  factory AppMenu.iconWithLabel({
    Key? key,
    required String label,
    required String svgIcon,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.iconWithLabel,
      svgIcon: svgIcon,
      onTap: onTap,
      width: width,
    );
  }

  /// 아이콘 + 레이블 + 테두리 메뉴
  factory AppMenu.iconWithLabelBordered({
    Key? key,
    required String label,
    required String svgIcon,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.iconWithLabelBordered,
      svgIcon: svgIcon,
      onTap: onTap,
      width: width,
    );
  }

  /// 스위치 토글 메뉴
  factory AppMenu.withSwitch({
    Key? key,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.labelWithSwitch,
      switchValue: value,
      onSwitchChanged: onChanged,
      width: width,
    );
  }

  /// 체크 표시 메뉴 (선택 가능)
  factory AppMenu.withCheck({
    Key? key,
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.labelWithCheck,
      isSelected: isSelected,
      onTap: onTap,
      width: width,
    );
  }

  /// 레이블만 있는 메뉴
  factory AppMenu.labelOnly({
    Key? key,
    required String label,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.labelOnly,
      onTap: onTap,
      width: width,
    );
  }

  /// 레이블 + 화살표 메뉴
  factory AppMenu.withChevron({
    Key? key,
    required String label,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.labelWithChevron,
      onTap: onTap,
      width: width,
    );
  }

  /// Primary 스타일 + 화살표 메뉴
  factory AppMenu.primaryWithChevron({
    Key? key,
    required String label,
    required String svgIcon,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.primaryWithChevron,
      svgIcon: svgIcon,
      onTap: onTap,
      width: width,
    );
  }

  /// Primary 스타일 중앙 정렬 메뉴
  factory AppMenu.primaryCenter({
    Key? key,
    required String label,
    required String svgIcon,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.primaryCenter,
      svgIcon: svgIcon,
      onTap: onTap,
      width: width,
    );
  }

  /// 작은 레이블 + 화살표 메뉴
  factory AppMenu.smallWithChevron({
    Key? key,
    required String label,
    VoidCallback? onTap,
    double? width,
  }) {
    return AppMenu(
      key: key,
      label: label,
      type: AppMenuType.labelSmallWithChevron,
      onTap: onTap,
      width: width,
    );
  }

  double _getHeight() {
    switch (type) {
      case AppMenuType.primaryWithChevron:
      case AppMenuType.primaryCenter:
      case AppMenuType.labelSmallWithChevron:
        return 48;
      default:
        return 56;
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case AppMenuType.iconWithLabel:
      case AppMenuType.labelOnly:
        return Colors.transparent;
      case AppMenuType.iconWithLabelBordered:
      case AppMenuType.labelWithSwitch:
      case AppMenuType.labelWithChevron:
      case AppMenuType.labelSmallWithChevron:
        return AppColors.containerNormal;
      case AppMenuType.labelWithCheck:
        return isSelected ? AppColors.primaryContainer : AppColors.containerNormal;
      case AppMenuType.primaryWithChevron:
      case AppMenuType.primaryCenter:
        return AppColors.primaryFigma;
    }
  }

  Border? _getBorder() {
    if (type == AppMenuType.iconWithLabelBordered) {
      return Border.all(color: AppColors.borderNormal, width: 1);
    }
    return null;
  }

  Color _getTextColor() {
    switch (type) {
      case AppMenuType.primaryWithChevron:
      case AppMenuType.primaryCenter:
        return AppColors.white;
      case AppMenuType.labelOnly:
        return AppColors.labelAlternative;
      default:
        return AppColors.labelNormal;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case AppMenuType.primaryWithChevron:
      case AppMenuType.primaryCenter:
        return AppColors.white;
      default:
        return AppColors.labelNormal;
    }
  }

  TextStyle _getTextStyle() {
    final color = _getTextColor();
    switch (type) {
      case AppMenuType.iconWithLabel:
      case AppMenuType.iconWithLabelBordered:
      case AppMenuType.primaryWithChevron:
      case AppMenuType.primaryCenter:
        return AppTextStyles.body1NormalBold.copyWith(color: color);
      case AppMenuType.labelSmallWithChevron:
        return AppTextStyles.label1NormalMedium.copyWith(color: color);
      default:
        return AppTextStyles.body1NormalMedium.copyWith(color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getBackgroundColor(),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: type == AppMenuType.labelWithSwitch ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          height: _getHeight(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: _getBorder(),
          ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case AppMenuType.iconWithLabel:
      case AppMenuType.iconWithLabelBordered:
        return _buildIconWithLabel();
      case AppMenuType.labelWithSwitch:
        return _buildLabelWithSwitch();
      case AppMenuType.labelWithCheck:
        return _buildLabelWithCheck();
      case AppMenuType.labelOnly:
        return _buildLabelOnly();
      case AppMenuType.labelWithChevron:
      case AppMenuType.labelSmallWithChevron:
        return _buildLabelWithChevron();
      case AppMenuType.primaryWithChevron:
        return _buildPrimaryWithChevron();
      case AppMenuType.primaryCenter:
        return _buildPrimaryCenter();
    }
  }

  Widget _buildIconWithLabel() {
    return Row(
      children: [
        if (svgIcon != null) ...[
          SvgPicture.asset(
            svgIcon!,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(_getIconColor(), BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            label,
            style: _getTextStyle(),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelWithSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: _getTextStyle(),
          ),
        ),
        _buildSwitch(),
      ],
    );
  }

  Widget _buildSwitch() {
    final value = switchValue ?? false;
    return GestureDetector(
      onTap: () => onSwitchChanged?.call(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: value ? AppColors.primaryFigma : AppColors.containerDisabled,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelWithCheck() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: _getTextStyle(),
          ),
        ),
        if (isSelected)
          SvgPicture.asset(
            AppIcons.circleCheckFill,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(AppColors.primaryFigma, BlendMode.srcIn),
          ),
      ],
    );
  }

  Widget _buildLabelOnly() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: _getTextStyle(),
      ),
    );
  }

  Widget _buildLabelWithChevron() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: _getTextStyle(),
          ),
        ),
        SvgPicture.asset(
          AppIcons.chevronRight,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(AppColors.labelNeutral, BlendMode.srcIn),
        ),
      ],
    );
  }

  Widget _buildPrimaryWithChevron() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgIcon != null) ...[
              SvgPicture.asset(
                svgIcon!,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(_getIconColor(), BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: _getTextStyle(),
            ),
          ],
        ),
        SvgPicture.asset(
          AppIcons.chevronRight,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      ],
    );
  }

  Widget _buildPrimaryCenter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (svgIcon != null) ...[
          SvgPicture.asset(
            svgIcon!,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(_getIconColor(), BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: _getTextStyle(),
        ),
      ],
    );
  }
}

/// Menu 그룹 위젯
///
/// 여러 Menu 아이템을 그룹으로 묶어서 표시합니다.
class AppMenuGroup extends StatelessWidget {
  const AppMenuGroup({
    super.key,
    required this.children,
    this.title,
    this.spacing = 8,
    this.padding,
  });

  final List<Widget> children;
  final String? title;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                title!,
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
          ],
          ...children.expand((child) sync* {
            yield child;
            if (child != children.last) {
              yield SizedBox(height: spacing);
            }
          }),
        ],
      ),
    );
  }
}
