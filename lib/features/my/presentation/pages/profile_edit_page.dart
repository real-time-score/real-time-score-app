import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../l10n/app_localizations.dart';

/// 프로필 편집 페이지
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
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
                  children: [
                    const SizedBox(height: 24),
                    // 프로필 이미지
                    _buildProfileImage(l10n),
                    const SizedBox(height: 24),
                    // 닉네임 입력
                    _buildNicknameInput(l10n),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더 (텍스트 액션 버튼 포함)
  Widget _buildHeader(AppLocalizations l10n) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // X 버튼 (닫기)
          Positioned(
            left: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.close,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.labelNormal,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 타이틀
          Text(
            l10n.myProfileEdit,
            style: AppTextStyles.h4Medium,
          ),
          // 완료 버튼
          Positioned(
            right: 12,
            child: GestureDetector(
              onTap: () {
                // 저장 처리
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.complete,
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 프로필 이미지
  Widget _buildProfileImage(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        // 이미지 선택
      },
      child: Stack(
        children: [
          // 프로필 이미지
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerNormal,
            ),
            child: const Icon(
              Icons.person,
              size: 48,
              color: AppColors.labelAlternative,
            ),
          ),
          // 변경 뱃지
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.contentsNeutral,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.change,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 닉네임 입력
  Widget _buildNicknameInput(AppLocalizations l10n) {
    return Row(
      children: [
        // 텍스트 입력
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                hintText: l10n.nickname,
                hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
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
        // 중복확인 버튼
        GestureDetector(
          onTap: () {
            // 중복 확인 처리
          },
          child: Container(
            width: 96,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryFigma,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                l10n.checkDuplicate,
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
