import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 경기 상태 타입
enum MatchStatus {
  /// 경기 전
  before,

  /// 경기 중
  live,

  /// 경기 종료
  finished,
}

/// 라이브 경기 상세 페이지 (채팅)
class LiveMatchDetailPage extends StatefulWidget {
  const LiveMatchDetailPage({
    super.key,
    this.matchStatus = MatchStatus.before,
  });

  /// 경기 상태
  final MatchStatus matchStatus;

  @override
  State<LiveMatchDetailPage> createState() => _LiveMatchDetailPageState();
}

/// 태깅 타입 (구중/진중)
enum TagType {
  /// 구중 (빨간색)
  gujung,

  /// 진중 (파란색)
  jinjung,
}

class _LiveMatchDetailPageState extends State<LiveMatchDetailPage> {
  int _selectedTabIndex = 0;
  int? _showMenuForIndex; // 메뉴가 표시되는 메시지 인덱스
  final Set<int> _blockedUsers = {}; // 차단된 사용자 인덱스
  final Map<int, TagType> _taggedUsers = {}; // 태깅된 사용자 (구중/진중)
  bool _isCheerInputMode = false; // 응원 메시지 입력 모드
  bool _isHomeTeamCheer = true; // 홈팀 응원 여부
  bool _isMentionMode = false; // 멘션 모드
  String? _mentionTargetUser; // 멘션 대상 사용자
  final TextEditingController _cheerMessageController = TextEditingController();

  final List<String> _tabs = ['라이브', '차트', '라인업', '예측게임'];

  @override
  void dispose() {
    _cheerMessageController.dispose();
    super.dispose();
  }

  /// 탭 네비게이션 처리
  void _navigateToTab(int index) {
    switch (index) {
      case 0: // 라이브 (현재 페이지)
        setState(() {
          _selectedTabIndex = index;
        });
        break;
      case 1: // 차트
        Navigator.of(context).pushReplacementNamed('/chart-comparison');
        break;
      case 2: // 라인업
        Navigator.of(context).pushReplacementNamed('/lineup');
        break;
      case 3: // 예측게임
        Navigator.of(context).pushReplacementNamed('/prediction-game');
        break;
    }
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
            // 탭 토글
            _buildTabToggle(),
            // 컨텐츠
            Expanded(
              child: _buildContent(),
            ),
            // 하단 응원 바 또는 메시지 입력 바
            _isMentionMode
                ? _buildMentionInputBar()
                : (_isCheerInputMode ? _buildCheerInputBar() : _buildCheerBar()),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return AppHeader(
      showBackButton: true,
      onBackPressed: () => Navigator.of(context).pop(),
      rightButtons: [
        AppHeaderAction(
          type: AppHeaderButtonType.notification,
          onPressed: () {
            // TODO: 알림
          },
        ),
        AppHeaderAction(
          type: AppHeaderButtonType.sparkle,
          onPressed: () {
            // TODO: AI
          },
        ),
      ],
    );
  }

