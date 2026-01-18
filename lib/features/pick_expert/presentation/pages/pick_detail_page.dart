import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 픽 상세보기 페이지
class PickDetailPage extends StatelessWidget {
  final bool isPaidPick;
  final String expertName;

  const PickDetailPage({
    super.key,
    this.isPaidPick = false,
    this.expertName = '닉네임명',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: '(${isPaidPick ? "유료" : "무료"})$expertName',
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 전문가 정보 카드
                    _buildExpertInfoCard(),
                    const SizedBox(height: 16),
                    // 집중분석 섹션
                    _buildAnalysisSection(),
                    const SizedBox(height: 16),
                    // 팀 비교 테이블
                    _buildTeamComparisonTable(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 전문가 정보 카드
  Widget _buildExpertInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 전문가 정보 상단
          _buildExpertHeader(),
          const SizedBox(height: 12),
          // 유료픽: 구매/가격 버튼, 무료픽: 조회수
          if (isPaidPick) ...[
            _buildPurchaseButtons(),
          ] else ...[
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '조회수 NNN',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelAlternative,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          // 구분선
          Container(
            height: 1,
            color: AppColors.borderNormal,
          ),
          const SizedBox(height: 16),
          // 경기 정보
          _buildMatchInfo(),
          const SizedBox(height: 16),
          // 타이틀 배너
          _buildTitleBanner(),
          const SizedBox(height: 16),
          // 예측 버튼들
          _buildPredictionButtons(),
        ],
      ),
    );
  }

