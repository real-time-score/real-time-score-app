import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

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
    return AppHeader.withTitle(
      title: '1:1문의',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 안내 섹션
  Widget _buildInfoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.containerNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '서비스 이용 관련해서 궁금한 점 있으신가요?',
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '문의사항을 남겨 주시면 이메일 주소로 답변을 보내드립니다.',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          _buildLabel('제목'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _titleController,
            hintText: '문의 제목을 입력해주세요',
          ),
          const SizedBox(height: 24),
          // 문의 내용
          _buildLabel('문의 내용'),
          const SizedBox(height: 8),
          _buildTextArea(
            controller: _contentController,
            hintText: '문의 제목을 입력해주세요',
          ),
          const SizedBox(height: 24),
          // 이메일 주소
          _buildLabelWithRequired('이메일 주소'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailController,
            hintText: '이메일을 입력해주세요',
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
          '(필수)',
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
              '문의하기',
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
