import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  Future<void> _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // 알림 권한 화면으로 이동 (온보딩 플로우)
      Navigator.of(context).pushReplacementNamed('/notification-permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고
              _buildLogo(),
              const SizedBox(height: 20),
              // 서비스명 (일본어)
              _buildServiceName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryFigma,
          width: 2,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'REAL',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'TIME',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryFigma,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'score',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryFigma,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceName() {
    return const Text(
      'リアルタイムスコア',
      style: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryFigma,
        letterSpacing: 1,
      ),
    );
  }
}
