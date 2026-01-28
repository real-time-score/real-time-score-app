import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 1:1 문의 페이지
class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _emailController.dispose();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 안내 문구
                    _buildInfoSection(),
                    const SizedBox(height: 24),
                    // 폼
                    _buildForm(),
                  ],
                ),
              ),
            ),
            // 제출 버튼
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return AppHeader.withTitle(
      title: l10n.inquiry,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 안내 섹션
  Widget _buildInfoSection() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.containerNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.inquiryQuestion,
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.inquiryDescription,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
        ],
      ),
    );
  }

  /// 폼
  Widget _buildForm() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          _buildLabel(l10n.title),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _titleController,
            hintText: l10n.inquiryTitle,
          ),
          const SizedBox(height: 24),
          // 문의 내용
          _buildLabel(l10n.inquiryContent),
          const SizedBox(height: 8),
          _buildTextArea(
            controller: _contentController,
            hintText: l10n.inquiryContentHint,
          ),
          const SizedBox(height: 24),
          // 이메일 주소
          _buildLabelWithRequired(l10n.emailAddress),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailController,
            hintText: l10n.emailHint,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  /// 라벨
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.body2NormalMedium.copyWith(
        color: AppColors.labelNormal,
      ),
    );
  }

  /// 필수 표시 라벨
  Widget _buildLabelWithRequired(String text) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          l10n.required,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ],
    );
  }

  /// 텍스트 필드
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.body1NormalMedium.copyWith(
            color: AppColors.labelAlternative,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelNormal,
        ),
      ),
    );
  }

  /// 텍스트 영역
  Widget _buildTextArea({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.body1NormalMedium.copyWith(
            color: AppColors.labelAlternative,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelNormal,
        ),
      ),
    );
  }

  /// 제출 버튼
  Widget _buildSubmitButton() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          // 문의 제출 처리
        },
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A3B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              l10n.submitInquiry,
              style: AppTextStyles.body1NormalBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
