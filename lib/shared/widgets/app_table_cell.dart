import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_icons.dart';

/// 테이블 셀 상태 정의
enum TableCellStatus {
  /// 기본 상태
  defaultStatus,

  /// 헤더 (항목)
  header,

  /// 부정적 값 (빨간색 텍스트)
  negative,

  /// 부정적 값 + 배경 (빨간색 텍스트 + 빨간 배경)
  negativeFilled,

  /// 긍정적 값 (파란색 텍스트)
  positive,

  /// 긍정적 값 + 배경 (파란색 텍스트 + 파란 배경)
  positiveFilled,

  /// 선택된 상태
  selected,

  /// 알림 표시 (빨간 점)
  alarm,

  /// 토글 포함
  toggle,
}

/// 테이블 셀 높이 정의
enum TableCellHeight {
  small, // 32px
  medium, // 40px
  large, // 48px
}

/// 테이블 셀 텍스트 크기 정의
enum TableCellTextSize {
  small, // 14px (Label1)
  large, // 16px (Body1)
}

/// 테이블 셀 컴포넌트
///
/// Figma 디자인 시스템의 Table 컴포넌트를 구현합니다.
class AppTableCell extends StatelessWidget {
  const AppTableCell({
    super.key,
    required this.label,
    this.status = TableCellStatus.defaultStatus,
    this.height = TableCellHeight.large,
    this.textSize = TableCellTextSize.large,
    this.showCaret = false,
    this.showIcon = false,
    this.isMobile = false,
    this.width,
    this.minWidth,
    this.onTap,
    this.toggleValue = false,
    this.onToggleChanged,
  });

  /// 셀 텍스트
  final String label;

  /// 셀 상태
  final TableCellStatus status;

  /// 셀 높이
  final TableCellHeight height;

  /// 텍스트 크기
  final TableCellTextSize textSize;

  /// Caret 아이콘 표시 여부 (헤더에서 정렬용)
  final bool showCaret;

  /// 아이콘 표시 여부
  final bool showIcon;

  /// 모바일 모드 여부
  final bool isMobile;

  /// 셀 너비 (지정하지 않으면 내용에 맞춤)
  final double? width;

  /// 최소 너비 (모바일: 60px)
  final double? minWidth;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 토글 상태 (toggle status에서 사용)
  final bool toggleValue;

  /// 토글 변경 콜백
  final ValueChanged<bool>? onToggleChanged;

  double _getHeight() {
    switch (height) {
      case TableCellHeight.small:
        return 32;
      case TableCellHeight.medium:
        return 40;
      case TableCellHeight.large:
        return 48;
    }
  }

  Color _getBackgroundColor() {
    switch (status) {
      case TableCellStatus.header:
        return AppColors.containerNormal;
      case TableCellStatus.selected:
        return AppColors.containerSelected;
      case TableCellStatus.negativeFilled:
        return AppColors.negativeContainer;
      case TableCellStatus.positiveFilled:
        return AppColors.positiveContainer;
      default:
        return AppColors.layerElevated;
    }
  }

  Color _getTextColor() {
    switch (status) {
      case TableCellStatus.header:
        return AppColors.labelNormal;
      case TableCellStatus.negative:
      case TableCellStatus.negativeFilled:
        return AppColors.negative;
      case TableCellStatus.positive:
      case TableCellStatus.positiveFilled:
        return AppColors.positive;
      default:
        return AppColors.labelNeutral;
    }
  }

  TextStyle _getTextStyle() {
    final color = _getTextColor();

    // 헤더는 더 큰 폰트 사용
    if (status == TableCellStatus.header) {
      if (textSize == TableCellTextSize.large) {
        return AppTextStyles.h4Medium.copyWith(color: color);
      } else {
        return AppTextStyles.body2NormalMedium.copyWith(color: color);
      }
    }

    // 일반 셀
    if (textSize == TableCellTextSize.large) {
      return AppTextStyles.body1NormalMedium.copyWith(color: color);
    } else {
      return AppTextStyles.label1NormalMedium.copyWith(color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMinWidth = minWidth ?? (isMobile ? 60.0 : null);

    Widget content = Container(
      width: width,
      constraints: effectiveMinWidth != null
          ? BoxConstraints(minWidth: effectiveMinWidth)
          : null,
      height: _getHeight(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: _buildContent(),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }

  Widget _buildContent() {
    // 토글 상태일 경우
    if (status == TableCellStatus.toggle) {
      return Center(
        child: _buildToggle(),
      );
    }

    // 헤더 상태일 경우 (caret 포함 가능)
    if (status == TableCellStatus.header && showCaret) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: _getTextStyle()),
          const SizedBox(width: 2),
          SvgPicture.asset(
            AppIcons.caretDown,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              _getTextColor(),
              BlendMode.srcIn,
            ),
          ),
        ],
      );
    }

    // 아이콘 포함된 기본 셀
    if (showIcon && textSize == TableCellTextSize.small) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.caretDown,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              _getTextColor(),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 2),
          Text(label, style: _getTextStyle()),
        ],
      );
    }

    // 알람 상태일 경우 (빨간 점 표시)
    if (status == TableCellStatus.alarm) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Text(label, style: _getTextStyle()),
          ),
          Positioned(
            top: 11.5,
            left: 42.5,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.negative,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    }

    // 기본 셀
    return Center(
      child: Text(
        label,
        style: _getTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildToggle() {
    return GestureDetector(
      onTap: () => onToggleChanged?.call(!toggleValue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 64,
        height: 32,
        decoration: BoxDecoration(
          color: toggleValue ? AppColors.primary : AppColors.labelDisabled,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment:
              toggleValue ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

/// 테이블 행 컴포넌트
///
/// 여러 개의 테이블 셀을 가로로 배치합니다.
class AppTableRow extends StatelessWidget {
  const AppTableRow({
    super.key,
    required this.cells,
    this.height = TableCellHeight.large,
  });

  /// 셀 목록
  final List<AppTableCell> cells;

  /// 행 높이 (모든 셀에 적용)
  final TableCellHeight height;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: cells,
      ),
    );
  }
}

/// 간단한 데이터 테이블 위젯
class AppDataTable extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.headers,
    required this.rows,
    this.headerHeight = TableCellHeight.large,
    this.rowHeight = TableCellHeight.large,
    this.columnWidths,
    this.isMobile = false,
  });

  /// 헤더 텍스트 목록
  final List<String> headers;

  /// 데이터 행 목록 (각 행은 문자열 리스트)
  final List<List<String>> rows;

  /// 헤더 높이
  final TableCellHeight headerHeight;

  /// 데이터 행 높이
  final TableCellHeight rowHeight;

  /// 컬럼별 너비 (지정하지 않으면 균등 분배)
  final List<double>? columnWidths;

  /// 모바일 모드
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 헤더 행
        Row(
          children: List.generate(headers.length, (index) {
            return Expanded(
              child: AppTableCell(
                label: headers[index],
                status: TableCellStatus.header,
                height: headerHeight,
                showCaret: true,
                isMobile: isMobile,
                width: columnWidths?[index],
              ),
            );
          }),
        ),
        // 데이터 행
        ...rows.map((row) {
          return Row(
            children: List.generate(row.length, (index) {
              return Expanded(
                child: AppTableCell(
                  label: row[index],
                  height: rowHeight,
                  isMobile: isMobile,
                  width: columnWidths?[index],
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
