import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';

/// 커뮤니티 페이지
class CommunityPage extends StatefulWidget {
  const CommunityPage({
    super.key,
    this.showBottomNav = true,
  });

  /// 하단 네비게이션 표시 여부
  final bool showBottomNav;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedCategoryIndex = 0;
  String _selectedSort = '최신순';

  final List<String> _categories = [
    '전체',
    '자유게시판',
    '축구',
    '야구',
    '농구',
    '배구',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            // 카테고리 탭
            _buildCategoryTabs(),
            // 요약 정보
            _buildSummaryRow(),
            // 게시글 리스트
            Expanded(
              child: _buildPostList(),
            ),
          ],
        ),
      ),
      // 플로팅 버튼
      floatingActionButton: _buildFloatingButton(),
      // 하단 네비게이션
      bottomNavigationBar: widget.showBottomNav ? _buildBottomNavigation() : null,
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '커뮤니티',
            style: AppTextStyles.h3Bold.copyWith(
              color: AppColors.labelStrong,
            ),
          ),
        ],
      ),
    );
  }

  /// 카테고리 탭
  Widget _buildCategoryTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedCategoryIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  _categories[index],
                  style: isSelected
                      ? AppTextStyles.body1NormalBold.copyWith(
                          color: AppColors.primaryFigma,
                        )
                      : AppTextStyles.body1NormalMedium.copyWith(
                          color: AppColors.labelAlternative,
                        ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// 요약 정보
  Widget _buildSummaryRow() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 총 개수
          Row(
            children: [
              Text(
                '총 ',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              Text(
                'NNNNN개',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.primaryFigma,
                ),
              ),
              Text(
                ' 등록',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ],
          ),
          // 정렬 드롭다운
          GestureDetector(
            onTap: () => _showSortBottomSheet(),
            child: Row(
              children: [
                Text(
                  _selectedSort,
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.caretDown,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.labelNormal,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 정렬 바텀시트
  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 핸들바
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.labelAlternative,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '정렬',
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              _buildSortOption('최신순'),
              _buildSortOption('인기순'),
              _buildSortOption('댓글순'),
              _buildSortOption('조회순'),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// 정렬 옵션
  Widget _buildSortOption(String sort) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = sort;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          sort,
          style: AppTextStyles.body1NormalMedium.copyWith(
            color: _selectedSort == sort
                ? AppColors.primaryFigma
                : AppColors.labelNormal,
          ),
        ),
      ),
    );
  }

  /// 게시글 리스트
  Widget _buildPostList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _buildPostCard();
      },
    );
  }

  /// 게시글 카드
  Widget _buildPostCard() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/community-detail');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderNormal),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단: 카테고리, 제목, 썸네일
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
                        style: AppTextStyles.body1NormalBold.copyWith(
                          color: AppColors.labelNormal,
                        ),
                      ),
                    ],
                  ),
                ),
                // 썸네일
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 64,
                    height: 64,
                    color: AppColors.containerNormal,
                    child: const Icon(
                      Icons.image,
                      size: 32,
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 하단: 날짜 + 통계
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 날짜
                Text(
                  'yyyy.mm.dd',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
                // 통계
                Row(
                  children: [
                    // 조회수
                    _buildStatItem(AppIcons.eye, 'NNN'),
                    const SizedBox(width: 6),
                    // 좋아요
                    _buildStatItem(AppIcons.like, 'NNN'),
                    const SizedBox(width: 6),
                    // 댓글
                    _buildStatItem(AppIcons.bubble, 'NNN'),
                  ],
                ),
              ],
            ),
          ],
        ),
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

  /// 플로팅 버튼
  Widget _buildFloatingButton() {
    return FloatingActionButton(
      heroTag: 'community_fab',
      onPressed: () {
        Navigator.pushNamed(context, '/community-write');
      },
      backgroundColor: AppColors.primaryFigma,
      shape: const CircleBorder(),
      child: SvgPicture.asset(
        AppIcons.write,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  /// 하단 네비게이션
  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(AppIcons.home, '홈', false),
              _buildNavItem(AppIcons.check, '픽전문가', false),
              _buildNavItem(AppIcons.persons, '커뮤니티', true),
              _buildNavItem(AppIcons.trophy, '랭킹', false),
              _buildNavItem(AppIcons.person, 'MY', false),
            ],
          ),
        ),
      ),
    );
  }

  /// 네비게이션 아이템
  Widget _buildNavItem(String iconPath, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        // 네비게이션 처리
        if (label == '홈') {
          Navigator.pushReplacementNamed(context, '/main');
        } else if (label == '픽전문가') {
          Navigator.pushReplacementNamed(context, '/main/pick-expert');
        } else if (label == '랭킹') {
          Navigator.pushReplacementNamed(context, '/main/ranking');
        } else if (label == 'MY') {
          Navigator.pushReplacementNamed(context, '/main/my');
        }
      },
      child: Container(
        width: 54,
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primaryFigma : AppColors.labelAlternative,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: isActive
                  ? AppTextStyles.label1Bold.copyWith(
                      color: AppColors.primaryFigma,
                    )
                  : AppTextStyles.label1Medium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
