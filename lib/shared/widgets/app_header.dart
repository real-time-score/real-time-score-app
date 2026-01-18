import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';

/// 헤더 버튼 아이콘 타입
enum AppHeaderButtonType {
  /// 뒤로가기 (chevronLeft)
  back,

  /// 닫기 (close)
  close,

  /// 설정 (setting)
  setting,

  /// 검색 (search)
  search,

  /// 알림 (bell)
  notification,

  /// AI/스파클 (sparkle)
  sparkle,

  /// 더보기 (moreVertical)
  more,

  /// 공유 (share)
  share,

  /// 필터 (filter)
  filter,

  /// 수정 (pencil)
  edit,

  /// 커스텀 아이콘
  custom,
}

/// Figma 디자인 기반 앱 헤더 컴포넌트
///
/// 네비게이션 헤더로 사용되며, 좌측/우측 버튼과 중앙 타이틀을 지원합니다.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.onBackPressed,
    this.leftButtonType,
    this.leftButtonIcon,
    this.onLeftButtonPressed,
    this.rightButtonType,
    this.rightButtonIcon,
    this.onRightButtonPressed,
    this.rightButtons,
    this.backgroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.titleStyle,
    this.height = 48,
    this.horizontalPadding = 0,
  });

  /// 타이틀 텍스트
  final String? title;

  /// 커스텀 타이틀 위젯 (title보다 우선)
  final Widget? titleWidget;

  /// 뒤로가기 버튼 표시 여부 (기본: true)
  final bool showBackButton;

  /// 뒤로가기 버튼 콜백
  final VoidCallback? onBackPressed;

  /// 좌측 버튼 타입 (showBackButton이 false일 때 사용)
  final AppHeaderButtonType? leftButtonType;

  /// 좌측 커스텀 아이콘 (leftButtonType이 custom일 때)
  final String? leftButtonIcon;

  /// 좌측 버튼 콜백
  final VoidCallback? onLeftButtonPressed;

  /// 우측 버튼 타입
  final AppHeaderButtonType? rightButtonType;

  /// 우측 커스텀 아이콘 (rightButtonType이 custom일 때)
  final String? rightButtonIcon;

  /// 우측 버튼 콜백
  final VoidCallback? onRightButtonPressed;

  /// 여러 개의 우측 버튼 (rightButtonType보다 우선)
  final List<AppHeaderAction>? rightButtons;

  /// 배경 색상
  final Color? backgroundColor;

  /// 그림자 elevation
  final double elevation;

  /// 타이틀 중앙 정렬 여부
  final bool centerTitle;

  /// 타이틀 스타일
  final TextStyle? titleStyle;

  /// 헤더 높이
  final double height;

  /// 좌우 패딩
  final double horizontalPadding;

  /// 뒤로가기만 있는 기본 헤더
  factory AppHeader.simple({
    Key? key,
    VoidCallback? onBackPressed,
    Color? backgroundColor,
  }) {
    return AppHeader(
      key: key,
      showBackButton: true,
      onBackPressed: onBackPressed,
      backgroundColor: backgroundColor,
    );
  }

  /// 뒤로가기 + 타이틀
  factory AppHeader.withTitle({
    Key? key,
    required String title,
    VoidCallback? onBackPressed,
    Color? backgroundColor,
    TextStyle? titleStyle,
  }) {
    return AppHeader(
      key: key,
      title: title,
      showBackButton: true,
      onBackPressed: onBackPressed,
      backgroundColor: backgroundColor,
      titleStyle: titleStyle,
    );
  }

  /// 뒤로가기 + 타이틀 + 우측 액션
  factory AppHeader.withAction({
    Key? key,
    String? title,
    VoidCallback? onBackPressed,
    required AppHeaderButtonType actionType,
    required VoidCallback onActionPressed,
    String? customIcon,
    Color? backgroundColor,
  }) {
    return AppHeader(
      key: key,
      title: title,
      showBackButton: true,
      onBackPressed: onBackPressed,
      rightButtonType: actionType,
      rightButtonIcon: customIcon,
      onRightButtonPressed: onActionPressed,
      backgroundColor: backgroundColor,
    );
  }

  /// 뒤로가기 + 스파클 아이콘 (Figma 기본 디자인)
  factory AppHeader.withSparkle({
    Key? key,
    VoidCallback? onBackPressed,
    required VoidCallback onSparklePressed,
    Color? backgroundColor,
  }) {
    return AppHeader(
      key: key,
      showBackButton: true,
      onBackPressed: onBackPressed,
      rightButtonType: AppHeaderButtonType.sparkle,
      onRightButtonPressed: onSparklePressed,
      backgroundColor: backgroundColor,
    );
  }

  /// 닫기 버튼 헤더
  factory AppHeader.close({
    Key? key,
    String? title,
    required VoidCallback onClosePressed,
    Color? backgroundColor,
  }) {
    return AppHeader(
      key: key,
      title: title,
      showBackButton: false,
      leftButtonType: AppHeaderButtonType.close,
      onLeftButtonPressed: onClosePressed,
      backgroundColor: backgroundColor,
    );
  }

  /// 여러 우측 액션이 있는 헤더
  factory AppHeader.withMultipleActions({
    Key? key,
    String? title,
    VoidCallback? onBackPressed,
    required List<AppHeaderAction> actions,
    Color? backgroundColor,
  }) {
    return AppHeader(
      key: key,
      title: title,
      showBackButton: true,
      onBackPressed: onBackPressed,
      rightButtons: actions,
      backgroundColor: backgroundColor,
    );
  }

  String _getIconPath(AppHeaderButtonType type, String? customIcon) {
    switch (type) {
      case AppHeaderButtonType.back:
        return AppIcons.chevronLeft;
      case AppHeaderButtonType.close:
        return AppIcons.close;
      case AppHeaderButtonType.setting:
        return AppIcons.setting;
      case AppHeaderButtonType.search:
        return AppIcons.search;
      case AppHeaderButtonType.notification:
        return AppIcons.bell;
      case AppHeaderButtonType.sparkle:
        return AppIcons.sparkle;
      case AppHeaderButtonType.more:
        return AppIcons.moreVertical;
      case AppHeaderButtonType.share:
        return AppIcons.share;
      case AppHeaderButtonType.filter:
        return AppIcons.filter;
      case AppHeaderButtonType.edit:
        return AppIcons.pencil;
      case AppHeaderButtonType.custom:
        return customIcon ?? AppIcons.blank;
    }
  }

  Widget _buildIconButton({
    required String iconPath,
    required VoidCallback? onPressed,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                iconColor ?? AppColors.labelNormal,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildLeftButton(BuildContext context) {
    if (showBackButton) {
      return _buildIconButton(
        iconPath: AppIcons.chevronLeft,
        onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
      );
    }

    if (leftButtonType != null) {
      return _buildIconButton(
        iconPath: _getIconPath(leftButtonType!, leftButtonIcon),
        onPressed: onLeftButtonPressed,
      );
    }

    // 좌측 버튼이 없으면 공간 확보를 위한 빈 위젯
    return const SizedBox(width: 48);
  }

  Widget? _buildRightButton() {
    if (rightButtons != null && rightButtons!.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: rightButtons!.map((action) {
          return _buildIconButton(
            iconPath: _getIconPath(action.type, action.customIcon),
            onPressed: action.onPressed,
            iconColor: action.iconColor,
          );
        }).toList(),
      );
    }

    if (rightButtonType != null) {
      return _buildIconButton(
        iconPath: _getIconPath(rightButtonType!, rightButtonIcon),
        onPressed: onRightButtonPressed,
      );
    }

    // 우측 버튼이 없으면 공간 확보를 위한 빈 위젯
    return const SizedBox(width: 48);
  }

  Widget? _buildTitle() {
    if (titleWidget != null) {
      return titleWidget;
    }

    if (title != null) {
      return Text(
        title!,
        style: titleStyle ?? AppTextStyles.h4Medium,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 좌측 버튼
              Positioned(
                left: 0,
                child: _buildLeftButton(context) ?? const SizedBox.shrink(),
              ),
              // 타이틀
              if (centerTitle)
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 56),
                      child: _buildTitle(),
                    ),
                  ),
                )
              else
                Positioned(
                  left: 56,
                  right: 56,
                  child: _buildTitle() ?? const SizedBox.shrink(),
                ),
              // 우측 버튼
              Positioned(
                right: 0,
                child: _buildRightButton() ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

/// 헤더 우측 액션 버튼 정의
class AppHeaderAction {
  const AppHeaderAction({
    required this.type,
    required this.onPressed,
    this.customIcon,
    this.iconColor,
    this.tooltip,
  });

  /// 버튼 타입
  final AppHeaderButtonType type;

  /// 클릭 콜백
  final VoidCallback onPressed;

  /// 커스텀 아이콘 경로 (type이 custom일 때)
  final String? customIcon;

  /// 아이콘 색상
  final Color? iconColor;

  /// 툴팁 텍스트
  final String? tooltip;

  /// 검색 버튼 생성
  factory AppHeaderAction.search({
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.search,
      onPressed: onPressed,
      tooltip: tooltip ?? '검색',
    );
  }

  /// 알림 버튼 생성
  factory AppHeaderAction.notification({
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.notification,
      onPressed: onPressed,
      tooltip: tooltip ?? '알림',
    );
  }

  /// 설정 버튼 생성
  factory AppHeaderAction.setting({
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.setting,
      onPressed: onPressed,
      tooltip: tooltip ?? '설정',
    );
  }

  /// 더보기 버튼 생성
  factory AppHeaderAction.more({
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.more,
      onPressed: onPressed,
      tooltip: tooltip ?? '더보기',
    );
  }

  /// 공유 버튼 생성
  factory AppHeaderAction.share({
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.share,
      onPressed: onPressed,
      tooltip: tooltip ?? '공유',
    );
  }

  /// 커스텀 아이콘 버튼 생성
  factory AppHeaderAction.custom({
    required String iconPath,
    required VoidCallback onPressed,
    Color? iconColor,
    String? tooltip,
  }) {
    return AppHeaderAction(
      type: AppHeaderButtonType.custom,
      customIcon: iconPath,
      onPressed: onPressed,
      iconColor: iconColor,
      tooltip: tooltip,
    );
  }
}

/// 슬리버 앱바용 헤더
class AppSliverHeader extends StatelessWidget {
  const AppSliverHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.onBackPressed,
    this.rightButtonType,
    this.rightButtonIcon,
    this.onRightButtonPressed,
    this.rightButtons,
    this.backgroundColor,
    this.expandedHeight = 120,
    this.collapsedHeight = 48,
    this.flexibleSpace,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
  });

  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final AppHeaderButtonType? rightButtonType;
  final String? rightButtonIcon;
  final VoidCallback? onRightButtonPressed;
  final List<AppHeaderAction>? rightButtons;
  final Color? backgroundColor;
  final double expandedHeight;
  final double collapsedHeight;
  final Widget? flexibleSpace;
  final bool pinned;
  final bool floating;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      pinned: pinned,
      floating: floating,
      snap: snap,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
              icon: SvgPicture.asset(
                AppIcons.chevronLeft,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.labelNormal,
                  BlendMode.srcIn,
                ),
              ),
            )
          : null,
      title: titleWidget ?? (title != null ? Text(title!, style: AppTextStyles.h4Medium) : null),
      centerTitle: true,
      actions: _buildActions(),
      flexibleSpace: flexibleSpace,
    );
  }

  List<Widget>? _buildActions() {
    if (rightButtons != null && rightButtons!.isNotEmpty) {
      return rightButtons!.map((action) {
        return IconButton(
          onPressed: action.onPressed,
          tooltip: action.tooltip,
          icon: SvgPicture.asset(
            _getIconPath(action.type, action.customIcon),
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              action.iconColor ?? AppColors.labelNormal,
              BlendMode.srcIn,
            ),
          ),
        );
      }).toList();
    }

    if (rightButtonType != null) {
      return [
        IconButton(
          onPressed: onRightButtonPressed,
          icon: SvgPicture.asset(
            _getIconPath(rightButtonType!, rightButtonIcon),
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.labelNormal,
              BlendMode.srcIn,
            ),
          ),
        ),
      ];
    }

    return null;
  }

  String _getIconPath(AppHeaderButtonType type, String? customIcon) {
    switch (type) {
      case AppHeaderButtonType.back:
        return AppIcons.chevronLeft;
      case AppHeaderButtonType.close:
        return AppIcons.close;
      case AppHeaderButtonType.setting:
        return AppIcons.setting;
      case AppHeaderButtonType.search:
        return AppIcons.search;
      case AppHeaderButtonType.notification:
        return AppIcons.bell;
      case AppHeaderButtonType.sparkle:
        return AppIcons.sparkle;
      case AppHeaderButtonType.more:
        return AppIcons.moreVertical;
      case AppHeaderButtonType.share:
        return AppIcons.share;
      case AppHeaderButtonType.filter:
        return AppIcons.filter;
      case AppHeaderButtonType.edit:
        return AppIcons.pencil;
      case AppHeaderButtonType.custom:
        return customIcon ?? AppIcons.blank;
    }
  }
}
