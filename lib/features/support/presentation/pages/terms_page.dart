import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 약관 페이지
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context),
            // 메뉴 리스트
            _buildMenuItem(
              context,
              title: l10n.privacyPolicy,
              onTap: () => Navigator.pushNamed(context, '/privacy-policy'),
            ),
            _buildMenuItem(
              context,
              title: l10n.serviceTerms,
              onTap: () => Navigator.pushNamed(context, '/service-terms'),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppHeader.withTitle(
      title: l10n.terms,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 메뉴 아이템
  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.borderNormal),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
            SvgPicture.asset(
              AppIcons.chevronRight,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.labelNeutral,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
