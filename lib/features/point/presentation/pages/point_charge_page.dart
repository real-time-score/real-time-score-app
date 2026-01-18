import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_header.dart';

/// 포인트 충전 페이지
class PointChargePage extends StatefulWidget {
  const PointChargePage({super.key});

  @override
  State<PointChargePage> createState() => _PointChargePageState();
}

class _PointChargePageState extends State<PointChargePage> {
  final TextEditingController _amountController = TextEditingController();
  int _currentPoints = 10000; // 현재 포인트 (예시)
  int _chargeAmount = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final text = _amountController.text.replaceAll(',', '');
    setState(() {
      _chargeAmount = int.tryParse(text) ?? 0;
    });
  }

  void _addAmount(int amount) {
    setState(() {
      _chargeAmount += amount;
      _amountController.text = _formatNumber(_chargeAmount);
    });
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
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
            // 컨텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // 금액 입력
                    _buildAmountInput(),
                    const SizedBox(height: 16),
                    // 금액 버튼들
                    _buildAmountButtons(),
                    const SizedBox(height: 24),
                    // 충전 요약
                    _buildChargeSummary(),
                  ],
                ),
              ),
            ),
            // 하단 충전 버튼
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader() {
    return AppHeader.withTitle(
      title: '충전하기',
      onBackPressed: () => Navigator.of(context).pop(),
    );
  }

  /// 금액 입력
  Widget _buildAmountInput() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '충전할 금액을 입력해주세요.',
          hintStyle: AppTextStyles.body1NormalMedium.copyWith(
            color: AppColors.labelAlternative,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: AppTextStyles.body1NormalMedium.copyWith(
          color: AppColors.labelNormal,
        ),
      ),
    );
  }

  /// 금액 버튼들
  Widget _buildAmountButtons() {
    return Row(
      children: [
        _buildAmountButton(10000),
        const SizedBox(width: 8),
        _buildAmountButton(50000),
        const SizedBox(width: 8),
        _buildAmountButton(100000),
      ],
    );
  }

  /// 금액 버튼
  Widget _buildAmountButton(int amount) {
    return GestureDetector(
      onTap: () => _addAmount(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderNormal),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '+ ${_formatNumber(amount)}',
          style: AppTextStyles.body2NormalMedium.copyWith(
            color: AppColors.labelNormal,
          ),
        ),
      ),
    );
  }

  /// 충전 요약
  Widget _buildChargeSummary() {
    final afterPoints = _currentPoints + _chargeAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerNormal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 충전전
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '충전전',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_formatNumber(_currentPoints)} 포인트',
                style: AppTextStyles.body1NormalMedium.copyWith(
                  color: AppColors.labelNeutral,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 충전후
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '충전후',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_formatNumber(afterPoints)} 포인트',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.labelNormal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 하단 충전 버튼
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          // 충전 처리
        },
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A3B),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '충전하기',
                style: AppTextStyles.body1NormalBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
