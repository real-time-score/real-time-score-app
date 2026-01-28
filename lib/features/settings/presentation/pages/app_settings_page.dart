import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 앱설정 페이지
class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: l10n.appSettings,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 메뉴 리스트
            _buildMenuList(context),
          ],
        ),
      ),
    );
  }

  /// 메뉴 리스트
  Widget _buildMenuList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildMenuItem(
          context,
          l10n.notificationSettings,
          () => Navigator.pushNamed(context, '/notification-settings'),
        ),
        _buildMenuItem(
          context,
          l10n.marketingConsent,
          () => Navigator.pushNamed(context, '/marketing-consent'),
        ),
      ],
    );
  }

  /// 메뉴 아이템
  Widget _buildMenuItem(BuildContext context, String title, VoidCallback onTap) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
            SvgPicture.asset(
              AppIcons.chevronRight,
              width: 20,
              height: 20,
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
