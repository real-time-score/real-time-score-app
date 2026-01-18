import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 공지사항 아이템
class NoticeItem {
  final String title;
  final String date;

  const NoticeItem({
    required this.title,
    required this.date,
  });
}

/// 공지사항 페이지
class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context),
            // 공지사항 리스트
            Expanded(
              child: _buildNoticeList(),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(BuildContext context) {
    return AppHeader.withTitle(
      title: '공지사항',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 공지사항 리스트
  Widget _buildNoticeList() {
    final notices = _getNotices();

    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context, index) {
        return _buildNoticeItem(context, notices[index]);
      },
    );
  }

  /// 공지사항 아이템
  Widget _buildNoticeItem(BuildContext context, NoticeItem notice) {
    return GestureDetector(
      onTap: () {
        // 공지사항 상세 페이지로 이동
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.borderNormal),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              notice.title,
              style: AppTextStyles.body1NormalMedium.copyWith(
                color: AppColors.labelNormal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // 날짜
            Text(
              notice.date,
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.labelAlternative,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 공지사항 데이터
  List<NoticeItem> _getNotices() {
    return List.generate(
      7,
      (index) => const NoticeItem(
        title: '[공지] 공지사항 이름이에요 두줄도 가능하죠 여러줄도 가능하니 대응해야합니다.',
        date: '2025.04.12',
      ),
    );
  }
}
