import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 휴대폰 인증 페이지
class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  // ignore: unused_field - 인증 완료 상태 (추후 구현 예정)
  bool _codeSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

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
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 안내 문구
                    _buildInfoText(l10n),
                    const SizedBox(height: 24),
                    // 휴대폰 번호 섹션
                    _buildPhoneSection(l10n),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(AppLocalizations l10n) {
    return AppHeader.withTitle(
      title: l10n.memberReVerification,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 안내 문구
  Widget _buildInfoText(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        l10n.reVerificationInfo,
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.labelNeutral,
          height: 1.4,
        ),
      ),
    );
  }

  /// 휴대폰 번호 섹션
  Widget _buildPhoneSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 타이틀
        Text(
          l10n.phoneNumber,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 16),
        // 전화번호 입력
        _buildPhoneInput(l10n),
        const SizedBox(height: 12),
        // 인증번호 입력
        _buildCodeInput(l10n),
      ],
    );
  }

  /// 전화번호 입력
  Widget _buildPhoneInput(AppLocalizations l10n) {
    return Row(
      children: [
        // 입력 필드
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: l10n.enterPhoneNumber,
                hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 전송 버튼
        GestureDetector(
          onTap: () {
            setState(() {
              _codeSent = true;
            });
            // 인증번호 전송 처리
          },
          child: Container(
            width: 72,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2A3B),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                l10n.send,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 인증번호 입력
  Widget _buildCodeInput(AppLocalizations l10n) {
    return Row(
      children: [
        // 입력 필드
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: l10n.enterVerificationCode,
                hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 인증 버튼
        GestureDetector(
          onTap: () {
            // 인증 처리
          },
          child: Container(
            width: 72,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2A3B),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                l10n.verify,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
