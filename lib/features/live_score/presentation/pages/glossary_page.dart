import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 용어 설명 페이지
class GlossaryPage extends StatelessWidget {
  const GlossaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타이틀
              Text(
                '용어 설명',
                style: AppTextStyles.heading2Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              // 1. 핸디캡
              _buildHandicapSection(),
              const SizedBox(height: 32),
              // 2. 언더오버
              _buildUnderOverSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// 핸디캡 섹션
  Widget _buildHandicapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          '1. 핸디캡(Handicap, HCP)',
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        // 목적
        Text(
          '목적: 실력 차이가 있는 경기에서 배당을 만들기 위해 "가상의 점수 차"를 미리 주고 시작하는 베팅 방식이다.',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        // 핵심 개념
        Text(
          '핵심 개념',
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('강팀(우세팀): 핸디캡에서 불리하게 시작함 (예: -1.5, -2.5 같은 마이너스)'),
        _buildBulletPoint('약팀(열세팀): 핸디캡에서 유리하게 시작함 (예: +1.5, +2.5 같은 플러스)'),
        _buildBulletPoint('"최종 스코어에 핸디캡을 더해서" 승패를 판단한다.'),
        const SizedBox(height: 16),
        // 예시
        Text(
          '예시 (축구)',
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '경기: A vs B\n핸디캡: A -1.5 (A가 강팀)\n실제 결과:',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        _buildIndentedBullet('A 2 : 0 B'),
        _buildIndentedText('핸디캡 적용: A는 -1.5를 받으니까 2 - 1.5 = 0.5, B는 0'),
        _buildIndentedText('→ A(0.5) > B(0) 이라서 A 핸디캡 승'),
        const SizedBox(height: 12),
        Text(
          '반대로',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildIndentedBullet('A 1 : 0 B'),
        _buildIndentedText('핸디캡 적용: 1 - 1.5 = -0.5'),
        _buildIndentedText('→ A(-0.5) < B(0) 이라서 A 핸디캡 패 (즉 B 핸디캡 승)'),
      ],
    );
  }

  /// 언더오버 섹션
  Widget _buildUnderOverSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          '2. 언더오버(Under/Over, U/O)',
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        // 목적
        Text(
          '목적: 승패가 아니라 "총 득점(두 팀 합산)"이 기준선을 넘는지/안 넘는지를 맞추는 방식이다.',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        // 핵심 개념
        Text(
          '핵심 개념',
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('기준선(라인)이 주어짐: 예) 2.5, 3.5, 7.5 등'),
        _buildBulletPoint('두 팀 점수 합계가'),
        _buildBulletPoint('기준선보다 크면: 오버(Over)'),
        _buildBulletPoint('기준선보다 작으면: 언더(Under)'),
        _buildBulletPoint('0.5가 붙는 이유: 무조건 언더/오버가 갈리게 하려고(무승부/적중 환급 같은 애매함 제거)이다.'),
        const SizedBox(height: 16),
        // 예시
        Text(
          '예시 (축구)',
          style: AppTextStyles.body2NormalBold.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '라인: 2.5 언더/오버\n실제 결과:',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('2:0 → 합계 2점 → 2.5보다 작음 → 언더'),
        _buildBulletPoint('2:1 → 합계 3점 → 2.5보다 큼 → 오버'),
      ],
    );
  }

  /// 불릿 포인트
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.white,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 들여쓰기 불릿
  Widget _buildIndentedBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.white,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 들여쓰기 텍스트
  Widget _buildIndentedText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 4),
      child: Text(
        text,
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
    );
  }
}

/// 용어 설명 바텀시트로 표시하는 함수
void showGlossaryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // 드래그 핸들
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 닫기 버튼
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
                  ),
                ),
                // 콘텐츠
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀
                        Text(
                          '용어 설명',
                          style: AppTextStyles.heading2Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // 핸디캡 섹션
                        _buildHandicapContent(),
                        const SizedBox(height: 32),
                        // 언더오버 섹션
                        _buildUnderOverContent(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildHandicapContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '1. 핸디캡(Handicap, HCP)',
        style: AppTextStyles.body1NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        '목적: 실력 차이가 있는 경기에서 배당을 만들기 위해 "가상의 점수 차"를 미리 주고 시작하는 베팅 방식이다.',
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        '핵심 개념',
        style: AppTextStyles.body2NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 8),
      _bulletPoint('강팀(우세팀): 핸디캡에서 불리하게 시작함 (예: -1.5, -2.5 같은 마이너스)'),
      _bulletPoint('약팀(열세팀): 핸디캡에서 유리하게 시작함 (예: +1.5, +2.5 같은 플러스)'),
      _bulletPoint('"최종 스코어에 핸디캡을 더해서" 승패를 판단한다.'),
    ],
  );
}

Widget _buildUnderOverContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '2. 언더오버(Under/Over, U/O)',
        style: AppTextStyles.body1NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        '목적: 승패가 아니라 "총 득점(두 팀 합산)"이 기준선을 넘는지/안 넘는지를 맞추는 방식이다.',
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.white,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        '핵심 개념',
        style: AppTextStyles.body2NormalBold.copyWith(
          color: AppColors.white,
        ),
      ),
      const SizedBox(height: 8),
      _bulletPoint('기준선(라인)이 주어짐: 예) 2.5, 3.5, 7.5 등'),
      _bulletPoint('두 팀 점수 합계가'),
      _bulletPoint('기준선보다 크면: 오버(Over)'),
      _bulletPoint('기준선보다 작으면: 언더(Under)'),
    ],
  );
}

Widget _bulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.white,
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}
