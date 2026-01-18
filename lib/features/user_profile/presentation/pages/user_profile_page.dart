import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 사용자 프로필 탭 타입
enum UserProfileTab { posts, cheers, prediction, notification }

/// 사용자 프로필 페이지
class UserProfilePage extends StatefulWidget {
  final UserProfileTab initialTab;

  const UserProfilePage({
    super.key,
    this.initialTab = UserProfileTab.posts,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late UserProfileTab _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
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
                  children: [
                    // 프로필 섹션
                    _buildProfileSection(),
                    const SizedBox(height: 16),
                    // 탭
                    _buildTabs(),
                    // 탭 컨텐츠
                    _buildTabContent(),
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
  Widget _buildHeader() {
    return Container(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 뒤로가기 버튼
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
                      AppIcons.chevronLeft,
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
          // 신고 버튼
          Positioned(
            right: 12,
            child: GestureDetector(
              onTap: () {
                // 신고 처리
              },
              child: Text(
                '신고',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.decrease,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 프로필 섹션
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 정보 (왼쪽)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // 프로필 상단 (이미지 + 닉네임)
                _buildProfileTop(),
                const SizedBox(height: 16),
                // 통계 카드
                _buildStatCards(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 알림 사이드바 (오른쪽)
          Expanded(
            flex: 1,
            child: _buildNotificationSidebar(),
          ),
        ],
      ),
    );
  }

  /// 프로필 상단
  Widget _buildProfileTop() {
    return Row(
      children: [
        // 프로필 이미지
        Stack(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.containerNormal,
              ),
              child: const Icon(
                Icons.person,
                size: 40,
                color: AppColors.labelAlternative,
              ),
            ),
            // 수정 뱃지
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
                  '수정',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        // 닉네임 + 통계
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 닉네임
            Text(
              '닉네임',
              style: AppTextStyles.h3Bold.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
            const SizedBox(height: 4),
            // 받은 알림
            Row(
              children: [
                Text(
                  '받은 알림',
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'NN',
                  style: AppTextStyles.label1Bold.copyWith(
                    color: AppColors.decrease,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // 예측성공
            Row(
              children: [
                Text(
                  '예측성공',
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'NN%/NNN',
                  style: AppTextStyles.label1Bold.copyWith(
                    color: AppColors.negative,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// 통계 카드
  Widget _buildStatCards() {
    return Column(
      children: [
        // 인증뱃지 + 활동온도
        Row(
          children: [
            Expanded(child: _buildStatCard('인증뱃지', 'N개')),
            const SizedBox(width: 8),
            Expanded(child: _buildStatCard('활동온도', '42.9°C')),
          ],
        ),
        const SizedBox(height: 8),
        // 포인트
        SizedBox(
          width: double.infinity,
          child: _buildStatCard('포인트', 'NNN,NNN P'),
        ),
      ],
    );
  }

  /// 통계 카드 위젯
  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.label1Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ],
      ),
    );
  }

  /// 알림 사이드바
  Widget _buildNotificationSidebar() {
    return Row(
      children: [
        // 첫 번째 열 (나를 알림 설정한 사람)
        _buildNotificationColumn(isLeftColumn: true),
        // 두 번째 열 (내가 알림한 사람)
        _buildNotificationColumn(isLeftColumn: false),
      ],
    );
  }

  /// 알림 열
  /// [isLeftColumn] true: 나를 알림 설정한 사람 (빨간색, 왼쪽 화살표)
  ///                false: 내가 알림한 사람 (파란색, 오른쪽 화살표)
  Widget _buildNotificationColumn({required bool isLeftColumn}) {
    final badgeColor = isLeftColumn ? AppColors.negative : AppColors.decrease;
    final arrowIcon = isLeftColumn ? AppIcons.arrowLeft : AppIcons.arrowRight;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 헤더 (벨 아이콘 + 화살표 뱃지)
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.containerNeutral,
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.only(
                topLeft: isLeftColumn ? const Radius.circular(8) : Radius.zero,
                topRight: !isLeftColumn ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.bell,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.labelNeutral,
                    BlendMode.srcIn,
                  ),
                ),
                // 화살표 뱃지
                Positioned(
                  top: 4,
                  right: 10,
                  child: Container(
                    width: 13,
                    height: 13,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      arrowIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 사용자 리스트
          Container(
            height: 188,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.only(
                bottomLeft: isLeftColumn ? const Radius.circular(8) : Radius.zero,
                bottomRight: !isLeftColumn ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildUserAvatar();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 사용자 아바타
  Widget _buildUserAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person,
              size: 20,
              color: AppColors.labelAlternative,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '닉네임',
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
        ],
      ),
    );
  }

  /// 탭
  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem('게시글', UserProfileTab.posts),
          _buildTabItem('응원글', UserProfileTab.cheers),
          _buildTabItem('예측게임', UserProfileTab.prediction),
          _buildTabItem('알림', UserProfileTab.notification),
        ],
      ),
    );
  }

  /// 탭 아이템
  Widget _buildTabItem(String label, UserProfileTab tab) {
    final isSelected = _selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = tab;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: isSelected
                  ? AppTextStyles.body1NormalBold.copyWith(
                      color: AppColors.primaryFigma,
                    )
                  : AppTextStyles.body1NormalMedium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  /// 탭 컨텐츠
  Widget _buildTabContent() {
    switch (_selectedTab) {
      case UserProfileTab.posts:
        return _buildPostList();
      case UserProfileTab.cheers:
        return _buildCheerList();
      case UserProfileTab.prediction:
        return _buildPredictionList();
      case UserProfileTab.notification:
        return _buildNotificationList();
    }
  }

  /// 게시글 리스트
  Widget _buildPostList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildPostCard();
      },
    );
  }

  /// 게시글 카드
  Widget _buildPostCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 컨텐츠 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 카테고리 칩
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '자유게시판',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.primaryFigma,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // 제목
                Text(
                  '게시글 제목이 들어갑니다. 최대 2줄까지 표시됩니다.',
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // 날짜 + 통계
                Row(
                  children: [
                    Text(
                      '2025.01.19',
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 조회수
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.eye,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColors.labelAlternative,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'NNN',
                          style: AppTextStyles.caption1Medium.copyWith(
                            color: AppColors.labelAlternative,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // 좋아요
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.heartFill,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColors.labelAlternative,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'NNN',
                          style: AppTextStyles.caption1Medium.copyWith(
                            color: AppColors.labelAlternative,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // 댓글
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.bubble,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColors.labelAlternative,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'NNN',
                          style: AppTextStyles.caption1Medium.copyWith(
                            color: AppColors.labelAlternative,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 썸네일 이미지
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image,
              size: 32,
              color: AppColors.labelAlternative,
            ),
          ),
        ],
      ),
    );
  }

  /// 응원글 리스트
  Widget _buildCheerList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildCheerCard();
      },
    );
  }

  /// 응원글 카드
  Widget _buildCheerCard() {
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
          // 경기 정보
          Row(
            children: [
              Text(
                '프리미어리그',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '맨유 vs 리버풀',
                style: AppTextStyles.label1Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 응원 내용
          Text(
            '응원글 내용이 들어갑니다.',
            style: AppTextStyles.body1NormalMedium.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 8),
          // 날짜
          Text(
            '2025.01.19',
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelAlternative,
            ),
          ),
        ],
      ),
    );
  }

  /// 예측게임 리스트
  Widget _buildPredictionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildPredictionCard(index % 2 == 0);
      },
    );
  }

  /// 예측게임 카드
  Widget _buildPredictionCard(bool isWin) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          // 결과 뱃지
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isWin ? AppColors.negative : AppColors.decrease,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isWin ? '적중' : '실패',
              style: AppTextStyles.caption1Bold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 경기 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '프리미어리그',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '맨유 vs 리버풀',
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ),
          // 날짜
          Text(
            '2025.01.19',
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelAlternative,
            ),
          ),
        ],
      ),
    );
  }

  /// 알림 리스트
  Widget _buildNotificationList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildNotificationCard();
      },
    );
  }

  /// 알림 카드
  Widget _buildNotificationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          // 프로필 이미지
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerNormal,
            ),
            child: const Icon(
              Icons.person,
              size: 20,
              color: AppColors.labelAlternative,
            ),
          ),
          const SizedBox(width: 12),
          // 알림 내용
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '닉네임',
                      style: AppTextStyles.label1Bold.copyWith(
                        color: AppColors.labelNormal,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '님이 알림을 보냈습니다.',
                      style: AppTextStyles.label1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '2025.01.19',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
