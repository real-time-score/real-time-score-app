import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'config/app_config.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/splash/presentation/pages/notification_permission_page.dart';
import 'features/live_score/presentation/pages/live_score_main_page.dart';
import 'features/live_score/presentation/pages/alarm_list_page.dart';
import 'features/live_score/presentation/pages/match_full_mode_page.dart';
import 'features/live_score/presentation/pages/live_match_detail_page.dart';
import 'features/live_score/presentation/pages/chart_comparison_page.dart';
import 'features/live_score/presentation/pages/lineup_page.dart';
import 'features/live_score/presentation/pages/prediction_game_page.dart';
import 'features/live_score/presentation/pages/team_info_page.dart';
import 'features/live_score/presentation/pages/player_detail_page.dart';
import 'features/live_score/presentation/pages/gif_case_page.dart';
import 'features/live_score/presentation/pages/glossary_page.dart';
import 'features/proto/presentation/pages/proto_main_page.dart';
import 'features/pick_expert/presentation/pages/pick_expert_page.dart';
import 'features/pick_expert/presentation/pages/pick_register_page.dart';
import 'features/pick_expert/presentation/pages/pick_register_detail_page.dart';
import 'features/pick_expert/presentation/pages/pick_detail_page.dart';
import 'features/pick_expert/presentation/pages/my_pick_page.dart';
import 'features/community/presentation/pages/community_page.dart';
import 'features/community/presentation/pages/community_detail_page.dart';
import 'features/community/presentation/pages/community_write_page.dart';
import 'features/ranking/presentation/pages/ranking_page.dart';
import 'features/my/presentation/pages/my_page.dart';
import 'features/my/presentation/pages/profile_edit_page.dart';
import 'features/user_profile/presentation/pages/user_profile_page.dart';
import 'features/badge/presentation/pages/certification_badge_page.dart';
import 'features/badge/presentation/pages/activity_temperature_page.dart';
import 'features/point/presentation/pages/point_management_page.dart';
import 'features/point/presentation/pages/phone_verification_page.dart';
import 'features/point/presentation/pages/point_charge_page.dart';
import 'features/settings/presentation/pages/app_settings_page.dart';
import 'features/settings/presentation/pages/notification_settings_page.dart';
import 'features/settings/presentation/pages/marketing_consent_page.dart';
import 'features/support/presentation/pages/notice_page.dart';
import 'features/support/presentation/pages/faq_page.dart';
import 'features/support/presentation/pages/inquiry_page.dart';
import 'features/support/presentation/pages/terms_page.dart';
import 'features/support/presentation/pages/privacy_policy_page.dart';
import 'features/support/presentation/pages/service_terms_page.dart';
import 'features/support/presentation/pages/event_page.dart';
import 'features/main/presentation/pages/main_tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경 설정
  AppConfig.setEnvironment(Environment.dev);

  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 세로 모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스포츠스코어픽',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      // 다국어 설정
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'), // 한국어
        Locale('ja'), // 일본어
      ],
      // 기기 언어 설정에 따라 자동 선택, 지원하지 않으면 한국어
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('ko'); // 기본값: 한국어
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/notification-permission': (context) => const NotificationPermissionPage(),
        '/main': (context) => const MainTabPage(),
        '/main/pick-expert': (context) => const MainTabPage(initialIndex: 1),
        '/main/community': (context) => const MainTabPage(initialIndex: 2),
        '/main/ranking': (context) => const MainTabPage(initialIndex: 3),
        '/main/my': (context) => const MainTabPage(initialIndex: 4),
        '/alarm-list': (context) => const AlarmListPage(),
        '/match-full-mode': (context) => const MatchFullModePage(),
        '/match-full-mode/win1lose': (context) => const MatchFullModePage(initialMode: OddsMode.win1Lose),
        '/match-full-mode/handicap': (context) => const MatchFullModePage(initialMode: OddsMode.handicap),
        '/match-full-mode/underover': (context) => const MatchFullModePage(initialMode: OddsMode.underOver),
        '/live-match-detail': (context) => const LiveMatchDetailPage(),
        '/live-match-detail/before': (context) => const LiveMatchDetailPage(matchStatus: MatchStatus.before),
        '/live-match-detail/live': (context) => const LiveMatchDetailPage(matchStatus: MatchStatus.live),
        '/live-match-detail/finished': (context) => const LiveMatchDetailPage(matchStatus: MatchStatus.finished),
        '/chart-comparison': (context) => const ChartComparisonPage(),
        '/chart-record': (context) => const ChartComparisonPage(initialSubTab: ChartSubTab.record),
        '/chart-ranking': (context) => const ChartComparisonPage(initialSubTab: ChartSubTab.ranking),
        '/lineup': (context) => const LineupPage(),
        '/lineup/soccer': (context) => const LineupPage(sportType: LineupSportType.soccer),
        '/lineup/basketball': (context) => const LineupPage(sportType: LineupSportType.basketball),
        '/lineup/baseball': (context) => const LineupPage(sportType: LineupSportType.baseball),
        '/prediction-game': (context) => const PredictionGamePage(),
        '/team-info': (context) => const TeamInfoPage(),
        '/team-info/schedule': (context) => const TeamInfoPage(initialTab: TeamInfoTab.schedule),
        '/team-info/ranking': (context) => const TeamInfoPage(initialTab: TeamInfoTab.ranking),
        '/team-info/players': (context) => const TeamInfoPage(initialTab: TeamInfoTab.players),
        '/player-detail': (context) => const PlayerDetailPage(),
        '/proto-main': (context) => const ProtoMainPage(),
        '/pick-expert': (context) => const PickExpertPage(),
        '/pick-expert/free': (context) => const PickExpertPage(initialPickType: PickType.free),
        '/pick-expert/paid': (context) => const PickExpertPage(initialPickType: PickType.paid),
        '/pick-register': (context) => const PickRegisterPage(),
        '/pick-register/detail': (context) => const PickRegisterDetailPage(),
        '/pick-detail': (context) => const PickDetailPage(),
        '/pick-detail/paid': (context) => const PickDetailPage(isPaidPick: true),
        '/my-pick': (context) => const MyPickPage(),
        '/my-pick/alerted': (context) => const MyPickPage(initialTab: MyPickTab.alerted),
        '/community': (context) => const CommunityPage(),
        '/community-detail': (context) => const CommunityDetailPage(),
        '/community-detail/multi-image': (context) => const CommunityDetailPage(imageCount: 3),
        '/community-write': (context) => const CommunityWritePage(),
        '/ranking': (context) => const RankingPage(),
        '/ranking/prediction': (context) => const RankingPage(initialType: RankingType.prediction),
        '/my-page': (context) => const MyPage(),
        '/profile-edit': (context) => const ProfileEditPage(),
        '/user-profile': (context) => const UserProfilePage(),
        '/user-profile/posts': (context) => const UserProfilePage(initialTab: UserProfileTab.posts),
        '/user-profile/cheers': (context) => const UserProfilePage(initialTab: UserProfileTab.cheers),
        '/user-profile/prediction': (context) => const UserProfilePage(initialTab: UserProfileTab.prediction),
        '/user-profile/notification': (context) => const UserProfilePage(initialTab: UserProfileTab.notification),
        '/certification-badge': (context) => const CertificationBadgePage(),
        '/certification-badge/unearned': (context) => const CertificationBadgePage(showUnearned: true),
        '/activity-temperature': (context) => const ActivityTemperaturePage(),
        '/point-management': (context) => const PointManagementPage(),
        '/phone-verification': (context) => const PhoneVerificationPage(),
        '/point-charge': (context) => const PointChargePage(),
        '/app-settings': (context) => const AppSettingsPage(),
        '/notification-settings': (context) => const NotificationSettingsPage(),
        '/marketing-consent': (context) => const MarketingConsentPage(),
        '/notice': (context) => const NoticePage(),
        '/event': (context) => const EventPage(),
        '/faq': (context) => const FaqPage(),
        '/inquiry': (context) => const InquiryPage(),
        '/terms': (context) => const TermsPage(),
        '/privacy-policy': (context) => const PrivacyPolicyPage(),
        '/service-terms': (context) => const ServiceTermsPage(),
        '/gif-case': (context) => const GifCasePage(),
        '/glossary': (context) => const GlossaryPage(),
      },
    );
  }
}

// 임시 메인 화면 (추후 라우팅 설정 시 교체)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _titles = ['라이브', '프로토', '픽전문가', '커뮤니티', 'MY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: Center(
        child: Text(
          '${_titles[_currentIndex]} 화면',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: '라이브',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: '프로토',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified),
            label: '픽전문가',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
      ),
    );
  }
}
