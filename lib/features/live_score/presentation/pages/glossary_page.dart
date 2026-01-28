import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// 용어 설명 페이지
class GlossaryPage extends StatelessWidget {
  const GlossaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타이틀
              Text(
                l10n.glossary,
                style: AppTextStyles.heading2Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              // 1. 핸디캡
              _buildHandicapSection(l10n),
              const SizedBox(height: 32),
              // 2. 언더오버
              _buildUnderOverSection(l10n),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// 핸디캡 섹션
  Widget _buildHandicapSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          l10n.glossaryHandicapTitle,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        // 목적
        Text(
          l10n.glossaryHandicapPurpose,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        // 핵심 개념
        Text(
          l10n.glossaryKeyConcept,
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(l10n.glossaryHandicapBullet1),
        _buildBulletPoint(l10n.glossaryHandicapBullet2),
        _buildBulletPoint(l10n.glossaryHandicapBullet3),
        const SizedBox(height: 16),
        // 예시
        Text(
          l10n.glossaryExampleSoccer,
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(l10n.glossaryHandicapExample1),
        _buildBulletPoint(l10n.glossaryHandicapExample2),
        _buildBulletPoint(l10n.glossaryHandicapExample3),
      ],
    );
  }

  /// 언더오버 섹션
  Widget _buildUnderOverSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          l10n.glossaryUnderOverTitle,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        // 목적
        Text(
          l10n.glossaryUnderOverPurpose,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        // 핵심 개념
        Text(
          l10n.glossaryKeyConcept,
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(l10n.glossaryUnderOverBullet1),
        _buildBulletPoint(l10n.glossaryUnderOverBullet2),
        const SizedBox(height: 16),
        // 예시
        Text(
          l10n.glossaryExampleSoccer,
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(l10n.glossaryUnderOverExample1),
        _buildBulletPoint(l10n.glossaryUnderOverExample2),
      ],
    );
  }

  /// 불릿 포인트
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.white,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 용어 설명 바텀시트로 표시하는 함수
void showGlossaryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // 드래그 핸들
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 닫기 버튼
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
                  ),
                ),
                // 콘텐츠
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀
                        Text(
                          l10n.glossary,
                          style: AppTextStyles.heading2Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // 핸디캡 섹션
                        _buildHandicapContent(l10n),
                        const SizedBox(height: 32),
                        // 언더오버 섹션
                        _buildUnderOverContent(l10n),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildHandicapContent(AppLocalizations l10n) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        l10n.glossaryHandicapTitle,
        style: AppTextStyles.body1NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        l10n.glossaryHandicapPurpose,
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        l10n.glossaryKeyConcept,
        style: AppTextStyles.body2NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 8),
      _bulletPoint(l10n.glossaryHandicapBullet1),
      _bulletPoint(l10n.glossaryHandicapBullet2),
      _bulletPoint(l10n.glossaryHandicapBullet3),
    ],
  );
}

Widget _buildUnderOverContent(AppLocalizations l10n) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        l10n.glossaryUnderOverTitle,
        style: AppTextStyles.body1NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        l10n.glossaryUnderOverPurpose,
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        l10n.glossaryKeyConcept,
        style: AppTextStyles.body2NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 8),
      _bulletPoint(l10n.glossaryUnderOverBullet1),
      _bulletPoint(l10n.glossaryUnderOverBullet2),
    ],
  );
}

Widget _bulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}
