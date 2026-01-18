import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 커뮤니티 상세보기 페이지
class CommunityDetailPage extends StatefulWidget {
  final int imageCount;

  const CommunityDetailPage({
    super.key,
    this.imageCount = 1,
  });

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
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
            AppHeader.simple(
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 이미지 (단일 또는 다중)
                    _buildImages(),
                    // 게시글 정보
                    _buildPostInfo(),
                    // 게시글 내용
                    _buildPostContent(),
                    // 댓글 섹션
                    _buildCommentSection(),
                  ],
                ),
              ),
            ),
            // 댓글 입력
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  /// 이미지 (단일 또는 다중)
  Widget _buildImages() {
    return Column(
      children: List.generate(widget.imageCount, (index) {
        return Container(
          width: double.infinity,
          height: 240,
          color: AppColors.containerNormal,
          child: const Icon(
            Icons.image,
            size: 64,
            color: AppColors.labelAlternative,
          ),
        );
      }),
    );
  }

  /// 게시글 정보
  Widget _buildPostInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단: 카테고리/제목 + 날짜
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 카테고리 + 제목
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 카테고리 칩
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '카테고리 명',
                        style: AppTextStyles.caption1Medium.copyWith(
                          color: AppColors.primaryFigma,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // 제목
                    Text(
                      '제목',
                      style: AppTextStyles.h4Bold.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                  ],
                ),
              ),
              // 날짜
              Text(
                'yyyy.mm.dd',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelAlternative,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 하단: 작성자 + 통계
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 작성자 정보
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/user-profile'),
                child: Row(
                  children: [
                    // 프로필 이미지
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.containerNormal,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 16,
                        color: AppColors.labelAlternative,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 닉네임
                    Text(
                      '닉네임',
                      style: AppTextStyles.caption1SemiBold.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                  ],
                ),
              ),
              // 통계
              Row(
                children: [
                  _buildStatItem(AppIcons.eye, 'NNN'),
                  const SizedBox(width: 6),
                  _buildStatItem(AppIcons.like, 'NNN'),
                  const SizedBox(width: 6),
                  _buildStatItem(AppIcons.bubble, 'NNN'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 통계 아이템
  Widget _buildStatItem(String iconPath, String count) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.labelNeutral,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          count,
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
      ],
    );
  }

  /// 게시글 내용
  Widget _buildPostContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Text(
        '글에 대한 내용이 들어갑니다 쭈욱 글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱\n\n글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱글에 대한 내용이 들어갑니다 쭈욱',
        style: AppTextStyles.label1ReadingMedium.copyWith(
          color: AppColors.labelNeutral,
        ),
      ),
    );
  }

  /// 댓글 섹션
  Widget _buildCommentSection() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // 댓글 헤더
        _buildCommentHeader(),
        // 댓글 리스트
        _buildCommentList(),
      ],
    );
  }

  /// 댓글 헤더
  Widget _buildCommentHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 댓글 (NNN개)
          Row(
            children: [
              Text(
                '댓글',
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(NNN개)',
                style: AppTextStyles.h4Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
          // 좋아요 버튼
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.heartFill,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.negative,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'NNN개',
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 댓글 리스트
  Widget _buildCommentList() {
    return Column(
      children: [
        _buildCommentItem(hasReplies: false),
        _buildCommentItem(hasReplies: true, replyCount: 3),
        _buildCommentItem(hasReplies: false),
        _buildCommentItem(hasReplies: false),
      ],
    );
  }

  /// 댓글 아이템
  Widget _buildCommentItem({bool hasReplies = false, int replyCount = 0}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 닉네임 + 시간 + 신고
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '닉네임',
                    style: AppTextStyles.label1Bold.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'N분 전',
                    style: AppTextStyles.label1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                ],
              ),
              Text(
                '신고',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.negative,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // 댓글 내용
          Text(
            '댓글에 대한 내용이 나옵니다.',
            style: AppTextStyles.label1ReadingMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 8),
          // 좋아요 + 답글달기
          Row(
            children: [
              // 좋아요
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.heart,
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.labelNeutral,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'NNN개',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              // 답글달기
              Text(
                '답글달기',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
          // 답글 더보기
          if (hasReplies) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Text(
                    '답글 $replyCount개 더보기',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    AppIcons.chevronDown,
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.labelNeutral,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 댓글 입력
  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: SafeArea(
        child: Row(
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
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: '댓글을 입력하세요.',
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
              ),
            ),
            const SizedBox(width: 6),
            // 전송 버튼
            GestureDetector(
              onTap: () {
                // 댓글 전송
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryFigma,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.send,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
