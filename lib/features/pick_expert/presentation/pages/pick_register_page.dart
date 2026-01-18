import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 무료픽 등록 페이지
class PickRegisterPage extends StatefulWidget {
  const PickRegisterPage({super.key});

  @override
  State<PickRegisterPage> createState() => _PickRegisterPageState();
}

class _PickRegisterPageState extends State<PickRegisterPage> {
  bool _isMatchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            AppHeader.withTitle(
              title: '무료픽 등록',
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 경기선택 영역
                    _buildMatchSelection(),
                    const SizedBox(height: 16),
                    // 안내 문구
                    _buildInfoBanner(),
                  ],
                ),
              ),
            ),
            // 하단 버튼
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  /// 경기선택 영역
  Widget _buildMatchSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '경기선택',
            style: AppTextStyles.h4Bold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: 경기 선택 모달 열기
              _showMatchSelectionModal();
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
                  '경기선택',
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

  /// 경기 선택 모달
  void _showMatchSelectionModal() {
    // TODO: 경기 선택 바텀시트 구현
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
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
                '경기 선택',
                style: AppTextStyles.h4Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(height: 16),
              // 경기 리스트 (예시)
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isMatchSelected = true;
                        });
                        Navigator.pop(context);
                        // 경기 선택 후 상세 등록 페이지로 이동
                        Navigator.of(context).pushNamed('/pick-register/detail');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderNormal),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '리그명',
                                  style: AppTextStyles.caption1Medium.copyWith(
                                    color: AppColors.labelNeutral,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '팀명 vs 팀명',
                                  style: AppTextStyles.body1NormalBold.copyWith(
                                    color: AppColors.labelNormal,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '7/11 (금) 15:30',
                              style: AppTextStyles.label1Medium.copyWith(
                                color: AppColors.labelNeutral,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 안내 문구 배너
  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.primaryBackground,
      child: Center(
        child: Text(
          '경기 시작 2일 전까지의 픽만 등록 가능합니다.',
          style: AppTextStyles.label1Medium.copyWith(
            color: AppColors.primaryFigma,
          ),
        ),
      ),
    );
  }

  /// 하단 버튼
  Widget _buildBottomButtons() {
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
                  '닫기',
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
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: _isMatchSelected
                    ? AppColors.primaryFigma
                    : AppColors.containerDisabled,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: _isMatchSelected
                    ? () {
                        // TODO: 등록 처리
                      }
                    : null,
                child: Center(
                  child: Text(
                    '등록하기',
                    style: AppTextStyles.body1NormalBold.copyWith(
                      color: _isMatchSelected
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
}
