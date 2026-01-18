import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// 텍스트 타입
enum AppTextType {
  // Heading
  h1,
  h2,
  h3,
  h4,
  // Body
  body1,
  body2,
  // Label
  label1,
  label2,
  // Caption
  caption1,
  caption2,
}

/// 텍스트 웨이트
enum AppTextWeight {
  regular,
  medium,
  bold,
}

/// 기본 텍스트 컴포넌트
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.type = AppTextType.body1,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  });

  final String text;
  final AppTextType type;
  final AppTextWeight weight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? letterSpacing;
  final double? height;

  // ============================================
  // HEADING CONSTRUCTORS
  // ============================================

  /// H1 - 페이지 제목 (36px)
  const AppText.h1(
    this.text, {
    super.key,
    this.weight = AppTextWeight.bold,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.h1;

  /// H2 - 페이지 소제목 (24px)
  const AppText.h2(
    this.text, {
    super.key,
    this.weight = AppTextWeight.bold,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.h2;

  /// H3 - 큰 리스트 제목, 탭 (20px)
  const AppText.h3(
    this.text, {
    super.key,
    this.weight = AppTextWeight.bold,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.h3;

  /// H4 - 컨텐츠 제목 (18px)
  const AppText.h4(
    this.text, {
    super.key,
    this.weight = AppTextWeight.bold,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.h4;

  // ============================================
  // BODY CONSTRUCTORS
  // ============================================

  /// Body1 - 일반적인 본문 (16px)
  const AppText.body1(
    this.text, {
    super.key,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.body1;

  /// Body2 - 개별 리스트 소제목 (15px)
  const AppText.body2(
    this.text, {
    super.key,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.body2;

  // ============================================
  // LABEL CONSTRUCTORS
  // ============================================

  /// Label1 - 일반적인 라벨 (14px)
  const AppText.label1(
    this.text, {
    super.key,
    this.weight = AppTextWeight.medium,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.label1;

  /// Label2 - 보다 낮은 라벨 (13px)
  const AppText.label2(
    this.text, {
    super.key,
    this.weight = AppTextWeight.medium,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.label2;

  // ============================================
  // CAPTION CONSTRUCTORS
  // ============================================

  /// Caption1 - 일반적인 캡션 (12px)
  const AppText.caption1(
    this.text, {
    super.key,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.caption1;

  /// Caption2 - 가장 낮은 위계 캡션 (11px)
  const AppText.caption2(
    this.text, {
    super.key,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.height,
  }) : type = AppTextType.caption2;

  TextStyle _getBaseStyle() {
    switch (type) {
      case AppTextType.h1:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.h1Regular;
          case AppTextWeight.medium:
            return AppTextStyles.h1Medium;
          case AppTextWeight.bold:
            return AppTextStyles.h1Bold;
        }
      case AppTextType.h2:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.h2Regular;
          case AppTextWeight.medium:
            return AppTextStyles.h2Medium;
          case AppTextWeight.bold:
            return AppTextStyles.h2Bold;
        }
      case AppTextType.h3:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.h3Regular;
          case AppTextWeight.medium:
            return AppTextStyles.h3Medium;
          case AppTextWeight.bold:
            return AppTextStyles.h3Bold;
        }
      case AppTextType.h4:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.h4Regular;
          case AppTextWeight.medium:
            return AppTextStyles.h4Medium;
          case AppTextWeight.bold:
            return AppTextStyles.h4Bold;
        }
      case AppTextType.body1:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.body1NormalRegular;
          case AppTextWeight.medium:
            return AppTextStyles.body1NormalMedium;
          case AppTextWeight.bold:
            return AppTextStyles.body1NormalBold;
        }
      case AppTextType.body2:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.body2NormalRegular;
          case AppTextWeight.medium:
            return AppTextStyles.body2NormalMedium;
          case AppTextWeight.bold:
            return AppTextStyles.body2NormalBold;
        }
      case AppTextType.label1:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.label1NormalRegular;
          case AppTextWeight.medium:
            return AppTextStyles.label1NormalMedium;
          case AppTextWeight.bold:
            return AppTextStyles.label1NormalBold;
        }
      case AppTextType.label2:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.label2Regular;
          case AppTextWeight.medium:
            return AppTextStyles.label2Medium;
          case AppTextWeight.bold:
            return AppTextStyles.label2Bold;
        }
      case AppTextType.caption1:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.caption1Regular;
          case AppTextWeight.medium:
            return AppTextStyles.caption1Medium;
          case AppTextWeight.bold:
            return AppTextStyles.caption1Bold;
        }
      case AppTextType.caption2:
        switch (weight) {
          case AppTextWeight.regular:
            return AppTextStyles.caption2Regular;
          case AppTextWeight.medium:
            return AppTextStyles.caption2Medium;
          case AppTextWeight.bold:
            return AppTextStyles.caption2Bold;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getBaseStyle().copyWith(
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      letterSpacing: letterSpacing,
      height: height,
    );

    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

/// 확장 가능한 텍스트 (더보기/접기)
class AppExpandableText extends StatefulWidget {
  const AppExpandableText(
    this.text, {
    super.key,
    this.type = AppTextType.body1,
    this.weight = AppTextWeight.regular,
    this.color,
    this.maxLines = 3,
    this.expandText = '더보기',
    this.collapseText = '접기',
    this.linkColor,
  });

  final String text;
  final AppTextType type;
  final AppTextWeight weight;
  final Color? color;
  final int maxLines;
  final String expandText;
  final String collapseText;
  final Color? linkColor;

  @override
  State<AppExpandableText> createState() => _AppExpandableTextState();
}

class _AppExpandableTextState extends State<AppExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidget = AppText(
          widget.text,
          type: widget.type,
          weight: widget.weight,
          color: widget.color,
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: _getStyle(),
          ),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        final isOverflowing = textPainter.didExceedMaxLines;

        if (!isOverflowing) {
          return textWidget;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              widget.text,
              type: widget.type,
              weight: widget.weight,
              color: widget.color,
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? null : TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(
                _isExpanded ? widget.collapseText : widget.expandText,
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: widget.linkColor ?? AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  TextStyle _getStyle() {
    // 간단히 body1 기준으로 반환
    return AppTextStyles.body1NormalRegular.copyWith(color: widget.color);
  }
}

/// 하이라이트 텍스트 (검색어 강조 등)
class AppHighlightText extends StatelessWidget {
  const AppHighlightText(
    this.text, {
    super.key,
    required this.highlight,
    this.type = AppTextType.body1,
    this.weight = AppTextWeight.regular,
    this.color,
    this.highlightColor,
    this.highlightBackgroundColor,
    this.caseSensitive = false,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final String highlight;
  final AppTextType type;
  final AppTextWeight weight;
  final Color? color;
  final Color? highlightColor;
  final Color? highlightBackgroundColor;
  final bool caseSensitive;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) {
      return AppText(
        text,
        type: type,
        weight: weight,
        color: color,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final baseStyle = _getBaseStyle().copyWith(color: color ?? AppColors.textPrimary);
    final highlightStyle = baseStyle.copyWith(
      color: highlightColor ?? AppColors.primary,
      backgroundColor: highlightBackgroundColor,
      fontWeight: FontWeight.w600,
    );

    final pattern = caseSensitive ? highlight : highlight.toLowerCase();
    final sourceText = caseSensitive ? text : text.toLowerCase();

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = sourceText.indexOf(pattern, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: baseStyle,
        ));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: baseStyle,
        ));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + highlight.length),
        style: highlightStyle,
      ));

      start = index + highlight.length;
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }

  TextStyle _getBaseStyle() {
    // AppText와 동일한 로직을 사용
    switch (type) {
      case AppTextType.h1:
      case AppTextType.h2:
      case AppTextType.h3:
      case AppTextType.h4:
        return AppTextStyles.h4Bold;
      case AppTextType.body1:
        return weight == AppTextWeight.bold
            ? AppTextStyles.body1NormalBold
            : weight == AppTextWeight.medium
                ? AppTextStyles.body1NormalMedium
                : AppTextStyles.body1NormalRegular;
      case AppTextType.body2:
        return weight == AppTextWeight.bold
            ? AppTextStyles.body2NormalBold
            : weight == AppTextWeight.medium
                ? AppTextStyles.body2NormalMedium
                : AppTextStyles.body2NormalRegular;
      case AppTextType.label1:
        return AppTextStyles.label1NormalMedium;
      case AppTextType.label2:
        return AppTextStyles.label2Medium;
      case AppTextType.caption1:
        return AppTextStyles.caption1Regular;
      case AppTextType.caption2:
        return AppTextStyles.caption2Regular;
    }
  }
}

/// 링크 텍스트
class AppLinkText extends StatelessWidget {
  const AppLinkText(
    this.text, {
    super.key,
    required this.onTap,
    this.type = AppTextType.body1,
    this.weight = AppTextWeight.medium,
    this.color,
    this.underline = false,
  });

  final String text;
  final VoidCallback onTap;
  final AppTextType type;
  final AppTextWeight weight;
  final Color? color;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppText(
        text,
        type: type,
        weight: weight,
        color: color ?? AppColors.primary,
        decoration: underline ? TextDecoration.underline : null,
        decorationColor: color ?? AppColors.primary,
      ),
    );
  }
}

/// 리치 텍스트 (여러 스타일 조합)
class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.children,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final List<AppTextSpan> children;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: children.map((span) => span.toTextSpan()).toList(),
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}

/// 텍스트 스팬 데이터
class AppTextSpan {
  const AppTextSpan(
    this.text, {
    this.type = AppTextType.body1,
    this.weight = AppTextWeight.regular,
    this.color,
    this.decoration,
    this.onTap,
  });

  final String text;
  final AppTextType type;
  final AppTextWeight weight;
  final Color? color;
  final TextDecoration? decoration;
  final VoidCallback? onTap;

  TextSpan toTextSpan() {
    final style = _getStyle();
    return TextSpan(
      text: text,
      style: style.copyWith(
        color: color ?? style.color,
        decoration: decoration,
      ),
      recognizer: onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
    );
  }

  TextStyle _getStyle() {
    switch (type) {
      case AppTextType.h1:
        return weight == AppTextWeight.bold
            ? AppTextStyles.h1Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.h1Medium
                : AppTextStyles.h1Regular;
      case AppTextType.h2:
        return weight == AppTextWeight.bold
            ? AppTextStyles.h2Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.h2Medium
                : AppTextStyles.h2Regular;
      case AppTextType.h3:
        return weight == AppTextWeight.bold
            ? AppTextStyles.h3Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.h3Medium
                : AppTextStyles.h3Regular;
      case AppTextType.h4:
        return weight == AppTextWeight.bold
            ? AppTextStyles.h4Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.h4Medium
                : AppTextStyles.h4Regular;
      case AppTextType.body1:
        return weight == AppTextWeight.bold
            ? AppTextStyles.body1NormalBold
            : weight == AppTextWeight.medium
                ? AppTextStyles.body1NormalMedium
                : AppTextStyles.body1NormalRegular;
      case AppTextType.body2:
        return weight == AppTextWeight.bold
            ? AppTextStyles.body2NormalBold
            : weight == AppTextWeight.medium
                ? AppTextStyles.body2NormalMedium
                : AppTextStyles.body2NormalRegular;
      case AppTextType.label1:
        return weight == AppTextWeight.bold
            ? AppTextStyles.label1NormalBold
            : weight == AppTextWeight.medium
                ? AppTextStyles.label1NormalMedium
                : AppTextStyles.label1NormalRegular;
      case AppTextType.label2:
        return weight == AppTextWeight.bold
            ? AppTextStyles.label2Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.label2Medium
                : AppTextStyles.label2Regular;
      case AppTextType.caption1:
        return weight == AppTextWeight.bold
            ? AppTextStyles.caption1Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.caption1Medium
                : AppTextStyles.caption1Regular;
      case AppTextType.caption2:
        return weight == AppTextWeight.bold
            ? AppTextStyles.caption2Bold
            : weight == AppTextWeight.medium
                ? AppTextStyles.caption2Medium
                : AppTextStyles.caption2Regular;
    }
  }
}

/// 스코어 텍스트 (스포츠 앱 전용)
class AppScoreText extends StatelessWidget {
  const AppScoreText(
    this.score, {
    super.key,
    this.size = AppScoreSize.medium,
    this.isWinner,
    this.isLive = false,
    this.color,
  });

  final String score;
  final AppScoreSize size;
  final bool? isWinner;
  final bool isLive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    if (color != null) {
      textColor = color!;
    } else if (isLive) {
      textColor = AppColors.live;
    } else if (isWinner == true) {
      textColor = AppColors.textPrimary;
    } else if (isWinner == false) {
      textColor = AppColors.textSecondary;
    } else {
      textColor = AppColors.textPrimary;
    }

    TextStyle style;
    switch (size) {
      case AppScoreSize.small:
        style = AppTextStyles.scoreSmall;
        break;
      case AppScoreSize.medium:
        style = AppTextStyles.scoreMedium;
        break;
      case AppScoreSize.large:
        style = AppTextStyles.scoreLarge;
        break;
    }

    return Text(
      score,
      style: style.copyWith(color: textColor),
    );
  }
}

enum AppScoreSize {
  small, // 18px
  medium, // 24px
  large, // 32px
}

/// 타이머/시간 텍스트
class AppTimeText extends StatelessWidget {
  const AppTimeText(
    this.time, {
    super.key,
    this.type = AppTextType.label1,
    this.isLive = false,
    this.color,
    this.prefix,
    this.suffix,
  });

  final String time;
  final AppTextType type;
  final bool isLive;
  final Color? color;
  final String? prefix;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? (isLive ? AppColors.live : AppColors.textSecondary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLive) ...[
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 4),
            decoration: const BoxDecoration(
              color: AppColors.live,
              shape: BoxShape.circle,
            ),
          ),
        ],
        if (prefix != null)
          AppText(
            prefix!,
            type: type,
            color: textColor,
          ),
        AppText(
          time,
          type: type,
          weight: isLive ? AppTextWeight.bold : AppTextWeight.medium,
          color: textColor,
        ),
        if (suffix != null)
          AppText(
            suffix!,
            type: type,
            color: textColor,
          ),
      ],
    );
  }
}

/// 레이블 + 값 텍스트 쌍
class AppLabelValue extends StatelessWidget {
  const AppLabelValue({
    super.key,
    required this.label,
    required this.value,
    this.labelType = AppTextType.caption1,
    this.valueType = AppTextType.body2,
    this.labelColor,
    this.valueColor,
    this.spacing = 4,
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String label;
  final String value;
  final AppTextType labelType;
  final AppTextType valueType;
  final Color? labelColor;
  final Color? valueColor;
  final double spacing;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final labelWidget = AppText(
      label,
      type: labelType,
      color: labelColor ?? AppColors.textSecondary,
    );

    final valueWidget = AppText(
      value,
      type: valueType,
      weight: AppTextWeight.medium,
      color: valueColor ?? AppColors.textPrimary,
    );

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          labelWidget,
          SizedBox(width: spacing),
          valueWidget,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        labelWidget,
        SizedBox(height: spacing),
        valueWidget,
      ],
    );
  }
}
