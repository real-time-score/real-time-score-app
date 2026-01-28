import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 개인정보처리방침 페이지
class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String _selectedVersion = 'ver1.0';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(l10n),
            // 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildContent(l10n),
              ),
            ),
            // 버전 선택
            _buildVersionSelector(l10n),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(AppLocalizations l10n) {
    return AppHeader.withTitle(
      title: l10n.privacyPolicy,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 콘텐츠
  Widget _buildContent(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          '${l10n.privacyPolicy}($_selectedVersion)',
          style: AppTextStyles.heading2Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 16),
        // 링크
        GestureDetector(
          onTap: () {
            // 외부 링크 열기
          },
          child: Text(
            l10n.privacyPolicyLink,
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.primaryFigma,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryFigma,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // 제 1 조
        _buildArticle(
          title: l10n.article1Purpose,
          content: l10n.termsArticle1Content,
        ),
        const SizedBox(height: 24),
        // 제 2 조
        _buildArticleWithItems(
          title: l10n.article2Effectiveness,
          items: [
            l10n.termsArticle2Item1,
            l10n.termsArticle2Item2,
          ],
        ),
        const SizedBox(height: 24),
        // 제 3 조
        _buildArticleWithItems(
          title: l10n.article3Definitions,
          intro: l10n.termsArticle3Intro,
          items: [
            l10n.termsArticle3Item1,
            l10n.termsArticle3Item2,
            l10n.termsArticle3Item3,
            l10n.termsArticle3Item4,
          ],
        ),
        const SizedBox(height: 24),
        // 추가 조항들
        _buildArticleWithItems(
          title: l10n.article4Service,
          intro: l10n.termsArticle4Intro,
          items: [
            l10n.termsArticle4Item1,
            l10n.termsArticle4Item2,
            l10n.termsArticle4Item3,
            l10n.termsArticle4Item4,
          ],
        ),
        const SizedBox(height: 24),
        _buildArticle(
          title: l10n.article5ServiceHours,
          content: l10n.termsArticle5ServiceHoursContent,
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  /// 기본 조항
  Widget _buildArticle({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.labelNeutral,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  /// 항목이 있는 조항
  Widget _buildArticleWithItems({
    required String title,
    String? intro,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        if (intro != null) ...[
          Text(
            intro,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.labelNeutral,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ...items.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.labelNeutral,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyles.body2NormalMedium.copyWith(
                      color: AppColors.labelNeutral,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// 버전 선택기
  Widget _buildVersionSelector(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: GestureDetector(
        onTap: _showVersionBottomSheet,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderNormal),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.viewOtherVersions,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.labelNeutral,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 버전 선택 바텀시트
  void _showVersionBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
    final versions = ['ver1.0', 'ver0.9', 'ver0.8'];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderNormal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.selectVersion,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              ...versions.map((version) {
                final isSelected = version == _selectedVersion;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedVersion = version;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    color: isSelected
                        ? AppColors.containerNormal
                        : AppColors.white,
                    child: Text(
                      version,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: isSelected
                            ? AppColors.primaryFigma
                            : AppColors.labelNormal,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
