import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Pretendard';

  // ============================================
  // DISPLAY
  // ============================================

  // D1 - 가장 큰 제목 (56 / -3 / 72)
  static const TextStyle d1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    letterSpacing: -3,
    height: 72 / 56,
    color: AppColors.textPrimary,
  );

  // ============================================
  // HEADING
  // ============================================

  // H1 - 페이지 제목 (36 / -3 / 50)
  static const TextStyle h1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -3,
    height: 50 / 36,
    color: AppColors.textPrimary,
  );

  static const TextStyle h1Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    letterSpacing: -3,
    height: 50 / 36,
    color: AppColors.textPrimary,
  );

  static const TextStyle h1Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: -3,
    height: 50 / 36,
    color: AppColors.textPrimary,
  );

  // H2 - 페이지 소제목 (24 / 1.5 / 34)
  static const TextStyle h2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    height: 34 / 24,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 34 / 24,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    height: 34 / 24,
    color: AppColors.textPrimary,
  );

  // H3 - 큰 리스트 제목, 탭 (20 / -1 / 28)
  static const TextStyle h3Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 28 / 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 28 / 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 28 / 20,
    color: AppColors.textPrimary,
  );

  // H4 - 컨텐츠 제목 (18 / -1 / 26)
  static const TextStyle h4Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 26 / 18,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 26 / 18,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 26 / 18,
    color: AppColors.textPrimary,
  );

  // ============================================
  // BODY
  // ============================================

  // Body1_Normal - 일반적인 본문 (16 / -1 / 24)
  static const TextStyle body1NormalBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1NormalMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1NormalRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  // Body1_Reading - 보다 길게 읽어야 할 때 (16 / -1 / 26)
  static const TextStyle body1ReadingBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 26 / 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1ReadingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 26 / 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1ReadingRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 26 / 16,
    color: AppColors.textPrimary,
  );

  // Body2_Normal - 개별 리스트 소제목 (15 / -1 / 22)
  static const TextStyle body2NormalBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 22 / 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2NormalMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 22 / 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2NormalRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 22 / 15,
    color: AppColors.textPrimary,
  );

  // Body2_Reading - 개별 리스트 소제목 (15 / -1 / 24)
  static const TextStyle body2ReadingBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 24 / 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2ReadingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 24 / 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2ReadingRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 24 / 15,
    color: AppColors.textPrimary,
  );

  // ============================================
  // LABEL
  // ============================================

  // Label1_Normal - 일반적인 라벨 (14 / -1 / 20)
  static const TextStyle label1NormalBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle label1NormalMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle label1NormalRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  // Label1_Reading - 라벨 (14 / -1 / 22)
  static const TextStyle label1ReadingBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 22 / 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle label1ReadingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
    height: 22 / 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle label1ReadingRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
    height: 22 / 14,
    color: AppColors.textPrimary,
  );

  // Label2 - 보다 낮은 라벨 (13 / -0.5 / 20)
  static const TextStyle label2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 20 / 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle label2Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 20 / 13,
    color: AppColors.textPrimary,
  );

  static const TextStyle label2Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    height: 20 / 13,
    color: AppColors.textPrimary,
  );

  // ============================================
  // CAPTION
  // ============================================

  // Caption1 - 일반적인 캡션 (12 / -0.5 / 16)
  static const TextStyle caption1Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption1SemiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption1Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption1Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  // Caption2 - 가장 낮은 위계 캡션 (11 / -0.5 / 14)
  static const TextStyle caption2Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 14 / 11,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption2Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 14 / 11,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption2Regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    height: 14 / 11,
    color: AppColors.textSecondary,
  );

  // ============================================
  // BUTTON
  // ============================================

  // Button Large (16 / -0.5 / 24)
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  // Button Medium (14 / -0.5 / 20)
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  // Button Small (12 / -0.5 / 16)
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 16 / 12,
    color: AppColors.textPrimary,
  );

  // ============================================
  // SCORE (스코어 표시용 특수 스타일)
  // ============================================

  // Score Large - 메인 스코어 (32 / -1 / 40)
  static const TextStyle scoreLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 40 / 32,
    color: AppColors.textPrimary,
  );

  // Score Medium - 서브 스코어 (24 / -1 / 32)
  static const TextStyle scoreMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 32 / 24,
    color: AppColors.textPrimary,
  );

  // Score Small - 작은 스코어 (18 / -0.5 / 24)
  static const TextStyle scoreSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 24 / 18,
    color: AppColors.textPrimary,
  );

  // ============================================
  // ALIASES (편의를 위한 별칭)
  // ============================================

  // Theme에서 사용하는 별칭
  static const TextStyle bodyMedium = body2NormalMedium;
  static const TextStyle labelLarge = label1NormalBold;

  // 자주 사용되는 스타일 별칭
  static const TextStyle title = h4Bold;
  static const TextStyle subtitle = body1NormalMedium;
  static const TextStyle body = body1NormalRegular;
  static const TextStyle caption = caption1Regular;
  static const TextStyle hint = caption1Regular;

  // 간소화된 Label 별칭
  static const TextStyle label1Medium = label1NormalMedium;
  static const TextStyle label1Bold = label1NormalBold;

  // 간소화된 Heading 별칭
  static const TextStyle heading1Bold = h1Bold;
  static const TextStyle heading2Bold = h2Bold;

  // ============================================
  // HELPER METHODS
  // ============================================

  /// 색상을 변경한 새 TextStyle 반환
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// 스코어 색상 스타일 (승/패/무)
  static TextStyle scoreWithStatus(TextStyle style, {required bool? isWin}) {
    if (isWin == null) {
      return style.copyWith(color: AppColors.draw);
    }
    return style.copyWith(color: isWin ? AppColors.win : AppColors.lose);
  }

  /// 라이브 강조 스타일
  static TextStyle asLive(TextStyle style) {
    return style.copyWith(color: AppColors.live);
  }

  /// Secondary 색상 스타일
  static TextStyle asSecondary(TextStyle style) {
    return style.copyWith(color: AppColors.textSecondary);
  }

  /// Hint 색상 스타일
  static TextStyle asHint(TextStyle style) {
    return style.copyWith(color: AppColors.textHint);
  }
}
