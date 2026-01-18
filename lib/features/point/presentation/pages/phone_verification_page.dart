import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 휴대폰 인증 페이지
class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _codeSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
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
            _buildHeader(),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 안내 문구
                    _buildInfoText(),
                    const SizedBox(height: 24),
                    // 휴대폰 번호 섹션
                    _buildPhoneSection(),
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
  Widget _buildHeader() {
    return AppHeader.withTitle(
      title: '회원 재인증',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 안내 문구
  Widget _buildInfoText() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '고객님의 정보보호와 안전한 서비스 이용을 위해 앱 재설치 및 데이터 삭제 시 재인증이 필요합니다.',
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.labelNeutral,
          height: 1.4,
        ),
      ),
    );
  }

  /// 휴대폰 번호 섹션
  Widget _buildPhoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 타이틀
        Text(
          '휴대폰 번호',
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 16),
        // 전화번호 입력
        _buildPhoneInput(),
        const SizedBox(height: 12),
        // 인증번호 입력
        _buildCodeInput(),
      ],
    );
  }

  /// 전화번호 입력
  Widget _buildPhoneInput() {
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
                hintText: '전화번호를 입력해주세요',
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
                '전송',
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
  Widget _buildCodeInput() {
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
                hintText: '인증 번호를 입력해주세요.',
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
                '인증',
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