  /// 구매/가격 버튼 (유료픽 전용)
  Widget _buildPurchaseButtons() {
    return Row(
      children: [
        // 구매 NNN 버튼
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '구매 NNN',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 가격 버튼
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'n,nnn P',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.negative,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 전문가 정보 헤더
  Widget _buildExpertHeader() {
    return Row(
      children: [
        // 전문가 프로필 이미지
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 60,
            height: 60,
            color: AppColors.containerNormal,
            child: const Icon(
              Icons.person,
              size: 32,
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 전문가 정보
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '전문가명',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '최근 NN게임 NN승 NN패',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              // 유료픽: 주종목 정보 표시
              if (isPaidPick) ...[
                Text(
                  '주종목 : 야구 (일간스포츠 베팅킥)',
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ],
          ),
        ),
        // 알림 + 배당
        Column(
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
            const SizedBox(height: 4),
            Text(
              'N.NNN',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 경기 정보
  Widget _buildMatchInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 홈팀
        _buildTeamColumn('팀명', isHome: true),
        const SizedBox(width: 22),
        // 일시
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                '7/11 (금)',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              Text(
                '15 : 30',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 22),
        // 원정팀
        _buildTeamColumn('팀명', isHome: false),
      ],
    );
  }

  /// 팀 컬럼
  Widget _buildTeamColumn(String teamName, {required bool isHome}) {
    return Column(
      children: [
        // 팀 로고
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.sports_soccer,
              size: 32,
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 팀명
        Text(
          teamName,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 타이틀 배너
  Widget _buildTitleBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.primaryBackground,
      child: Center(
        child: Text(
          isPaidPick ? '상세정보' : '타이틀 노출',
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 예측 버튼들
  Widget _buildPredictionButtons() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            // 승패 버튼
            Expanded(
              child: Column(
                children: [
                  Text(
                    '승 N패',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildFilledButton('승패', isSelected: true),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // 1 버튼
            Expanded(
              child: Column(
                children: [
                  Text(
                    '승 N패',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildOutlinedButton('1'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // 핸디 버튼
            Expanded(
              child: Column(
                children: [
                  Text(
                    '+N.N',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.negative,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildFilledButton('핸디', isSelected: true),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // U/O 버튼
            Expanded(
              child: Column(
                children: [
                  Text(
                    'N.N',
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.negative,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildOutlinedButton('U/O'),
                ],
              ),
            ),
          ],
        ),
        // 적중 뱃지 (무료픽만 표시 - 경기 종료 후 결과)
        if (!isPaidPick) ...[
          Positioned(
            left: -8,
            top: 10,
            child: _buildHitBadge(),
          ),
          Positioned(
            left: 140,
            top: 10,
            child: _buildHitBadge(),
          ),
        ],
      ],
    );
  }

  /// 채워진 버튼 (선택됨)
  Widget _buildFilledButton(String label, {bool isSelected = false}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.contentsNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  /// 아웃라인 버튼
  Widget _buildOutlinedButton(String label) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ),
    );
  }

  /// 적중 뱃지
  Widget _buildHitBadge() {
    return Transform.rotate(
      angle: -0.52, // -30 degrees in radians
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.negative,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '적중',
          style: AppTextStyles.caption1Bold.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  /// 집중분석 섹션
  Widget _buildAnalysisSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '집중분석',
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 144,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '이용자가 작성한 글 노출',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 팀 비교 테이블
  Widget _buildTeamComparisonTable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 헤더 행 (팀명 + VS + 팀명)
          _buildTeamHeaderRow(),
          // 리그명 행
          _buildComparisonRow('리그명 노출', '무승부', '리그명 노출'),
          // 순위 행
          _buildComparisonRow('N위', '순위', 'N위'),
          // 전적 행
          _buildComparisonRow('N승N패', '전적', 'N승N패'),
          // 최근 5경기 행
          _buildRecent5GamesRow(),
          // 상대 전적 행
          _buildComparisonRow('N승 N패', '상대 전적', 'N승 N패'),
          // 승률 행
          _buildComparisonRow('N승 N패', '승률', 'N승 N패'),
          // 홈 승률 행
          _buildComparisonRow('N승 N패', '홈 승률', 'N승 N패'),
          // 원정 승률 행
          _buildComparisonRow('N승 N패', '원정 승률', 'N승 N패'),
        ],
      ),
    );
  }

  /// 팀 헤더 행
  Widget _buildTeamHeaderRow() {
    return Row(
      children: [
        // 홈팀
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Column(
              children: [
                // 국기 아이콘 (플레이스홀더)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.containerNormal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.flag,
                    size: 16,
                    color: AppColors.labelAlternative,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '팀명',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ),
        ),
        // VS
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Text(
                  'VS',
                  style: AppTextStyles.body2NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // 원정팀
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Column(
              children: [
                // 국기 아이콘 (플레이스홀더)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.containerNormal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.flag,
                    size: 16,
                    color: AppColors.labelAlternative,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '팀명',
                  style: AppTextStyles.label1NormalBold.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 비교 행
  Widget _buildComparisonRow(String homeValue, String label, String awayValue) {
    return Row(
      children: [
        // 홈팀 값
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                homeValue,
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
          ),
        ),
        // 라벨
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        ),
        // 원정팀 값
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                awayValue,
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 최근 5경기 행 (색상 있는 텍스트)
  Widget _buildRecent5GamesRow() {
    return Row(
      children: [
        // 홈팀 최근 결과
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: _buildRecentGamesText(),
            ),
          ),
        ),
        // 라벨
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: Text(
                '최근 5경기',
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        ),
        // 원정팀 최근 결과
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.borderNormal),
            ),
            child: Center(
              child: _buildRecentGamesText(),
            ),
          ),
        ),
      ],
    );
  }

  /// 최근 경기 결과 텍스트 (승/패 색상)
  Widget _buildRecentGamesText() {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.caption1Medium,
        children: [
          TextSpan(
            text: '(승)',
            style: TextStyle(color: AppColors.negative),
          ),
          TextSpan(
            text: '(패)',
            style: TextStyle(color: AppColors.positive),
          ),
          TextSpan(
            text: '(승)',
            style: TextStyle(color: AppColors.negative),
          ),
          TextSpan(
            text: '(패)',
            style: TextStyle(color: AppColors.positive),
          ),
          TextSpan(
            text: '(승)',
            style: TextStyle(color: AppColors.negative),
          ),
        ],
      ),
    );
  }
}
