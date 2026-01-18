import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';

/// 라인업 스포츠 타입
enum LineupSportType {
  /// 축구
  soccer,

  /// 농구
  basketball,

  /// 야구
  baseball,
}

/// 라인업 팀 타입
enum LineupTeamType {
  /// 홈팀
  home,

  /// 원정팀
  away,
}

/// 라인업 페이지
class LineupPage extends StatefulWidget {
  const LineupPage({
    super.key,
    this.sportType = LineupSportType.soccer,
    this.initialTeam = LineupTeamType.home,
  });

  /// 스포츠 타입
  final LineupSportType sportType;

  /// 초기 선택 팀
  final LineupTeamType initialTeam;

  @override
  State<LineupPage> createState() => _LineupPageState();
}

class _LineupPageState extends State<LineupPage> {
  int _selectedMainTabIndex = 2; // 라인업 탭 선택
  late LineupTeamType _selectedTeam;

  final List<String> _mainTabs = ['라이브', '차트', '라인업', '예측게임', '픽전문가'];

  @override
  void initState() {
    super.initState();
    _selectedTeam = widget.initialTeam;
  }

  /// 메인 탭 네비게이션 처리
  void _navigateToMainTab(int index) {
    switch (index) {
      case 0: // 라이브
        Navigator.of(context).pushReplacementNamed('/live-match-detail');
        break;
      case 1: // 차트
        Navigator.of(context).pushReplacementNamed('/chart-comparison');
        break;
      case 2: // 라인업 (현재 페이지)
        setState(() {
          _selectedMainTabIndex = index;
        });
        break;
      case 3: // 예측게임
        Navigator.of(context).pushReplacementNamed('/prediction-game');
        break;
      case 4: // 픽전문가 (추후 구현)
        setState(() {
          _selectedMainTabIndex = index;
        });
        // TODO: Navigator.of(context).pushReplacementNamed('/pick-expert');
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
            // 메인 탭 토글
            _buildMainTabToggle(),
            const SizedBox(height: 8),
            // 서브 탭 (홈팀/원정팀)
            _buildTeamToggle(),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
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
          type: AppHeaderButtonType.sparkle,
          onPressed: () {
            // TODO: AI
          },
        ),
      ],
    );
  }

  /// 메인 5단 탭 토글
  Widget _buildMainTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.containerNeutral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: _mainTabs.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = index == _selectedMainTabIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToMainTab(index);
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

  /// 팀 토글 (홈팀/원정팀)
  Widget _buildTeamToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: LineupTeamType.values.map((team) {
          final isSelected = team == _selectedTeam;
          final label = team == LineupTeamType.home ? '홈팀 라인업' : '원정팀 라인업';

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTeam = team;
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primaryFigma : AppColors.borderNormal,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: isSelected
                        ? AppTextStyles.body1NormalBold.copyWith(color: AppColors.primaryFigma)
                        : AppTextStyles.body1NormalMedium.copyWith(color: AppColors.labelNeutral),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 컨텐츠
  Widget _buildContent() {
    switch (widget.sportType) {
      case LineupSportType.soccer:
        return _buildSoccerContent();
      case LineupSportType.basketball:
        return _buildBasketballContent();
      case LineupSportType.baseball:
        return _buildBaseballContent();
    }
  }

  /// 축구 라인업 컨텐츠
  Widget _buildSoccerContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // 팀 정보 헤더
        _buildTeamInfoHeader(
          teamName: '팀명',
          formation: '4-2-3-1',
        ),
        const SizedBox(height: 16),
        // 축구 필드
        _buildSoccerField(),
        const SizedBox(height: 24),
        // 선수 목록 테이블
        _buildSoccerPlayerTable(),
        const SizedBox(height: 32),
      ],
    );
  }

  /// 팀 정보 헤더
  Widget _buildTeamInfoHeader({
    required String teamName,
    required String formation,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 팀 로고
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.sports_soccer,
                size: 20,
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 팀명 + 포메이션
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamName,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              Text(
                '[$formation]',
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 축구 필드
  Widget _buildSoccerField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50), // 녹색 필드
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 필드 라인
          _buildFieldLines(),
          // 선수 배치 (4-2-3-1)
          // 공격수 (1명)
          _buildPlayerPosition(
            top: 30,
            left: null,
            centerX: true,
            number: 12,
            name: '선수명',
          ),
          // 미드필더 (3명)
          _buildPlayerPosition(top: 120, left: 30, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 120, left: null, centerX: true, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 120, right: 30, number: 12, name: '선수명'),
          // 수비형 미드필더 (2명)
          _buildPlayerPosition(top: 200, left: 60, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 200, right: 60, number: 12, name: '선수명'),
          // 수비수 (4명)
          _buildPlayerPosition(top: 280, left: 20, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 280, left: 90, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 280, right: 90, number: 12, name: '선수명'),
          _buildPlayerPosition(top: 280, right: 20, number: 12, name: '선수명'),
          // 골키퍼 (1명)
          _buildPlayerPosition(
            top: 350,
            left: null,
            centerX: true,
            number: 12,
            name: '선수명',
            isGoalkeeper: true,
          ),
        ],
      ),
    );
  }

  /// 필드 라인
  Widget _buildFieldLines() {
    return CustomPaint(
      size: const Size(double.infinity, 400),
      painter: SoccerFieldPainter(),
    );
  }

  /// 선수 포지션 위젯
  Widget _buildPlayerPosition({
    required double top,
    double? left,
    double? right,
    bool centerX = false,
    required int number,
    required String name,
    bool isGoalkeeper = false,
  }) {
    Widget player = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/player-detail'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 유니폼 아이콘
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isGoalkeeper ? const Color(0xFFFFEB3B) : const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$number',
                style: AppTextStyles.label1NormalBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // 선수명
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: AppTextStyles.caption2Medium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (centerX) {
      return Positioned(
        top: top,
        left: 0,
        right: 0,
        child: Center(child: player),
      );
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: player,
    );
  }

  /// 축구 선수 테이블
  Widget _buildSoccerPlayerTable() {
    return Column(
      children: [
        // 테이블 헤더
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderNormal),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '이름',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '포지션',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '백넘버',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '신장/몸무게',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 테이블 행들
        _buildSoccerPlayerRow(name: '이름', position: 'GK', number: 5, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'DF', number: 12, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'DF', number: 1, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'DF', number: 3, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'DF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'MF', number: 4, height: '183cm / 85kg'),
        _buildSoccerPlayerRow(name: '이름', position: 'FW', number: 4, height: '183cm / 85kg'),
      ],
    );
  }

  /// 축구 선수 테이블 행
  Widget _buildSoccerPlayerRow({
    required String name,
    required String position,
    required int number,
    required String height,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              position,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$number',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              height,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 농구 라인업 컨텐츠
  Widget _buildBasketballContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // 팀 정보 헤더 (포메이션 없음)
        _buildTeamInfoHeaderSimple(teamName: '팀명'),
        const SizedBox(height: 16),
        // 농구 코트
        _buildBasketballCourt(),
        const SizedBox(height: 24),
        // 선수 목록 테이블
        _buildBasketballPlayerTable(),
        const SizedBox(height: 32),
      ],
    );
  }

  /// 팀 정보 헤더 (포메이션 없음)
  Widget _buildTeamInfoHeaderSimple({required String teamName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 팀 로고
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.containerNormal,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.sports_basketball,
                size: 20,
                color: AppColors.labelAlternative,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 팀명
          Text(
            teamName,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
        ],
      ),
    );
  }

  /// 농구 코트
  Widget _buildBasketballCourt() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFFE8B86D), // 오렌지/탄 색상 코트
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 코트 라인
          CustomPaint(
            size: const Size(double.infinity, 320),
            painter: BasketballCourtPainter(),
          ),
          // 선수 배치 (5명)
          // 센터 (C) - 상단 중앙
          _buildBasketballPlayerPosition(
            top: 40,
            centerX: true,
            number: 12,
            positionLabel: 'C',
            name: '선수명',
          ),
          // 가드 (G) - 좌측
          _buildBasketballPlayerPosition(
            top: 120,
            left: 20,
            number: 12,
            positionLabel: 'G',
            name: '선수명',
          ),
          // 가드 (G) - 우측
          _buildBasketballPlayerPosition(
            top: 120,
            right: 20,
            number: 12,
            positionLabel: 'G',
            name: '선수명',
          ),
          // 포워드 (F) - 좌측 하단
          _buildBasketballPlayerPosition(
            top: 220,
            left: 60,
            number: 12,
            positionLabel: 'F',
            name: '선수명',
          ),
          // 포워드 (F) - 우측 하단
          _buildBasketballPlayerPosition(
            top: 220,
            right: 60,
            number: 12,
            positionLabel: 'F',
            name: '선수명',
          ),
        ],
      ),
    );
  }

  /// 농구 선수 포지션 위젯
  Widget _buildBasketballPlayerPosition({
    required double top,
    double? left,
    double? right,
    bool centerX = false,
    required int number,
    required String positionLabel,
    required String name,
  }) {
    Widget player = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 유니폼 아이콘
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '$number',
              style: AppTextStyles.label1NormalBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // 포지션 + 선수명
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$positionLabel.$name',
            style: AppTextStyles.caption2Medium.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );

    if (centerX) {
      return Positioned(
        top: top,
        left: 0,
        right: 0,
        child: Center(child: player),
      );
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: player,
    );
  }

  /// 농구 선수 테이블
  Widget _buildBasketballPlayerTable() {
    return Column(
      children: [
        // 테이블 헤더
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderNormal),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '이름',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '포지션',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '백넘버',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '신장/몸무게',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 테이블 행들
        _buildPlayerRow(name: '이름', position: 'G', number: 5, height: '183cm / 85kg'),
        _buildPlayerRow(name: '이름', position: 'G', number: 12, height: '183cm / 85kg'),
        _buildPlayerRow(name: '이름', position: 'F', number: 1, height: '183cm / 85kg'),
        _buildPlayerRow(name: '이름', position: 'F', number: 3, height: '183cm / 85kg'),
        _buildPlayerRow(name: '이름', position: 'C', number: 4, height: '183cm / 85kg'),
      ],
    );
  }

  /// 공통 선수 테이블 행
  Widget _buildPlayerRow({
    required String name,
    required String position,
    required int number,
    required String height,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/player-detail'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderNormal),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ),
            Expanded(
              child: Text(
                position,
                textAlign: TextAlign.center,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '$number',
                textAlign: TextAlign.center,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                height,
                textAlign: TextAlign.center,
                style: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 야구 라인업 컨텐츠 (추후 구현)
  Widget _buildBaseballContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // 팀 정보 헤더 (포메이션 없음)
        _buildTeamInfoHeaderSimple(teamName: '팀명'),
        const SizedBox(height: 16),
        // 야구 다이아몬드
        _buildBaseballDiamond(),
        const SizedBox(height: 24),
        // 선수 목록 테이블
        _buildBaseballPlayerTable(),
        const SizedBox(height: 32),
      ],
    );
  }

  /// 야구 다이아몬드
  Widget _buildBaseballDiamond() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50), // 녹색 외야
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 다이아몬드 필드
          CustomPaint(
            size: const Size(double.infinity, 320),
            painter: BaseballDiamondPainter(),
          ),
          // 외야수 (3명)
          // 좌익수
          _buildBaseballPlayerPosition(
            top: 30,
            left: 30,
            number: 12,
            name: '선수명',
          ),
          // 중견수
          _buildBaseballPlayerPosition(
            top: 20,
            centerX: true,
            number: 12,
            name: '선수명',
          ),
          // 우익수
          _buildBaseballPlayerPosition(
            top: 30,
            right: 30,
            number: 12,
            name: '선수명',
          ),
          // 내야수 (4명)
          // 3루수
          _buildBaseballPlayerPosition(
            top: 100,
            left: 20,
            number: 12,
            name: '선수명',
          ),
          // 유격수
          _buildBaseballPlayerPosition(
            top: 110,
            left: 80,
            number: 12,
            name: '선수명',
          ),
          // 2루수
          _buildBaseballPlayerPosition(
            top: 110,
            right: 80,
            number: 12,
            name: '선수명',
          ),
          // 1루수
          _buildBaseballPlayerPosition(
            top: 100,
            right: 20,
            number: 12,
            name: '선수명',
          ),
          // 투수
          _buildBaseballPlayerPosition(
            top: 170,
            centerX: true,
            number: 12,
            name: '선수명',
          ),
          // 포수
          _buildBaseballPlayerPosition(
            top: 260,
            centerX: true,
            number: 12,
            name: '선수명',
          ),
        ],
      ),
    );
  }

  /// 야구 선수 포지션 위젯
  Widget _buildBaseballPlayerPosition({
    required double top,
    double? left,
    double? right,
    bool centerX = false,
    required int number,
    required String name,
  }) {
    Widget player = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 유니폼 아이콘
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '$number',
              style: AppTextStyles.caption1Bold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        // 선수명
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: AppTextStyles.caption2Medium.copyWith(
              color: AppColors.white,
              fontSize: 9,
            ),
          ),
        ),
      ],
    );

    if (centerX) {
      return Positioned(
        top: top,
        left: 0,
        right: 0,
        child: Center(child: player),
      );
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: player,
    );
  }

  /// 야구 선수 테이블
  Widget _buildBaseballPlayerTable() {
    return Column(
      children: [
        // 테이블 헤더
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderNormal),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '이름(백넘버)',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '포지션',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '시즌성적(타율)',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption2Medium.copyWith(
                    color: AppColors.labelAlternative,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 테이블 행들
        _buildBaseballPlayerRow(order: '1번', name: '이름(번호)', position: '유격수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '2번', name: '이름(번호)', position: '2루수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '3번', name: '이름(번호)', position: '3루수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '4번', name: '이름(번호)', position: '1루수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '5번', name: '이름(번호)', position: '중견수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '6번', name: '이름(번호)', position: '우익수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '7번', name: '이름(번호)', position: '포수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '8번', name: '이름(번호)', position: '좌익수', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '9번', name: '이름(번호)', position: '지명타자', stats: '183cm / 85kg'),
        _buildBaseballPlayerRow(order: '선발', name: '이름(번호)', position: '투수', stats: '183cm / 85kg'),
      ],
    );
  }

  /// 야구 선수 테이블 행
  Widget _buildBaseballPlayerRow({
    required String order,
    required String name,
    required String position,
    required String stats,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              order,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              position,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              stats,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// 축구 필드 라인 페인터
class SoccerFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // 외곽선
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );

    // 중앙선
    canvas.drawLine(
      Offset(10, size.height / 2),
      Offset(size.width - 10, size.height / 2),
      paint,
    );

    // 중앙 원
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      50,
      paint,
    );

    // 골대 영역 (상단)
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 60, 10, 120, 40),
      paint,
    );

    // 골대 영역 (하단)
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 60, size.height - 50, 120, 40),
      paint,
    );

    // 페널티 박스 (상단)
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 80, 10, 160, 60),
      paint,
    );

    // 페널티 박스 (하단)
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 80, size.height - 70, 160, 60),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 야구 다이아몬드 페인터
class BaseballDiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height * 0.6;

    // 내야 (다이아몬드) - 황토색
    final infieldPaint = Paint()
      ..color = const Color(0xFFD4A574)
      ..style = PaintingStyle.fill;

    final diamondPath = Path();
    diamondPath.moveTo(centerX, centerY - 100); // 2루
    diamondPath.lineTo(centerX + 80, centerY); // 1루
    diamondPath.lineTo(centerX, centerY + 80); // 홈
    diamondPath.lineTo(centerX - 80, centerY); // 3루
    diamondPath.close();
    canvas.drawPath(diamondPath, infieldPaint);

    // 베이스 라인
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(diamondPath, linePaint);

    // 투수 마운드
    canvas.drawCircle(
      Offset(centerX, centerY - 20),
      15,
      infieldPaint,
    );

    // 홈 플레이트 영역
    final homePaint = Paint()
      ..color = const Color(0xFFD4A574)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 80),
        width: 40,
        height: 30,
      ),
      homePaint,
    );

    // 베이스 (흰색 사각형)
    final basePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 1루 베이스
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 8, height: 8),
      basePaint,
    );
    // 2루 베이스
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 8, height: 8),
      basePaint,
    );
    // 3루 베이스
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX - 80, centerY), width: 8, height: 8),
      basePaint,
    );
    // 홈 플레이트
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 80), width: 10, height: 10),
      basePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 농구 코트 라인 페인터
class BasketballCourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;

    // 외곽선
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );

    // 3점 라인 (반원)
    final threePtPath = Path();
    threePtPath.moveTo(30, size.height - 10);
    threePtPath.quadraticBezierTo(
      centerX,
      60,
      size.width - 30,
      size.height - 10,
    );
    canvas.drawPath(threePtPath, paint);

    // 페인트 영역 (키 영역)
    canvas.drawRect(
      Rect.fromLTWH(centerX - 60, size.height - 130, 120, 120),
      paint,
    );

    // 자유투 라인 원
    canvas.drawCircle(
      Offset(centerX, size.height - 130),
      40,
      paint,
    );

    // 골대 (림)
    canvas.drawRect(
      Rect.fromLTWH(centerX - 20, size.height - 30, 40, 10),
      paint,
    );

    // 백보드
    canvas.drawLine(
      Offset(centerX - 30, size.height - 20),
      Offset(centerX + 30, size.height - 20),
      paint,
    );

    // 점선 (하프코트 라인 - 상단)
    final dashPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // 점선으로 하프코트 구분
    double dashWidth = 8;
    double dashSpace = 4;
    double startX = 10;
    while (startX < size.width - 10) {
      canvas.drawLine(
        Offset(startX, 10),
        Offset(startX + dashWidth, 10),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
