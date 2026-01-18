import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 앱설정 페이지
class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: '앱설정',
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
    return Column(
      children: [
        _buildMenuItem(
          context,
          '알림설정',
          () => Navigator.pushNamed(context, '/notification-settings'),
        ),
        _buildMenuItem(
          context,
          '마케팅 수신 동의',
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
