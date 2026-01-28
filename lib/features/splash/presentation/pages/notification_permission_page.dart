import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';

/// 알림 설정 안내 화면 (푸시 권한 요청)
class NotificationPermissionPage extends StatelessWidget {
  const NotificationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 배경 (스플래쉬와 유사)
          _buildBackground(context),
          // 딤 오버레이
          _buildDimOverlay(),
          // 모달
          _buildModal(context),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고
            _buildLogo(),
            const SizedBox(height: 20),
            // 서비스명
            _buildServiceName(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryFigma,
          width: 2,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'REAL',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'TIME',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'score',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryFigma,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.appTitle,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryFigma,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildDimOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.4),
    );
  }

  Widget _buildModal(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Container(
        width: 324,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목
            Text(
              l10n.notificationGuide,
              style: AppTextStyles.h4Bold.copyWith(
                color: AppColors.labelNormal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // 내용
            Text(
              l10n.notificationQuestion,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // 부가 설명
            Text(
              l10n.consentWithdrawal,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelAlternative,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // 버튼들
            Row(
              children: [
                // 아니요 버튼
                Expanded(
                  child: AppButton.normal(
                    text: l10n.no,
                    onPressed: () => _onDecline(context),
                  ),
                ),
                const SizedBox(width: 8),
                // 알림받기 버튼
                Expanded(
                  child: AppButton.primary(
                    text: l10n.receiveNotification,
                    onPressed: () => _onAccept(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDecline(BuildContext context) {
    // 알림 거부 처리 후 메인 화면으로 이동
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _onAccept(BuildContext context) {
    // 알림 허용 처리 후 메인 화면으로 이동
    // TODO: 실제 푸시 알림 권한 요청 로직 추가
    Navigator.of(context).pushReplacementNamed('/main');
  }
}
