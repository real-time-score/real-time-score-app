import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../l10n/app_localizations.dart';

/// GIF 적용 케이스 페이지
class GifCasePage extends StatefulWidget {
  const GifCasePage({super.key});

  @override
  State<GifCasePage> createState() => _GifCasePageState();
}

class _GifCasePageState extends State<GifCasePage> {
  int _selectedTab = 0;

  List<String> _getTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.liveTab, l10n.chart, l10n.lineup, l10n.predictionGame, l10n.pickExpert];
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
            // 탭바
            _buildTabBar(),
            // 운영자 등록글 배너
            _buildAdminBanner(),
            // 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 예측 결과
                    _buildPredictionResult(),
                    // 배당률 테이블
                    _buildOddsTable(),
                    // GIF 표시 영역
                    _buildGifArea(),
                    // 스코어보드
                    _buildScoreboard(),
                    // 채팅 메시지
                    _buildChatMessages(),
                  ],
                ),
              ),
            ),
            // 응원 메시지 입력바
            _buildMessageInputBar(),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 뒤로가기 버튼
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
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
          // 우측 아이콘
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              child: Icon(
                Icons.push_pin_outlined,
                size: 24,
                color: AppColors.primaryFigma,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 탭바
  Widget _buildTabBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _getTabs(context).asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedTab;

          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.labelNormal : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: isSelected
                    ? null
                    : Border.all(color: AppColors.borderNormal),
              ),
              child: Text(
                tab,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.labelNeutral,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 운영자 등록글 배너
  Widget _buildAdminBanner() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppColors.containerNormal,
      child: Center(
        child: Text(
          l10n.adminNotice,
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.primaryFigma,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 예측 결과
  Widget _buildPredictionResult() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '[예측결과] 팀명 NN% 승 / 핸패 / 오버',
        style: AppTextStyles.body2NormalMedium.copyWith(
          color: AppColors.labelNeutral,
        ),
      ),
    );
  }

  /// 배당률 테이블
  Widget _buildOddsTable() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _buildOddsRow('N.NN', '-', 'N.NN', isHome: true),
          Container(height: 1, color: AppColors.borderNormal),
          _buildOddsRow('N.NN', '-', 'N.NN', isHome: true),
        ],
      ),
    );
  }

  Widget _buildOddsRow(String home, String middle, String away,
      {required bool isHome}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          // 홈
          Expanded(
            child: Row(
              children: [
                Icon(Icons.arrow_drop_up, size: 16, color: Colors.red),
                Text(
                  home,
                  style: AppTextStyles.body2NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ],
            ),
          ),
          // 중앙
          Text(
            middle,
            style: AppTextStyles.body2NormalMedium.copyWith(
              color: AppColors.labelNeutral,
            ),
          ),
          // 어웨이
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_drop_down, size: 16, color: Colors.green),
                Text(
                  away,
                  style: AppTextStyles.body2NormalMedium.copyWith(
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

  /// GIF 표시 영역
  Widget _buildGifArea() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF808080),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gif_box_outlined,
              size: 48,
              color: AppColors.white,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.gifAnimationArea,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.highlightGolScenes,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 스코어보드
  Widget _buildScoreboard() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 홈팀
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.containerNormal,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.teamName,
                style: AppTextStyles.caption1Medium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // 스코어
          Text(
            '1',
            style: AppTextStyles.heading1Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(width: 16),
          // 이닝/시간
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.containerNormal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '8${l10n.inningTop}',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelNeutral,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 스코어
          Text(
            '5',
            style: AppTextStyles.heading1Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(width: 24),
          // 어웨이팀
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.containerNormal,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.teamName,
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

  /// 채팅 메시지
  Widget _buildChatMessages() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildChatMessage(
            nickname: 'User',
            message: l10n.messageDisplay,
            time: 'PM hh:mm',
            isNewbie: true,
            l10n: l10n,
          ),
          const SizedBox(height: 12),
          _buildChatMessage(
            nickname: 'User',
            message: l10n.messageDisplay,
            time: 'PM hh:mm',
            isNewbie: true,
            l10n: l10n,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildChatMessage({
    required String nickname,
    required String message,
    required String time,
    bool isNewbie = false,
    required AppLocalizations l10n,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 프로필 이미지
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.containerNormal,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Icon(
              Icons.person,
              size: 24,
              color: AppColors.labelAlternative,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 메시지 내용
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닉네임 + 뱃지
              Row(
                children: [
                  Text(
                    nickname,
                    style: AppTextStyles.body2NormalMedium.copyWith(
                      color: AppColors.labelNormal,
                    ),
                  ),
                  if (isNewbie) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.labelNormal,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.newbie,
                        style: AppTextStyles.caption2Medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              // 메시지 버블
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.containerNormal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  style: AppTextStyles.body2NormalMedium.copyWith(
                    color: AppColors.labelNormal,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // 시간
              Text(
                time,
                style: AppTextStyles.caption2Medium.copyWith(
                  color: AppColors.labelAlternative,
                ),
              ),
            ],
          ),
        ),
        // 멘션 버튼
        GestureDetector(
          onTap: () {},
          child: Text(
            l10n.atMention,
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.primaryFigma,
            ),
          ),
        ),
      ],
    );
  }

  /// 메시지 입력바
  Widget _buildMessageInputBar() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 팀 응원 메시지 헤더
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xFF1E2A3B),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      l10n.cheerMessage(l10n.teamName),
                      style: AppTextStyles.body2NormalMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          // 입력 필드
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // + 버튼
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderNormal),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.labelNeutral,
                  ),
                ),
                const SizedBox(width: 8),
                // 텍스트 필드
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.containerNormal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.cheerMessageHint,
                            style: AppTextStyles.body2NormalMedium.copyWith(
                              color: AppColors.labelAlternative,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 전송 버튼
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryFigma,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.send,
                    size: 20,
                    color: AppColors.white,
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
