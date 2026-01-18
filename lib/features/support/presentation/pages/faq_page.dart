import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// FAQ 아이템
class FaqItem {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
  });
}

/// FAQ 페이지
class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int? _expandedIndex = 0; // 첫 번째 아이템 기본 펼침

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // FAQ 리스트
            Expanded(
              child: _buildFaqList(),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return AppHeader.withTitle(
      title: 'FAQ',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// FAQ 리스트
  Widget _buildFaqList() {
    final faqs = _getFaqs();

    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return _buildFaqItem(index, faqs[index]);
      },
    );
  }

  /// FAQ 아이템
  Widget _buildFaqItem(int index, FaqItem faq) {
    final isExpanded = _expandedIndex == index;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Column(
        children: [
          // 질문 헤더
          GestureDetector(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.labelNeutral,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          // 답변 (펼쳐진 경우)
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              color: AppColors.containerNormal,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  faq.answer,
                  style: AppTextStyles.body2NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                    height: 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// FAQ 데이터
  List<FaqItem> _getFaqs() {
    return const [
      FaqItem(
        question: '[기타] 보유한 포인트는 어떻게 쓸 수 있나요?',
        answer: 'AI 서비스의 포인트는 사용이 아닌, 이용을 얼마나 충실히 했는지, 그 점수를 가지고 소속별, 이용자 전체별 순위를 측정하고 있으며, 1위를 하는 사람들에게는 몰래 조용히 1만원을 제공합니다.',
      ),
      FaqItem(
        question: '[기타] 숙제를 꼭 해야하나요?',
        answer: '숙제는 선택 사항입니다. 하지만 숙제를 완료하면 추가 포인트를 획득할 수 있습니다.',
      ),
      FaqItem(
        question: '[로그인] 비밀번호를 잃어버렸으면 어떻게 해야하나요?',
        answer: '로그인 화면에서 "비밀번호 찾기"를 선택하여 등록된 이메일로 비밀번호 재설정 링크를 받을 수 있습니다.',
      ),
      FaqItem(
        question: '[편의기능] 찜하기는 어떻게 이용하면 되나요?',
        answer: '관심 있는 경기나 콘텐츠에서 하트 아이콘을 누르면 찜 목록에 추가됩니다. MY 페이지에서 찜한 항목들을 확인할 수 있습니다.',
      ),
      FaqItem(
        question: '자주하는 질문입니다.',
        answer: '이 질문에 대한 답변 내용이 여기에 표시됩니다.',
      ),
      FaqItem(
        question: '여기는 자주하는 질문 리스트가 나와요',
        answer: '자주 묻는 질문들을 모아놓은 페이지입니다. 원하는 질문을 찾아 답변을 확인하세요.',
      ),
      FaqItem(
        question: 'Admin에서 등록한 내용이 나옵니다.',
        answer: '관리자가 등록한 FAQ 내용이 이곳에 표시됩니다.',
      ),
    ];
  }
}
