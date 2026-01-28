import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_navigation_bar.dart';
import '../../../../shared/widgets/app_toggle.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../l10n/app_localizations.dart';

/// 픽 유형
enum PickType { paid, free }

/// 픽전문가 페이지
class PickExpertPage extends StatefulWidget {
  const PickExpertPage({
    super.key,
    this.initialPickType = PickType.free,
    this.showBottomNav = true,
  });

  final PickType initialPickType;

  /// 하단 네비게이션 표시 여부
  final bool showBottomNav;

  @override
  State<PickExpertPage> createState() => _PickExpertPageState();
}

class _PickExpertPageState extends State<PickExpertPage> {
  late int _toggleIndex;
  int _sportCategoryIndex = 0;
  int _subCategoryIndex = 0;
  final int _bottomNavIndex = 1; // 픽전문가 탭

  List<String> _getSportCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, l10n.esports, l10n.soccer, l10n.baseball, l10n.basketball, l10n.volleyball, l10n.hockey, l10n.americanFootball];
  }
  List<String> _getSubCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, 'Category1', 'Category2', 'Category3', 'Category4'];
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _toggleIndex = widget.initialPickType == PickType.paid ? 0 : 1;
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            // 스크롤 가능한 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // 유료픽/무료픽 토글
                    _buildToggle(),
                    const SizedBox(height: 16),
                    // 스포츠 카테고리 탭
                    _buildSportCategoryTabs(),
                    const SizedBox(height: 8),
                    // 서브 카테고리 칩
                    _buildSubCategoryChips(),
                    const SizedBox(height: 16),
                    // 검색창
                    _buildSearchInput(),
                    const SizedBox(height: 16),
                    // 픽 카드 리스트
                    _buildPickCardList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNav
          ? AppNavigationBar(
              currentIndex: _bottomNavIndex,
              onTap: (index) {
                if (index == _bottomNavIndex) return;
                switch (index) {
                  case 0:
                    Navigator.of(context).pushReplacementNamed('/main');
                    break;
                  case 1:
                    Navigator.of(context).pushReplacementNamed('/main/pick-expert');
                    break;
                  case 2:
                    Navigator.of(context).pushReplacementNamed('/main/community');
                    break;
                  case 3:
                    Navigator.of(context).pushReplacementNamed('/main/ranking');
                    break;
                  case 4:
                    Navigator.of(context).pushReplacementNamed('/main/my');
                    break;
                }
              },
            )
          : null,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.pickExpert,
            style: AppTextStyles.h3Bold.copyWith(
              color: AppColors.labelStrong,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/my-pick');
            },
            child: Text(
              l10n.myPick,
              style: AppTextStyles.body1NormalBold.copyWith(
                color: AppColors.primaryFigma,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 현재 픽 타입이 유료인지 확인
  bool get _isPaidPick => _toggleIndex == 0;

  /// 유료픽/무료픽 토글
  Widget _buildToggle() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppToggle(
        labels: [l10n.paidPick, l10n.freePick],
        selectedIndex: _toggleIndex,
        onChanged: (index) {
          setState(() {
            _toggleIndex = index;
          });
        },
        size: AppToggleSize.large,
        colorType: AppToggleColorType.active,
      ),
    );
  }

  /// 스포츠 카테고리 탭
  Widget _buildSportCategoryTabs() {
    final sportCategories = _getSportCategories(context);
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: sportCategories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _sportCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _sportCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  sportCategories[index],
                  style: isSelected
                      ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.primaryFigma)
                      : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelAlternative),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 서브 카테고리 칩
  Widget _buildSubCategoryChips() {
    final subCategories = _getSubCategories(context);
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _subCategoryIndex;
          return Padding(
            padding: EdgeInsets.only(right: index < subCategories.length - 1 ? 4 : 0),
            child: Chips(
              label: subCategories[index],
              status: isSelected ? ChipStatus.active : ChipStatus.defaultStatus,
              onTap: () {
                setState(() {
                  _subCategoryIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  /// 검색 입력창
  Widget _buildSearchInput() {
    final l10n = AppLocalizations.of(context)!;
    final hintText = _isPaidPick
        ? l10n.searchHintExpert
        : l10n.searchHintNickname;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderNormal),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                AppIcons.search,
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
    );
  }

  /// 픽 카드 리스트
  Widget _buildPickCardList() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildPickCard(
            expertName: l10n.expertName,
            expertRecord: '최근 NN게임 NN승 NN패',
            expertSpecialty: _isPaidPick ? '주종목 : 야구 (일간스포츠 베팅킥)' : null,
            rating: 'N.NNN',
            viewCount: 'NNN',
            purchaseCount: 'NNN',
            price: 'n,nnn P',
            homeTeam: l10n.teamName,
            awayTeam: l10n.teamName,
            matchDate: '7/11 (금)',
            matchTime: '15 : 30',
            title: l10n.titleDisplay,
          ),
          const SizedBox(height: 16),
          _buildPickCard(
            expertName: l10n.expertName,
            expertRecord: '최근 NN게임 NN승 NN패',
            expertSpecialty: _isPaidPick ? '주종목 : 야구 (일간스포츠 베팅킥)' : null,
            rating: 'N.NNN',
            viewCount: 'NNN',
            purchaseCount: 'NNN',
            price: 'n,nnn P',
            homeTeam: l10n.teamName,
            awayTeam: l10n.teamName,
            matchDate: '7/11 (금)',
            matchTime: '15 : 30',
            title: l10n.titleDisplay,
          ),
        ],
      ),
    );
  }

  /// 픽 카드
  Widget _buildPickCard({
    required String expertName,
    required String expertRecord,
    String? expertSpecialty,
    required String rating,
    required String viewCount,
    String? purchaseCount,
    String? price,
    required String homeTeam,
    required String awayTeam,
    required String matchDate,
    required String matchTime,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(_isPaidPick ? '/pick-detail/paid' : '/pick-detail');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderNormal),
        ),
        child: Column(
          children: [
            // 전문가 정보
            _buildExpertInfo(
              name: expertName,
              record: expertRecord,
              specialty: expertSpecialty,
              rating: rating,
              viewCount: viewCount,
              purchaseCount: purchaseCount,
              price: price,
            ),
            const SizedBox(height: 16),
            // 구분선
            Container(
              height: 1,
              color: AppColors.borderNormal,
            ),
            const SizedBox(height: 16),
            // 경기 정보
            _buildMatchInfo(
              homeTeam: homeTeam,
              awayTeam: awayTeam,
              matchDate: matchDate,
              matchTime: matchTime,
            ),
            const SizedBox(height: 16),
            // 타이틀
            _buildTitleBar(title: title),
            const SizedBox(height: 16),
            // 예측 버튼들
            _buildPredictionButtons(),
          ],
        ),
      ),
    );
  }

  /// 전문가 정보
  Widget _buildExpertInfo({
    required String name,
    required String record,
    String? specialty,
    required String rating,
    required String viewCount,
    String? purchaseCount,
    String? price,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 전문가 이미지
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.containerNormal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: AppColors.labelAlternative,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // 이름 & 전적
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.body1NormalBold.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record,
                    style: AppTextStyles.caption1Medium.copyWith(
                      color: AppColors.labelNeutral,
                    ),
                  ),
                  if (specialty != null) ...[
                    Text(
                      specialty,
                      style: AppTextStyles.caption1Medium.copyWith(
                        color: AppColors.labelNeutral,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 알림 & 평점
            Column(
              children: [
                SvgPicture.asset(
                  AppIcons.bell,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.labelAlternative,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rating,
                  style: AppTextStyles.caption1Medium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 유료픽: 구매/가격 버튼, 무료픽: 조회수
        if (_isPaidPick && purchaseCount != null && price != null)
          _buildPurchaseButtons(purchaseCount: purchaseCount, price: price)
        else
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '조회수 $viewCount',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ),
      ],
    );
  }

  /// 구매/가격 버튼 (유료픽 전용)
  Widget _buildPurchaseButtons({
    required String purchaseCount,
    required String price,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '구매 $purchaseCount',
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                price,
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

  /// 경기 정보
  Widget _buildMatchInfo({
    required String homeTeam,
    required String awayTeam,
    required String matchDate,
    required String matchTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 홈팀
        _buildTeamItem(teamName: homeTeam),
        const SizedBox(width: 22),
        // 날짜/시간
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
                matchDate,
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              Text(
                matchTime,
                style: AppTextStyles.label1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 22),
        // 원정팀
        _buildTeamItem(teamName: awayTeam),
      ],
    );
  }

  /// 팀 아이템
  Widget _buildTeamItem({required String teamName}) {
    return Column(
      children: [
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
        Text(
          teamName,
          style: AppTextStyles.body1NormalBold.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ],
    );
  }

  /// 타이틀 바
  Widget _buildTitleBar({required String title}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 예측 버튼들
  Widget _buildPredictionButtons() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        // 승패 버튼
        _buildPredictionButtonWithLabel(
          label: l10n.winLose,
          topLabel: '승 N패',
          topLabelColor: AppColors.labelNeutral,
        ),
        const SizedBox(width: 6),
        // 1 버튼
        _buildPredictionButtonWithLabel(
          label: '1',
          topLabel: '+N.N',
          topLabelColor: AppColors.negative,
        ),
        const SizedBox(width: 6),
        // 핸디 버튼
        _buildPredictionButtonWithLabel(
          label: l10n.handi,
          topLabel: '+N.N',
          topLabelColor: AppColors.negative,
        ),
        const SizedBox(width: 6),
        // U/O 버튼
        _buildPredictionButtonWithLabel(
          label: 'U/O',
          topLabel: 'N.N',
          topLabelColor: AppColors.negative,
        ),
      ],
    );
  }

  /// 예측 버튼 (라벨 포함)
  Widget _buildPredictionButtonWithLabel({
    required String label,
    required String topLabel,
    required Color topLabelColor,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 상단 라벨
          SizedBox(
            height: 16,
            child: Text(
              topLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption2Medium.copyWith(
                color: topLabelColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // 버튼
          Container(
            height: 36,
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
          ),
        ],
      ),
    );
  }

  /// 플로팅 액션 버튼
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      heroTag: 'pick_expert_fab',
      onPressed: () {
        Navigator.of(context).pushNamed('/pick-register');
      },
      backgroundColor: AppColors.primaryFigma,
      shape: const CircleBorder(),
      child: SvgPicture.asset(
        AppIcons.plus,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
