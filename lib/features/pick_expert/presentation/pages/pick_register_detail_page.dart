import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 예측 타입
enum PredictionType {
  winDrawLose, // 승무패
  handicap, // 핸디캡
  underOver, // 언더/오버
}

/// 승무패 선택
enum WinDrawLoseSelection {
  homeWin, // 홈승
  draw, // 무승부
  awayWin, // 홈패(원정승)
}

/// 핸디캡 선택
enum HandicapSelection {
  homeWin, // 홈승
  draw, // 무승부
  awayWin, // 홈패(원정승)
}

/// 언더/오버 선택
enum UnderOverSelection {
  under, // 언더
  over, // 오버
}

/// 무료픽 등록 상세 페이지
class PickRegisterDetailPage extends StatefulWidget {
  const PickRegisterDetailPage({super.key});

  @override
  State<PickRegisterDetailPage> createState() => _PickRegisterDetailPageState();
}

class _PickRegisterDetailPageState extends State<PickRegisterDetailPage> {
  // 예측 선택 상태
  WinDrawLoseSelection? _winDrawLoseSelection;
  HandicapSelection? _handicapSelection;
  UnderOverSelection? _underOverSelection;

  // 입력 컨트롤러
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _analysisController = TextEditingController();

  // 샘플 데이터
  final String _matchDate = '2025.07.11 15:30';
  String _category(AppLocalizations l10n) => '${l10n.soccer} / EPL';
  String _homeTeam(AppLocalizations l10n) => l10n.sampleTeamManUtd;
  String _awayTeam(AppLocalizations l10n) => l10n.sampleTeamLiverpool;
  final double _handicapValue = 1.5;
  final double _underOverValue = 2.5;

  @override
  void dispose() {
    _titleController.dispose();
    _analysisController.dispose();
    super.dispose();
  }

