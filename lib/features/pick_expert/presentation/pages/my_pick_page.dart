import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// MY 픽 탭 타입
enum MyPickTab {
  purchased, // 구매한 픽
  alerted, // 알림한 픽
}

/// MY 픽 페이지
class MyPickPage extends StatefulWidget {
  final MyPickTab initialTab;

  const MyPickPage({
    super.key,
    this.initialTab = MyPickTab.purchased,
  });

  @override
  State<MyPickPage> createState() => _MyPickPageState();
}

class _MyPickPageState extends State<MyPickPage> {
  late MyPickTab _selectedTab;
  String? _selectedMatchStatus;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _selectedMatchStatus ??= l10n.matchStatus;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: l10n.myPick,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // 토글
                    _buildToggle(l10n),
                    const SizedBox(height: 16),
                    // 필터 섹션
                    _buildFilterSection(l10n),
                    const SizedBox(height: 16),
                    // 픽 카드 리스트
                    _buildPickCardList(l10n),
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

  /// 토글
  Widget _buildToggle(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.containerNeutral,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // 구매한 픽
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = MyPickTab.purchased;
                  });
                },
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: _selectedTab == MyPickTab.purchased
                        ? AppColors.primaryFigma
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      l10n.purchasedPick,
                      style: _selectedTab == MyPickTab.purchased
                          ? AppTextStyles.body1NormalBold.copyWith(
                              color: AppColors.white,
                            )
                          : AppTextStyles.body1NormalMedium.copyWith(
                              color: AppColors.labelNeutral,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            // 알림한 픽
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = MyPickTab.alerted;
                  });
                },
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: _selectedTab == MyPickTab.alerted
                        ? AppColors.primaryFigma
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      l10n.alertedPick,
                      style: _selectedTab == MyPickTab.alerted
                          ? AppTextStyles.body1NormalBold.copyWith(
                              color: AppColors.white,
                            )
                          : AppTextStyles.body1NormalMedium.copyWith(
                              color: AppColors.labelNeutral,
                            ),
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

  /// 필터 섹션
  Widget _buildFilterSection(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            // 경기상태 드롭다운
            GestureDetector(
              onTap: () => _showMatchStatusBottomSheet(),
              child: Container(
                width: 116,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderNormal),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        _selectedMatchStatus!,
                        style: AppTextStyles.body1NormalMedium.copyWith(
                          color: AppColors.labelAlternative,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: SvgPicture.asset(
                        AppIcons.caretDown,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.labelAlternative,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // 검색 입력
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderNormal),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.textPlaceholder,
                    hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                      color: AppColors.labelAlternative,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                  ),
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 경기상태 바텀시트
  void _showMatchStatusBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.matchStatus,
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              // 옵션들
              _buildMatchStatusOption(l10n.all),
              _buildMatchStatusOption(l10n.beforeMatch),
              _buildMatchStatusOption(l10n.duringMatch),
              _buildMatchStatusOption(l10n.afterMatch),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// 경기상태 옵션
  Widget _buildMatchStatusOption(String status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMatchStatus = status;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          status,
          style: AppTextStyles.body1NormalMedium.copyWith(
            color: _selectedMatchStatus == status
                ? AppColors.primaryFigma
                : AppColors.labelNormal,
          ),
        ),
      ),
    );
  }

  /// 픽 카드 리스트
  Widget _buildPickCardList(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildPickCard(l10n),
          const SizedBox(height: 16),
          _buildPickCard(l10n),
        ],
      ),
    );
  }

  /// 픽 카드
  Widget _buildPickCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 전문가 정보
          _buildExpertInfo(l10n),
          const SizedBox(height: 12),
          // 조회수
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${l10n.viewCount} NNN',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 구분선
          Container(
            height: 1,
            color: AppColors.borderNormal,
          ),
          const SizedBox(height: 16),
          // 경기 정보
          _buildMatchInfo(l10n),
          const SizedBox(height: 16),
          // 타이틀 배너
          _buildTitleBanner(l10n),
          const SizedBox(height: 16),
          // 예측 버튼들
          _buildPredictionButtons(l10n),
        ],
      ),
    );
  }

  /// 전문가 정보
  Widget _buildExpertInfo(AppLocalizations l10n) {
    return Row(
      children: [
        // 프로필 이미지
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
                l10n.expertName,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.recentGames('NN', 'NN', 'NN'),
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
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
  Widget _buildMatchInfo(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 홈팀
        _buildTeamColumn(l10n.teamName),
        const SizedBox(width: 22),
        // 일시
        Container(
          width: 96,
          padding: const EdgeInsets.all(8),
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
        _buildTeamColumn(l10n.teamName),
      ],
    );
  }

  /// 팀 컬럼
  Widget _buildTeamColumn(String teamName) {
    return Column(
      children: [
        // 팀 로고
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
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
  Widget _buildTitleBanner(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.primaryBackground,
      child: Center(
        child: Text(
          l10n.titleDisplay,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 예측 버튼들
  Widget _buildPredictionButtons(AppLocalizations l10n) {
    return Row(
      children: [
        // 승패 버튼
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildOutlinedButton(l10n.winLose),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // 1 버튼
        Expanded(
          child: Column(
            children: [
              Text(
                l10n.win1Lose,
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
              _buildOutlinedButton(l10n.handi),
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
}
