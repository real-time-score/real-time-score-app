import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 서비스 이용약관 페이지
class ServiceTermsPage extends StatefulWidget {
  const ServiceTermsPage({super.key});

  @override
  State<ServiceTermsPage> createState() => _ServiceTermsPageState();
}

class _ServiceTermsPageState extends State<ServiceTermsPage> {
  String _selectedVersion = 'ver1.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildContent(),
              ),
            ),
            // 버전 선택
            _buildVersionSelector(),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return AppHeader.withTitle(
      title: '서비스 이용약관',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 콘텐츠
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          '서비스 이용약관($_selectedVersion)',
          style: AppTextStyles.heading2Bold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 16),
        // 링크
        GestureDetector(
          onTap: () {
            // 외부 링크 열기
          },
          child: Text(
            '스포츠 스코어 픽 서비스 이용약관',
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.primaryFigma,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryFigma,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // 제 1 조
        _buildArticle(
          title: '제 1 조 (목적)',
          content: '이 약관은 @@@@(이하 "사이트"라 합니다)에서 제공하는 인터넷서비스(이하 "서비스"라 합니다)의 이용 조건 및 절차에 관한 기본적인 사항을 규정함을 목적으로 합니다.',
        ),
        const SizedBox(height: 24),
        // 제 2 조
        _buildArticleWithItems(
          title: '제 2 조 (약관의 효력 및 변경)',
          items: [
            '이 약관은 서비스 화면이나 기타의 방법으로 이용고객에게 공지함으로써 효력을 발생합니다.',
            '사이트는 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.',
          ],
        ),
        const SizedBox(height: 24),
        // 제 3 조
        _buildArticleWithItems(
          title: '제 3 조 (용어의 정의)',
          intro: '이 약관에서 사용하는 용어의 정의는 다음과 같습니다.',
          items: [
            '회원 : 사이트와 서비스 이용계약을 체결하거나 이용자 아이디(ID)를 부여받은 개인 또는 단체를 말합니다.',
            '신청자 : 회원가입을 신청하는 개인 또는 단체를 말합니다.',
            '아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 정하고 사이트가 승인하는 문자와 숫자의 조합을 말합니다.',
            '비밀번호 : 회원이 부여 받은 아이디(ID)와 일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.',
          ],
        ),
        const SizedBox(height: 24),
        // 제 4 조
        _buildArticleWithItems(
          title: '제 4 조 (이용 계약의 성립)',
          items: [
            '이용계약은 이용자의 이용신청에 대하여 사이트가 승낙함으로써 성립합니다.',
            '이용계약의 성립 시기는 사이트가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.',
          ],
        ),
        const SizedBox(height: 24),
        // 제 5 조
        _buildArticleWithItems(
          title: '제 5 조 (회원 탈퇴 및 자격 상실)',
          items: [
            '회원은 사이트에 언제든지 탈퇴를 요청할 수 있으며, 사이트는 즉시 회원탈퇴를 처리합니다.',
            '회원이 다음 각 호의 사유에 해당하는 경우, 사이트는 회원자격을 제한 및 정지시킬 수 있습니다.',
            '가입 신청 시에 허위 내용을 등록한 경우',
            '다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우',
          ],
        ),
        const SizedBox(height: 24),
        // 제 6 조
        _buildArticle(
          title: '제 6 조 (서비스의 중단)',
          content: '사이트는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다. 이 경우 사이트는 회원에게 통지합니다.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  /// 기본 조항
  Widget _buildArticle({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.labelNeutral,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  /// 항목이 있는 조항
  Widget _buildArticleWithItems({
    required String title,
    String? intro,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
        const SizedBox(height: 8),
        if (intro != null) ...[
          Text(
            intro,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.labelNeutral,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ...items.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.labelNeutral,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyles.body2NormalMedium.copyWith(
                      color: AppColors.labelNeutral,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// 버전 선택기
  Widget _buildVersionSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: GestureDetector(
        onTap: _showVersionBottomSheet,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderNormal),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '다른 버전 보기',
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.labelNeutral,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 버전 선택 바텀시트
  void _showVersionBottomSheet() {
    final versions = ['ver1.0', 'ver0.9', 'ver0.8'];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderNormal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '버전 선택',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              ...versions.map((version) {
                final isSelected = version == _selectedVersion;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedVersion = version;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    color: isSelected
                        ? AppColors.containerNormal
                        : AppColors.white,
                    child: Text(
                      version,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: isSelected
                            ? AppColors.primaryFigma
                            : AppColors.labelNormal,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
