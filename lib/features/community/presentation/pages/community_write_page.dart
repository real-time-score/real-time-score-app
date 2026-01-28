import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 게시글 등록 페이지
class CommunityWritePage extends StatefulWidget {
  const CommunityWritePage({super.key});

  @override
  State<CommunityWritePage> createState() => _CommunityWritePageState();
}

class _CommunityWritePageState extends State<CommunityWritePage> {
  String _selectedCategory = '';
  final TextEditingController _contentController = TextEditingController();
  final List<int> _uploadedImages = [1, 2, 3]; // 임시 이미지 리스트

  List<String> _getCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.freeBoard,
      l10n.soccer,
      l10n.baseball,
      l10n.basketball,
      l10n.volleyball,
      l10n.etc,
    ];
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return AppHeader.withTitle(
                  title: l10n.registerPost,
                  onBackPressed: () => Navigator.of(context).pop(),
                );
              },
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 카테고리 선택
                    _buildCategorySelect(),
                    const SizedBox(height: 16),
                    // 미디어 업로드
                    _buildMediaUpload(),
                    const SizedBox(height: 16),
                    // 내용
                    _buildContentInput(),
                  ],
                ),
              ),
            ),
            // 등록 버튼
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  /// 카테고리 선택
  Widget _buildCategorySelect() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨
        Text(
          l10n.selectCategory,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        // 드롭다운
        GestureDetector(
          onTap: () => _showCategoryBottomSheet(),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCategory.isEmpty ? l10n.categoryNameHint : _selectedCategory,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: _selectedCategory.isEmpty
                        ? AppColors.labelAlternative
                        : AppColors.labelNormal,
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.caretDown,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.labelAlternative,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 카테고리 바텀시트
  void _showCategoryBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
    final categories = _getCategories(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 핸들바
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.labelAlternative,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.selectCategory,
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(categories.length, (index) {
                return _buildCategoryOption(categories[index]);
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// 카테고리 옵션
  Widget _buildCategoryOption(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          category,
          style: AppTextStyles.body1NormalMedium.copyWith(
            color: _selectedCategory == category
                ? AppColors.primaryFigma
                : AppColors.labelNormal,
          ),
        ),
      ),
    );
  }

  /// 미디어 업로드
  Widget _buildMediaUpload() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨
        Text(
          l10n.mediaUpload,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        // 업로드 영역
        GestureDetector(
          onTap: () {
            // 이미지 업로드
          },
          child: Container(
            height: 141,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderNormal,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomPaint(
              painter: DashedBorderPainter(
                color: AppColors.borderNormal,
                strokeWidth: 1,
                gap: 5,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.image,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.labelNeutral,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.imageUpload,
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.maxImagesInfo,
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 이미지 썸네일 리스트
        if (_uploadedImages.isNotEmpty) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_uploadedImages.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < _uploadedImages.length - 1 ? 11 : 0),
                  child: _buildImageThumbnail(index),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
        ],
        // 도움말
        Text(
          l10n.thumbnailInfo,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ],
    );
  }

  /// 이미지 썸네일
  Widget _buildImageThumbnail(int index) {
    final isFirst = index == 0;
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
        border: isFirst
            ? Border.all(color: AppColors.primaryFigma, width: 2)
            : null,
      ),
      child: Stack(
        children: [
          // 이미지 아이콘
          Center(
            child: SvgPicture.asset(
              AppIcons.image,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.labelAlternative,
                BlendMode.srcIn,
              ),
            ),
          ),
          // 삭제 버튼
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _uploadedImages.removeAt(index);
                });
              },
              child: SvgPicture.asset(
                AppIcons.circleCloseFill,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.labelAlternative,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // 썸네일 배지
          if (isFirst)
            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Center(
                child: Builder(
                  builder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryFigma,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        l10n.thumbnail,
                        style: AppTextStyles.caption1Medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 내용 입력
  Widget _buildContentInput() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨
        Text(
          l10n.content,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        const SizedBox(height: 8),
        // 텍스트 입력
        Container(
          height: 137,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderNormal),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _contentController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: '콘텐츠 내용을 입력해주세요',
              hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelAlternative,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(15),
            ),
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ),
      ],
    );
  }

  /// 등록 버튼
  Widget _buildSubmitButton() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white.withValues(alpha: 0),
            AppColors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            // 등록 처리
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryFigma,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                l10n.register,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 점선 테두리 페인터
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.gap = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ));

    // 점선 효과
    final dashWidth = 5.0;
    final dashSpace = gap;
    double distance = 0;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final length = dashWidth;
        if (distance + length > metric.length) break;

        final extractPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