  /// 등록 가능 여부
  bool get _canRegister {
    return _winDrawLoseSelection != null &&
        _handicapSelection != null &&
        _underOverSelection != null &&
        _titleController.text.isNotEmpty &&
        _analysisController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(l10n),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 경기선택 영역
                    _buildMatchSelectionHeader(l10n),
                    const SizedBox(height: 16),
                    // 안내 문구
                    _buildInfoBanner(l10n),
                    const SizedBox(height: 16),
                    // 경기 정보 테이블
                    _buildMatchInfoTable(l10n),
                    const SizedBox(height: 24),
                    // 예측 선택 테이블
                    _buildPredictionTable(l10n),
                    const SizedBox(height: 24),
                    // 타이틀 입력
                    _buildTitleInput(l10n),
                    const SizedBox(height: 16),
                    // 분석정보 입력
                    _buildAnalysisInput(l10n),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // 하단 버튼
            _buildBottomButtons(l10n),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(AppLocalizations l10n) {
    return AppHeader.withTitle(
      title: l10n.freePickRegister,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 경기선택 헤더
  Widget _buildMatchSelectionHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.matchSelection,
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          GestureDetector(
            onTap: () {
              // 경기 변경
              Navigator.of(context).pop();
            },
            child: Container(
              width: 72,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderNormal),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  l10n.selectMatch,
                  style: AppTextStyles.label1Medium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 안내 문구 배너
  Widget _buildInfoBanner(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.primaryBackground,
      child: Center(
        child: Text(
          l10n.matchNotice,
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 경기 정보 테이블
  Widget _buildMatchInfoTable(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderNormal),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // 경기일시
            _buildInfoRow(
              label: l10n.matchDateTime,
              value: _matchDate,
              isFirst: true,
            ),
            // 구분선
            Container(
              height: 1,
              color: AppColors.borderNormal,
            ),
            // 카테고리
            _buildInfoRow(
              label: l10n.category,
              value: _category(l10n),
            ),
            // 구분선
            Container(
              height: 1,
              color: AppColors.borderNormal,
            ),
            // 팀 정보
            _buildInfoRow(
              label: l10n.teamInfo,
              value: '${_homeTeam(l10n)} VS ${_awayTeam(l10n)}',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  /// 정보 행
  Widget _buildInfoRow({
    required String label,
    required String value,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(8) : Radius.zero,
          topRight: isFirst ? const Radius.circular(8) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(8) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(8) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          // 라벨
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: AppTextStyles.label1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          // 값
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 예측 선택 테이블
  Widget _buildPredictionTable(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderNormal),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // 승무패
            _buildPredictionRow(
              label: l10n.winDrawLose,
              options: [l10n.homeWin, l10n.drawMatch, l10n.homeLose],
              selectedIndex: _winDrawLoseSelection?.index,
              onSelect: (index) {
                setState(() {
                  _winDrawLoseSelection = WinDrawLoseSelection.values[index];
                });
              },
              isFirst: true,
            ),
            // 구분선
            Container(
              height: 1,
              color: AppColors.borderNormal,
            ),
            // 핸디캡
            _buildPredictionRow(
              label: '${l10n.handicap}($_handicapValue)',
              options: [l10n.homeWin, l10n.drawMatch, l10n.homeLose],
              selectedIndex: _handicapSelection?.index,
              onSelect: (index) {
                setState(() {
                  _handicapSelection = HandicapSelection.values[index];
                });
              },
            ),
            // 구분선
            Container(
              height: 1,
              color: AppColors.borderNormal,
            ),
            // 언더/오버
            _buildPredictionRow(
              label: '${l10n.underOver}($_underOverValue)',
              options: [l10n.under, l10n.over],
              selectedIndex: _underOverSelection?.index,
              onSelect: (index) {
                setState(() {
                  _underOverSelection = UnderOverSelection.values[index];
                });
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  /// 예측 선택 행
  Widget _buildPredictionRow({
    required String label,
    required List<String> options,
    required int? selectedIndex,
    required Function(int) onSelect,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(8) : Radius.zero,
          topRight: isFirst ? const Radius.circular(8) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(8) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(8) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          // 라벨
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.label1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          // 옵션들
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => onSelect(index),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 라디오 버튼
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryFigma
                                : AppColors.borderNormal,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryFigma,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 4),
                      // 옵션 텍스트
                      Text(
                        option,
                        style: AppTextStyles.label1Medium.copyWith(
                          color: isSelected
                              ? AppColors.labelNormal
                              : AppColors.labelNeutral,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 타이틀 입력
  Widget _buildTitleInput(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.titleLabel,
            style: AppTextStyles.label1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: l10n.enterTitle,
                hintStyle: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  /// 분석정보 입력
  Widget _buildAnalysisInput(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.analysisInfo,
            style: AppTextStyles.label1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderNormal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _analysisController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: l10n.enterAnalysis,
                hintStyle: AppTextStyles.body2NormalMedium.copyWith(
                  color: AppColors.labelAlternative,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: AppTextStyles.body2NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  /// 하단 버튼
  Widget _buildBottomButtons(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 닫기 버튼
          Container(
            width: 121,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: Text(
                  l10n.close,
                  style: AppTextStyles.body1NormalMedium.copyWith(
                    color: AppColors.labelNeutral,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 등록하기 버튼
          Expanded(
            child: GestureDetector(
              onTap: _canRegister
                  ? () {
                      // TODO: 등록 처리
                      _showRegistrationComplete();
                    }
                  : null,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: _canRegister
                      ? AppColors.primaryFigma
                      : AppColors.containerDisabled,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    l10n.register,
                    style: AppTextStyles.body1NormalBold.copyWith(
                      color: _canRegister
                          ? AppColors.white
                          : AppColors.labelDisabled,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 등록 완료 다이얼로그
  void _showRegistrationComplete() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            l10n.registrationComplete,
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          content: Text(
            l10n.freePickRegistered,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.of(context).pop(); // 상세 페이지 닫기
                Navigator.of(context).pop(); // 등록 페이지 닫기
              },
              child: Text(
                l10n.confirm,
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.primaryFigma,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