  /// 5단 탭 토글
  Widget _buildTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = index == _selectedTabIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToTab(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryFigma : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.white)
                        : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelNormal),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 컨텐츠 (라이브 탭)
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 탭과 운영자 등록글 사이 간격
          const SizedBox(height: 8),
          // 운영자 공지
          _buildNoticeBar(),
          // 예측 결과 & 경기 정보
          _buildMatchInfoSection(),
          // 구분선
          Container(
            height: 8,
            color: AppColors.containerNormal,
          ),
          // 새로고침 버튼
          _buildRefreshBar(),
          // 채팅 메시지 리스트
          _buildChatList(),
        ],
      ),
    );
  }

  /// 운영자 공지 바
  Widget _buildNoticeBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.primaryContainer,
      child: Center(
        child: Text(
          '운영자 등록글 노출',
          style: AppTextStyles.label1NormalMedium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 경기 정보 섹션
  Widget _buildMatchInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // 예측 결과 텍스트
          Text(
            '[예측결과] 팀명 NN% 승 / 핸패 / 오버',
            style: AppTextStyles.label1NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          const SizedBox(height: 4),
          // 배당률 테이블
          _buildOddsTable(),
          const SizedBox(height: 16),
          // 경기 정보 (팀 + 스코어)
          _buildMatchScoreInfo(),
        ],
      ),
    );
  }

  /// 배당률 테이블 (간소화)
  Widget _buildOddsTable() {
    return Column(
      children: [
        _buildOddsRow(homeOdds: 'N.NN', isHomeUp: true, awayOdds: 'N.NN', isAwayDown: true),
        _buildOddsRow(homeOdds: 'N.NN', isHomeUp: true, awayOdds: 'N.NN', isAwayDown: true),
      ],
    );
  }

  Widget _buildOddsRow({
    required String homeOdds,
    required bool isHomeUp,
    required String awayOdds,
    required bool isAwayDown,
  }) {
    return Row(
      children: [
        // 홈 배당
        Expanded(
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isHomeUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 24,
                  color: isHomeUp ? AppColors.negative : AppColors.positiveGreen,
                ),
                Text(
                  homeOdds,
                  style: AppTextStyles.label1NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 무승부
        Expanded(
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                '-',
                style: AppTextStyles.label1NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
          ),
        ),
        // 원정 배당
        Expanded(
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isAwayDown ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  size: 24,
                  color: isAwayDown ? AppColors.positiveGreen : AppColors.negative,
                ),
                Text(
                  awayOdds,
                  style: AppTextStyles.label1NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 경기 스코어 정보
  Widget _buildMatchScoreInfo() {
    // 경기 중/종료일 때는 라이브 스코어 표시
    if (widget.matchStatus == MatchStatus.live ||
        widget.matchStatus == MatchStatus.finished) {
      return _buildLiveScoreInfo();
    }
    // 경기 전일 때는 예상 스코어 표시
    return _buildBeforeMatchInfo();
  }

  /// 경기 전 정보 (예상 스코어 + 시간)
  Widget _buildBeforeMatchInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 홈팀
        _buildTeamWithScore(teamName: '팀명', score: '1'),
        const SizedBox(width: 8),
        // 시간 / 예상 스코어
        Column(
          children: [
            Text(
              '예상 스코어',
              style: AppTextStyles.label1NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '1',
                  style: AppTextStyles.h2Bold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.containerNeutral,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '20 : 00',
                    style: AppTextStyles.body1NormalMedium.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '5',
                  style: AppTextStyles.h2Bold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 8),
        // 원정팀
        _buildTeamWithScore(teamName: '팀명', score: '5'),
      ],
    );
  }

  /// 경기 중/종료 라이브 스코어 정보
  Widget _buildLiveScoreInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 홈팀
        _buildTeamWithName(teamName: '팀명'),
        const SizedBox(width: 16),
        // 홈 스코어
        Text(
          '1',
          style: AppTextStyles.h1Bold.copyWith(
            color: AppColors.labelNormal,
            fontSize: 40,
          ),
        ),
        const SizedBox(width: 8),
        // 이닝/시간 표시
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.containerNeutral,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.matchStatus == MatchStatus.finished ? '종료' : '8회 초',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
        const SizedBox(width: 8),
        // 원정 스코어
        Text(
          '5',
          style: AppTextStyles.h1Bold.copyWith(
            color: AppColors.labelNormal,
            fontSize: 40,
          ),
        ),
        const SizedBox(width: 16),
        // 원정팀
        _buildTeamWithName(teamName: '팀명'),
      ],
    );
  }

  /// 팀 정보 (이름만 표시 - 경기 중/종료용)
  Widget _buildTeamWithName({required String teamName}) {
    return Column(
      children: [
        // 팀 로고 (플레이스홀더)
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.containerNormal,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.sports_soccer,
              size: 24,
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          teamName,
          style: AppTextStyles.label1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamWithScore({required String teamName, required String score}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/team-info'),
      child: Column(
        children: [
          // 팀 로고 (플레이스홀더)
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.sports_soccer,
                size: 24,
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            teamName,
            style: AppTextStyles.label1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ],
      ),
    );
  }

  /// 새로고침 바
  Widget _buildRefreshBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // TODO: 새로고침
        },
        child: SvgPicture.asset(
          AppIcons.refresh,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.labelNeutral,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// 채팅 메시지 리스트
  Widget _buildChatList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 7, // 샘플 데이터
      itemBuilder: (context, index) {
        // 메시지 타입에 따라 색상 변경
        final isHomeTeam = index % 2 == 0;
        final isBlocked = _blockedUsers.contains(index);
        final showMenu = _showMenuForIndex == index;
        final tagType = _taggedUsers[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: _buildChatMessage(
            index: index,
            username: '도라에몽',
            rank: '뉴비',
            message: '메세지 노출',
            time: '오후 hh:mm',
            isHomeTeam: isHomeTeam,
            isBlocked: isBlocked,
            showMenu: showMenu,
            tagType: tagType,
          ),
        );
      },
    );
  }

  /// 채팅 메시지 아이템
  Widget _buildChatMessage({
    required int index,
    required String username,
    required String rank,
    required String message,
    required String time,
    required bool isHomeTeam,
    bool isBlocked = false,
    bool showMenu = false,
    TagType? tagType,
  }) {
    final bubbleColor = isHomeTeam
        ? const Color(0xFFE6F7E9) // positive container
        : const Color(0xFFE4F2FD); // decrease container

    // 태깅된 사용자 배경 색상
    Color backgroundColor;
    if (tagType == TagType.gujung) {
      backgroundColor = const Color(0x4DE6533E); // rgba(230,83,62,0.3)
    } else if (tagType == TagType.jinjung) {
      backgroundColor = const Color(0x4D3F94EE); // rgba(63,148,238,0.3)
    } else {
      backgroundColor = Colors.transparent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 이미지 + 태깅 배지
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 프로필 이미지 (탭하면 메뉴 토글)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_showMenuForIndex == index) {
                      _showMenuForIndex = null;
                    } else {
                      _showMenuForIndex = index;
                    }
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.containerNormal,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: AppColors.labelAlternative,
                    ),
                  ),
                ),
              ),
              // 태깅 배지
              if (tagType != null)
                Positioned(
                  left: -8,
                  top: -4,
                  child: Transform.rotate(
                    angle: -0.523599, // -30도 (라디안)
                    child: _buildTagBadge(tagType),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // 메뉴 또는 메시지 컨텐츠
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 메시지 컨텐츠
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 유저 정보 행
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              username,
                              style: AppTextStyles.label1NormalMedium.copyWith(
                                color: AppColors.labelNormal,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // 랭크 뱃지
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5F4D4D),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                rank,
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 멘션 버튼
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMentionMode = true;
                              _mentionTargetUser = username;
                            });
                          },
                          child: Text(
                            '@멘션',
                            style: AppTextStyles.caption1Medium.copyWith(
                              color: AppColors.primaryFigma,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // 메시지 버블
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: bubbleColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              message,
                              style: AppTextStyles.caption1Medium.copyWith(
                                color: AppColors.labelNeutral,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // 시간
                        Text(
                          time,
                          style: AppTextStyles.caption2Medium.copyWith(
                            color: AppColors.labelAlternative,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // 사용자 인터랙션 메뉴
                if (showMenu)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildUserInteractionMenu(index),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 태깅 배지 (구중/진중)
  Widget _buildTagBadge(TagType tagType) {
    final isGujung = tagType == TagType.gujung;
    final bgColor = isGujung
        ? const Color(0xFFFDECEE) // error container
        : const Color(0xFFE4F2FD); // decrease container
    final borderColor = isGujung
        ? const Color(0xFFE6533E) // error
        : const Color(0xFF3F94EE); // decrease
    final textColor = borderColor;
    final label = isGujung ? '구중' : '진중';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
          height: 1.4,
        ),
      ),
    );
  }

  /// 사용자 인터랙션 메뉴
  Widget _buildUserInteractionMenu(int userIndex) {
    return Container(
      width: 144,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuTableItem(
            icon: Icons.auto_awesome,
            label: '진중',
            onTap: () {
              setState(() {
                _taggedUsers[userIndex] = TagType.jinjung;
                _showMenuForIndex = null;
              });
            },
          ),
          _buildMenuTableItem(
            icon: Icons.settings,
            label: '구중',
            onTap: () {
              setState(() {
                _taggedUsers[userIndex] = TagType.gujung;
                _showMenuForIndex = null;
              });
            },
          ),
          _buildMenuTableItem(
            icon: Icons.campaign_outlined,
            label: '신고',
            onTap: () {
              setState(() {
                _showMenuForIndex = null;
              });
              // TODO: 신고 기능 구현
            },
          ),
          _buildMenuTableItem(
            icon: Icons.block,
            label: '차단',
            onTap: () {
              setState(() {
                _blockedUsers.add(userIndex);
                _showMenuForIndex = null;
              });
            },
          ),
        ],
      ),
    );
  }

  /// 메뉴 테이블 아이템 (Figma 디자인 기준)
  Widget _buildMenuTableItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderNormal),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.labelNeutral,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.label1NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 하단 응원 바
  Widget _buildCheerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.white,
      child: Row(
        children: [
          // 홈팀 응원 버튼
          GestureDetector(
            onTap: () {
              setState(() {
                _isCheerInputMode = true;
                _isHomeTeamCheer = true;
              });
            },
            child: _buildHomeCheerButton(count: '500'),
          ),
          const SizedBox(width: 8),
          // 원정팀 응원 버튼
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isCheerInputMode = true;
                  _isHomeTeamCheer = false;
                });
              },
              child: _buildAwayCheerButton(count: '300'),
            ),
          ),
        ],
      ),
    );
  }

  /// 홈팀 응원 버튼 (녹색, 아이콘 왼쪽)
  Widget _buildHomeCheerButton({required String count}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 다이아몬드 아이콘 박스
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.positiveGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.diamond,
              size: 24,
              color: AppColors.white,
            ),
          ),
        ),
        // 응원 텍스트 버튼
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F7E9),
            border: Border.all(color: AppColors.positiveGreen),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '응원',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.positiveGreen,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                count,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.positiveGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 원정팀 응원 버튼 (파란색, 아이콘 오른쪽)
  Widget _buildAwayCheerButton({required String count}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 응원 텍스트 버튼
        Expanded(
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F2FD),
              border: Border.all(color: AppColors.positive),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  count,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.positive,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '응원',
                  style: AppTextStyles.body1NormalBold.copyWith(
                    color: AppColors.positive,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 다이아몬드 아이콘 박스
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.positive,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.diamond,
              size: 24,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// 응원 메시지 입력 바
  Widget _buildCheerInputBar() {
    final teamName = _isHomeTeamCheer ? '홈팀' : '원정팀';
    final headerColor = _isHomeTeamCheer
        ? AppColors.positiveGreen
        : AppColors.positive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 헤더 바
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: const Color(0xFF2D2D2D),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '($teamName)응원 메세지',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCheerInputMode = false;
                    _cheerMessageController.clear();
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        // 입력 필드
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.white,
          child: Row(
            children: [
              // + 버튼
              GestureDetector(
                onTap: () {
                  // TODO: 이미지/GIF 추가
                },
                child: const Icon(
                  Icons.add,
                  size: 24,
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(width: 16),
              // 텍스트 입력 필드
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderNormal),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _cheerMessageController,
                    decoration: InputDecoration(
                      hintText: '응원 메시지 입력',
                      hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      isDense: true,
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
                  // TODO: 메시지 전송
                  if (_cheerMessageController.text.isNotEmpty) {
                    // 전송 로직
                    setState(() {
                      _cheerMessageController.clear();
                    });
                  }
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _cheerMessageController.text.isEmpty
                        ? const Color(0xFFCCCCCC)
                        : headerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.send,
                      size: 24,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 멘션 입력 바
  Widget _buildMentionInputBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 헤더 바 (파란색)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColors.positive,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '($_mentionTargetUser)멘션',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMentionMode = false;
                    _mentionTargetUser = null;
                    _cheerMessageController.clear();
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        // 입력 필드
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.white,
          child: Row(
            children: [
              // + 버튼
              GestureDetector(
                onTap: () {
                  // TODO: 이미지/GIF 추가
                },
                child: const Icon(
                  Icons.add,
                  size: 24,
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(width: 16),
              // 텍스트 입력 필드
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.borderNormal),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _cheerMessageController,
                    decoration: InputDecoration(
                      hintText: '응원 메시지 입력',
                      hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                        color: AppColors.labelAlternative,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      isDense: true,
                    ),
                    style: AppTextStyles.body1NormalMedium.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // 전송 버튼 (파란색)
              GestureDetector(
                onTap: () {
                  // TODO: 멘션 메시지 전송
                  if (_cheerMessageController.text.isNotEmpty) {
                    setState(() {
                      _cheerMessageController.clear();
                      _isMentionMode = false;
                      _mentionTargetUser = null;
                    });
                  }
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _cheerMessageController.text.isEmpty
                        ? const Color(0xFFCCCCCC)
                        : AppColors.positive,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.send,
                      size: 24,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
