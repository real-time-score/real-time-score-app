import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../l10n/app_localizations.dart';

/// 포인트 거래 타입
enum PointTransactionType { charge, use, cancel }

/// 포인트 거래 정보
class PointTransaction {
  final int amount;
  final PointTransactionType type;
  final String date;
  final bool canCancel;

  const PointTransaction({
    required this.amount,
    required this.type,
    required this.date,
    this.canCancel = false,
  });
}

/// 포인트 관리 페이지
class PointManagementPage extends StatelessWidget {
  const PointManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context, l10n),
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 정책 안내
                    _buildPolicyInfo(l10n),
                    const SizedBox(height: 16),
                    // 현재 포인트
                    _buildCurrentPoints(context, l10n),
                    const SizedBox(height: 24),
                    // 상세 내역
                    _buildDetailHistory(l10n),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return AppHeader.withTitle(
      title: l10n.pointManagement,
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 정책 안내
  Widget _buildPolicyInfo(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pointPolicyTitle,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 12),
          _buildPolicyItem(l10n.pointPolicy1),
          const SizedBox(height: 8),
          _buildPolicyItem(l10n.pointPolicy2),
          const SizedBox(height: 8),
          _buildPolicyItem(l10n.pointPolicy3),
        ],
      ),
    );
  }

  /// 정책 아이템
  Widget _buildPolicyItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: AppTextStyles.caption1Medium.copyWith(
            color: AppColors.labelNeutral,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelNeutral,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  /// 현재 포인트
  Widget _buildCurrentPoints(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        children: [
          // 포인트 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primaryFigma,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'P',
                    style: AppTextStyles.label1Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'NN,NNN ${l10n.point}',
                style: AppTextStyles.h3Bold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 충전하기 버튼
          GestureDetector(
            onTap: () {
              // 충전 페이지로 이동
              Navigator.pushNamed(context, '/point-charge');
            },
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryFigma,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  l10n.chargeAction,
                  style: AppTextStyles.body1NormalBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 본인인증 버튼
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/phone-verification');
            },
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryFigma),
              ),
              child: Center(
                child: Text(
                  l10n.identityVerification,
                  style: AppTextStyles.body1NormalBold.copyWith(
                    color: AppColors.primaryFigma,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 상세 내역
  Widget _buildDetailHistory(AppLocalizations l10n) {
    final transactions = _getTransactions();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 타이틀
          Text(
            l10n.detailHistory,
            style: AppTextStyles.body1NormalBold.copyWith(
              color: AppColors.labelNormal,
            ),
          ),
          const SizedBox(height: 16),
          // 거래 리스트
          ...transactions.map((transaction) => _buildTransactionItem(transaction, l10n)),
        ],
      ),
    );
  }

  /// 거래 아이템
  Widget _buildTransactionItem(PointTransaction transaction, AppLocalizations l10n) {
    final isPositive = transaction.type != PointTransactionType.use;
    final amountPrefix = isPositive ? '+' : '-';
    final amountColor = isPositive ? AppColors.labelNormal : AppColors.labelNormal;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderNormal),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 금액 + 타입 뱃지 + 취소 버튼
          Row(
            children: [
              // 금액
              Text(
                '$amountPrefix NN,NNN',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: amountColor,
                ),
              ),
              const SizedBox(width: 8),
              // 타입 뱃지
              _buildTypeBadge(transaction.type, l10n),
              const Spacer(),
              // 충전 취소 버튼
              if (transaction.canCancel)
                GestureDetector(
                  onTap: () {
                    // 충전 취소 처리
                  },
                  child: Text(
                    l10n.cancelCharge,
                    style: AppTextStyles.label1Medium.copyWith(
                      color: AppColors.primaryFigma,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // 날짜
          Text(
            transaction.date,
            style: AppTextStyles.caption1Medium.copyWith(
              color: AppColors.labelAlternative,
            ),
          ),
        ],
      ),
    );
  }

  /// 타입 뱃지
  Widget _buildTypeBadge(PointTransactionType type, AppLocalizations l10n) {
    String label;
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case PointTransactionType.charge:
        label = l10n.charge;
        backgroundColor = AppColors.primaryBackground;
        textColor = AppColors.primaryFigma;
        break;
      case PointTransactionType.use:
        label = l10n.use;
        backgroundColor = Colors.transparent;
        textColor = AppColors.labelNeutral;
        break;
      case PointTransactionType.cancel:
        label = l10n.cancel;
        backgroundColor = const Color(0xFFFFF0E6);
        textColor = const Color(0xFFFF6B00);
        break;
    }

    if (type == PointTransactionType.use) {
      return Text(
        label,
        style: AppTextStyles.caption1Medium.copyWith(
          color: textColor,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption1Medium.copyWith(
          color: textColor,
        ),
      ),
    );
  }

  /// 거래 내역
  List<PointTransaction> _getTransactions() {
    return const [
      PointTransaction(
        amount: 10000,
        type: PointTransactionType.charge,
        date: 'yyyy.mm.dd',
        canCancel: true,
      ),
      PointTransaction(
        amount: 5000,
        type: PointTransactionType.use,
        date: 'yyyy.mm.dd',
      ),
      PointTransaction(
        amount: 3000,
        type: PointTransactionType.cancel,
        date: 'yyyy.mm.dd',
      ),
    ];
  }
}
