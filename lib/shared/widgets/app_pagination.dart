import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Figma 디자인 기반 페이지네이션 컴포넌트
///
/// 페이지 목록을 숫자로 표시하고 이전/다음 버튼을 제공합니다.
class AppPagination extends StatelessWidget {
  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visiblePages = 6,
    this.showArrows = true,
  });

  /// 현재 페이지 (1부터 시작)
  final int currentPage;

  /// 전체 페이지 수
  final int totalPages;

  /// 페이지 변경 콜백
  final ValueChanged<int> onPageChanged;

  /// 표시할 페이지 숫자 개수 (기본값: 6)
  final int visiblePages;

  /// 이전/다음 화살표 표시 여부
  final bool showArrows;

  /// 표시할 페이지 범위 계산
  List<int> _getVisiblePageNumbers() {
    if (totalPages <= visiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    }

    int startPage = currentPage - (visiblePages ~/ 2);
    int endPage = currentPage + (visiblePages ~/ 2) - 1;

    if (startPage < 1) {
      startPage = 1;
      endPage = visiblePages;
    }

    if (endPage > totalPages) {
      endPage = totalPages;
      startPage = totalPages - visiblePages + 1;
    }

    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  @override
  Widget build(BuildContext context) {
    final visiblePageNumbers = _getVisiblePageNumbers();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 이전 버튼
        if (showArrows)
          _PaginationArrowButton(
            direction: _ArrowDirection.left,
            onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          ),

        // 페이지 숫자들
        ...visiblePageNumbers.map((page) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: _PaginationNumberButton(
            page: page,
            isSelected: page == currentPage,
            onPressed: () => onPageChanged(page),
          ),
        )),

        // 다음 버튼
        if (showArrows)
          _PaginationArrowButton(
            direction: _ArrowDirection.right,
            onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          ),
      ],
    );
  }
}

/// 화살표 방향
enum _ArrowDirection { left, right }

/// 페이지네이션 화살표 버튼
class _PaginationArrowButton extends StatelessWidget {
  const _PaginationArrowButton({
    required this.direction,
    this.onPressed,
  });

  final _ArrowDirection direction;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final iconPath = direction == _ArrowDirection.left
        ? 'assets/icons/chevron_left.svg'
        : 'assets/icons/chevron_right.svg';
    final iconColor = isEnabled ? AppColors.labelNormal : AppColors.labelDisabled;

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
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

/// 페이지네이션 숫자 버튼
class _PaginationNumberButton extends StatelessWidget {
  const _PaginationNumberButton({
    required this.page,
    required this.isSelected,
    required this.onPressed,
  });

  final int page;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? AppColors.containerSelected : Colors.transparent;
    final textColor = isSelected ? AppColors.labelNormal : AppColors.labelAlternative;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              page.toString(),
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: textColor,
                letterSpacing: -0.16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 점(dot) 스타일 페이지네이션 컴포넌트
///
/// 슬라이더나 캐러셀에서 현재 위치를 점으로 표시합니다.
class AppDotPagination extends StatelessWidget {
  const AppDotPagination({
    super.key,
    required this.currentIndex,
    required this.totalCount,
    this.onDotTap,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.activeDotWidth,
    this.spacing = 8,
  });

  /// 현재 인덱스 (0부터 시작)
  final int currentIndex;

  /// 전체 개수
  final int totalCount;

  /// 점 탭 콜백
  final ValueChanged<int>? onDotTap;

  /// 활성 점 색상
  final Color? activeColor;

  /// 비활성 점 색상
  final Color? inactiveColor;

  /// 점 크기
  final double dotSize;

  /// 활성 점 너비 (null이면 dotSize와 동일)
  final double? activeDotWidth;

  /// 점 사이 간격
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalCount, (index) {
        final isActive = index == currentIndex;
        final color = isActive
            ? (activeColor ?? AppColors.primaryFigma)
            : (inactiveColor ?? AppColors.labelDisabled);
        final width = isActive ? (activeDotWidth ?? dotSize) : dotSize;

        return GestureDetector(
          onTap: onDotTap != null ? () => onDotTap!(index) : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: width,
              height: dotSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(dotSize / 2),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// 미니 페이지네이션 (현재 페이지 / 전체 페이지)
class AppMiniPagination extends StatelessWidget {
  const AppMiniPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.textStyle,
    this.activeColor,
    this.inactiveColor,
  });

  /// 현재 페이지 (1부터 시작)
  final int currentPage;

  /// 전체 페이지 수
  final int totalPages;

  /// 텍스트 스타일
  final TextStyle? textStyle;

  /// 현재 페이지 색상
  final Color? activeColor;

  /// 전체 페이지 색상
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ?? AppTextStyles.caption1Medium;
    final activeTextColor = activeColor ?? AppColors.labelNormal;
    final inactiveTextColor = inactiveColor ?? AppColors.labelAlternative;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          currentPage.toString(),
          style: baseStyle.copyWith(color: activeTextColor),
        ),
        Text(
          ' / ',
          style: baseStyle.copyWith(color: inactiveTextColor),
        ),
        Text(
          totalPages.toString(),
          style: baseStyle.copyWith(color: inactiveTextColor),
        ),
      ],
    );
  }
}
