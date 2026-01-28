import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 마케팅 수신 동의 페이지
class MarketingConsentPage extends StatefulWidget {
  const MarketingConsentPage({super.key});

  @override
  State<MarketingConsentPage> createState() => _MarketingConsentPageState();
}

class _MarketingConsentPageState extends State<MarketingConsentPage> {
  bool _marketingConsent = false;
  String? _consentDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 컨텐츠
            Expanded(
              child: Column(
                children: [
                  // 토글 아이템
                  _buildConsentToggle(),
                  const Spacer(),
                  // 하단 정보
                  if (_consentDate != null) _buildBottomInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return AppHeader.withTitle(
      title: l10n.marketingConsent,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 동의 토글
  Widget _buildConsentToggle() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.marketingConsent,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.eventBenefitInfo,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ),
          ),
          // 토글
          _buildCustomSwitch(_marketingConsent, (value) {
            setState(() {
              _marketingConsent = value;
              if (value) {
                _consentDate = _getCurrentDate();
              } else {
                _consentDate = null;
              }
            });
          }),
        ],
      ),
    );
  }

  /// 현재 날짜
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// 커스텀 스위치
  Widget _buildCustomSwitch(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: value ? AppColors.primaryFigma : AppColors.containerNeutral,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// 하단 정보
  Widget _buildBottomInfo() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A3B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$_consentDate에 광고 수신에 동의하였습니다.',
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.consentWithdrawal,
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
