import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ja'),
    Locale('ko'),
  ];

  /// 앱 타이틀
  ///
  /// In ko, this message translates to:
  /// **'리얼타임스코어'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get home;

  /// No description provided for @pickExpert.
  ///
  /// In ko, this message translates to:
  /// **'픽전문가'**
  String get pickExpert;

  /// No description provided for @community.
  ///
  /// In ko, this message translates to:
  /// **'커뮤니티'**
  String get community;

  /// No description provided for @ranking.
  ///
  /// In ko, this message translates to:
  /// **'랭킹'**
  String get ranking;

  /// No description provided for @my.
  ///
  /// In ko, this message translates to:
  /// **'MY'**
  String get my;

  /// No description provided for @live.
  ///
  /// In ko, this message translates to:
  /// **'LIVE'**
  String get live;

  /// No description provided for @proto.
  ///
  /// In ko, this message translates to:
  /// **'프로토'**
  String get proto;

  /// No description provided for @all.
  ///
  /// In ko, this message translates to:
  /// **'전체'**
  String get all;

  /// No description provided for @esports.
  ///
  /// In ko, this message translates to:
  /// **'e스포츠'**
  String get esports;

  /// No description provided for @soccer.
  ///
  /// In ko, this message translates to:
  /// **'축구'**
  String get soccer;

  /// No description provided for @baseball.
  ///
  /// In ko, this message translates to:
  /// **'야구'**
  String get baseball;

  /// No description provided for @basketball.
  ///
  /// In ko, this message translates to:
  /// **'농구'**
  String get basketball;

  /// No description provided for @volleyball.
  ///
  /// In ko, this message translates to:
  /// **'배구'**
  String get volleyball;

  /// No description provided for @hockey.
  ///
  /// In ko, this message translates to:
  /// **'하키'**
  String get hockey;

  /// No description provided for @tennis.
  ///
  /// In ko, this message translates to:
  /// **'테니스'**
  String get tennis;

  /// No description provided for @today.
  ///
  /// In ko, this message translates to:
  /// **'TODAY'**
  String get today;

  /// No description provided for @scheduled.
  ///
  /// In ko, this message translates to:
  /// **'예정'**
  String get scheduled;

  /// No description provided for @finished.
  ///
  /// In ko, this message translates to:
  /// **'종료'**
  String get finished;

  /// No description provided for @pick.
  ///
  /// In ko, this message translates to:
  /// **'픽'**
  String get pick;

  /// No description provided for @freePick.
  ///
  /// In ko, this message translates to:
  /// **'무료픽'**
  String get freePick;

  /// No description provided for @paidPick.
  ///
  /// In ko, this message translates to:
  /// **'유료픽'**
  String get paidPick;

  /// No description provided for @myPick.
  ///
  /// In ko, this message translates to:
  /// **'MY 픽'**
  String get myPick;

  /// No description provided for @leagueName.
  ///
  /// In ko, this message translates to:
  /// **'리그명'**
  String get leagueName;

  /// No description provided for @teamName.
  ///
  /// In ko, this message translates to:
  /// **'팀명'**
  String get teamName;

  /// No description provided for @playerName.
  ///
  /// In ko, this message translates to:
  /// **'선수명'**
  String get playerName;

  /// No description provided for @scheduleResult.
  ///
  /// In ko, this message translates to:
  /// **'일정/결과'**
  String get scheduleResult;

  /// No description provided for @rankingTab.
  ///
  /// In ko, this message translates to:
  /// **'순위'**
  String get rankingTab;

  /// No description provided for @players.
  ///
  /// In ko, this message translates to:
  /// **'선수'**
  String get players;

  /// No description provided for @chart.
  ///
  /// In ko, this message translates to:
  /// **'차트'**
  String get chart;

  /// No description provided for @lineup.
  ///
  /// In ko, this message translates to:
  /// **'라인업'**
  String get lineup;

  /// No description provided for @predictionGame.
  ///
  /// In ko, this message translates to:
  /// **'예측게임'**
  String get predictionGame;

  /// No description provided for @comparison.
  ///
  /// In ko, this message translates to:
  /// **'비교'**
  String get comparison;

  /// No description provided for @record.
  ///
  /// In ko, this message translates to:
  /// **'기록'**
  String get record;

  /// No description provided for @rankingRecord.
  ///
  /// In ko, this message translates to:
  /// **'순위'**
  String get rankingRecord;

  /// No description provided for @recentMatches.
  ///
  /// In ko, this message translates to:
  /// **'최근 5경기'**
  String get recentMatches;

  /// No description provided for @headToHead.
  ///
  /// In ko, this message translates to:
  /// **'맞대결'**
  String get headToHead;

  /// No description provided for @recentHeadToHead.
  ///
  /// In ko, this message translates to:
  /// **'최근 맞대결 전적'**
  String get recentHeadToHead;

  /// No description provided for @recentBothTeamRecord.
  ///
  /// In ko, this message translates to:
  /// **'최근 양팀 전적'**
  String get recentBothTeamRecord;

  /// No description provided for @domestic.
  ///
  /// In ko, this message translates to:
  /// **'국내'**
  String get domestic;

  /// No description provided for @overseas.
  ///
  /// In ko, this message translates to:
  /// **'해외'**
  String get overseas;

  /// No description provided for @win.
  ///
  /// In ko, this message translates to:
  /// **'승'**
  String get win;

  /// No description provided for @draw.
  ///
  /// In ko, this message translates to:
  /// **'무'**
  String get draw;

  /// No description provided for @lose.
  ///
  /// In ko, this message translates to:
  /// **'패'**
  String get lose;

  /// No description provided for @notificationRanking.
  ///
  /// In ko, this message translates to:
  /// **'알림 랭킹'**
  String get notificationRanking;

  /// No description provided for @predictionRanking.
  ///
  /// In ko, this message translates to:
  /// **'예측게임 랭킹'**
  String get predictionRanking;

  /// No description provided for @sort.
  ///
  /// In ko, this message translates to:
  /// **'정렬'**
  String get sort;

  /// No description provided for @latest.
  ///
  /// In ko, this message translates to:
  /// **'최신순'**
  String get latest;

  /// No description provided for @popular.
  ///
  /// In ko, this message translates to:
  /// **'인기순'**
  String get popular;

  /// No description provided for @comments.
  ///
  /// In ko, this message translates to:
  /// **'댓글순'**
  String get comments;

  /// No description provided for @views.
  ///
  /// In ko, this message translates to:
  /// **'조회순'**
  String get views;

  /// No description provided for @totalCount.
  ///
  /// In ko, this message translates to:
  /// **'총 {count}개 등록'**
  String totalCount(String count);

  /// No description provided for @submit.
  ///
  /// In ko, this message translates to:
  /// **'제출하기'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ko, this message translates to:
  /// **'수정'**
  String get edit;

  /// No description provided for @search.
  ///
  /// In ko, this message translates to:
  /// **'검색'**
  String get search;

  /// No description provided for @searchHintExpert.
  ///
  /// In ko, this message translates to:
  /// **'전문가명, 경기명을 입력해주세요'**
  String get searchHintExpert;

  /// No description provided for @searchHintNickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임, 경기명을 입력해주세요'**
  String get searchHintNickname;

  /// No description provided for @category.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get category;

  /// No description provided for @adminNotice.
  ///
  /// In ko, this message translates to:
  /// **'운영자 등록글 노출'**
  String get adminNotice;

  /// No description provided for @predictMatch.
  ///
  /// In ko, this message translates to:
  /// **'승부를 예측해보세요'**
  String get predictMatch;

  /// No description provided for @victoryTeam.
  ///
  /// In ko, this message translates to:
  /// **'승리팀'**
  String get victoryTeam;

  /// No description provided for @handicap.
  ///
  /// In ko, this message translates to:
  /// **'핸디캡'**
  String get handicap;

  /// No description provided for @underOver.
  ///
  /// In ko, this message translates to:
  /// **'언더오버'**
  String get underOver;

  /// No description provided for @homerun.
  ///
  /// In ko, this message translates to:
  /// **'홈런'**
  String get homerun;

  /// No description provided for @score.
  ///
  /// In ko, this message translates to:
  /// **'스코어'**
  String get score;

  /// No description provided for @goal.
  ///
  /// In ko, this message translates to:
  /// **'골'**
  String get goal;

  /// No description provided for @todayPeriod.
  ///
  /// In ko, this message translates to:
  /// **'투데이'**
  String get todayPeriod;

  /// No description provided for @allPeriod.
  ///
  /// In ko, this message translates to:
  /// **'전체'**
  String get allPeriod;

  /// No description provided for @nickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임'**
  String get nickname;

  /// No description provided for @predictionSuccess.
  ///
  /// In ko, this message translates to:
  /// **'예측성공'**
  String get predictionSuccess;

  /// No description provided for @americanFootball.
  ///
  /// In ko, this message translates to:
  /// **'미식축구'**
  String get americanFootball;

  /// No description provided for @freeBoard.
  ///
  /// In ko, this message translates to:
  /// **'자유게시판'**
  String get freeBoard;

  /// No description provided for @etc.
  ///
  /// In ko, this message translates to:
  /// **'기타'**
  String get etc;

  /// No description provided for @liveTab.
  ///
  /// In ko, this message translates to:
  /// **'라이브'**
  String get liveTab;

  /// No description provided for @homeMatch.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get homeMatch;

  /// No description provided for @versus.
  ///
  /// In ko, this message translates to:
  /// **'맞대결'**
  String get versus;

  /// No description provided for @posts.
  ///
  /// In ko, this message translates to:
  /// **'게시글'**
  String get posts;

  /// No description provided for @cheers.
  ///
  /// In ko, this message translates to:
  /// **'응원글'**
  String get cheers;

  /// No description provided for @notification.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get notification;

  /// No description provided for @matches.
  ///
  /// In ko, this message translates to:
  /// **'경기'**
  String get matches;

  /// No description provided for @points.
  ///
  /// In ko, this message translates to:
  /// **'승점'**
  String get points;

  /// No description provided for @position.
  ///
  /// In ko, this message translates to:
  /// **'포지션'**
  String get position;

  /// No description provided for @nationality.
  ///
  /// In ko, this message translates to:
  /// **'국적'**
  String get nationality;

  /// No description provided for @age.
  ///
  /// In ko, this message translates to:
  /// **'나이'**
  String get age;

  /// No description provided for @defenseRate.
  ///
  /// In ko, this message translates to:
  /// **'방어율'**
  String get defenseRate;

  /// No description provided for @afterChampionship.
  ///
  /// In ko, this message translates to:
  /// **'우승후'**
  String get afterChampionship;

  /// No description provided for @totalRecord.
  ///
  /// In ko, this message translates to:
  /// **'전적'**
  String get totalRecord;

  /// No description provided for @vsRecord.
  ///
  /// In ko, this message translates to:
  /// **'상대 전적'**
  String get vsRecord;

  /// No description provided for @winRate.
  ///
  /// In ko, this message translates to:
  /// **'승률'**
  String get winRate;

  /// No description provided for @homeAwayWinRate.
  ///
  /// In ko, this message translates to:
  /// **'홈/원정 승률'**
  String get homeAwayWinRate;

  /// No description provided for @ratingWinRate.
  ///
  /// In ko, this message translates to:
  /// **'평점 승률'**
  String get ratingWinRate;

  /// No description provided for @drawMatch.
  ///
  /// In ko, this message translates to:
  /// **'무승부'**
  String get drawMatch;

  /// No description provided for @homeWinRate.
  ///
  /// In ko, this message translates to:
  /// **'홈 승률'**
  String get homeWinRate;

  /// No description provided for @awayWinRate.
  ///
  /// In ko, this message translates to:
  /// **'원정 승률'**
  String get awayWinRate;

  /// No description provided for @appSettings.
  ///
  /// In ko, this message translates to:
  /// **'앱설정'**
  String get appSettings;

  /// No description provided for @notificationSettings.
  ///
  /// In ko, this message translates to:
  /// **'알림 설정'**
  String get notificationSettings;

  /// No description provided for @marketingConsent.
  ///
  /// In ko, this message translates to:
  /// **'마케팅 수신 동의'**
  String get marketingConsent;

  /// No description provided for @allNotifications.
  ///
  /// In ko, this message translates to:
  /// **'전체 알림'**
  String get allNotifications;

  /// No description provided for @matchStartNotification.
  ///
  /// In ko, this message translates to:
  /// **'경기 시작 전 알림'**
  String get matchStartNotification;

  /// No description provided for @matchResultNotification.
  ///
  /// In ko, this message translates to:
  /// **'경기 결과 알림'**
  String get matchResultNotification;

  /// No description provided for @predictionDeadline.
  ///
  /// In ko, this message translates to:
  /// **'예측게임 마감 임박'**
  String get predictionDeadline;

  /// No description provided for @newExpertPick.
  ///
  /// In ko, this message translates to:
  /// **'픽 전문가 신규 등록'**
  String get newExpertPick;

  /// No description provided for @popularPost.
  ///
  /// In ko, this message translates to:
  /// **'게시글 인기 상승 중'**
  String get popularPost;

  /// No description provided for @attendanceReminder.
  ///
  /// In ko, this message translates to:
  /// **'출석 독려'**
  String get attendanceReminder;

  /// No description provided for @temperatureWarning.
  ///
  /// In ko, this message translates to:
  /// **'안전온도 하락 경고'**
  String get temperatureWarning;

  /// No description provided for @participationResult.
  ///
  /// In ko, this message translates to:
  /// **'답 참여 결과 발표'**
  String get participationResult;

  /// No description provided for @likeCommentNotification.
  ///
  /// In ko, this message translates to:
  /// **'좋아요, 댓글 알림'**
  String get likeCommentNotification;

  /// No description provided for @rankingEntryNotification.
  ///
  /// In ko, this message translates to:
  /// **'랭킹 진입 알림'**
  String get rankingEntryNotification;

  /// No description provided for @cheerReactionNotification.
  ///
  /// In ko, this message translates to:
  /// **'응원메시지 반응 알림'**
  String get cheerReactionNotification;

  /// No description provided for @eventBenefitInfo.
  ///
  /// In ko, this message translates to:
  /// **'이벤트, 혜택, 상품 추천 등'**
  String get eventBenefitInfo;

  /// No description provided for @consentWithdrawal.
  ///
  /// In ko, this message translates to:
  /// **'수신 동의 철회: MY > 앱 설정'**
  String get consentWithdrawal;

  /// No description provided for @notificationGuide.
  ///
  /// In ko, this message translates to:
  /// **'서비스명 알림 설정 안내'**
  String get notificationGuide;

  /// No description provided for @notificationQuestion.
  ///
  /// In ko, this message translates to:
  /// **'고객님을 위한 다양한 스포츠 추천 정보와\n이벤트 알림을 받으시겠습니까?'**
  String get notificationQuestion;

  /// No description provided for @no.
  ///
  /// In ko, this message translates to:
  /// **'아니요'**
  String get no;

  /// No description provided for @receiveNotification.
  ///
  /// In ko, this message translates to:
  /// **'알림받기'**
  String get receiveNotification;

  /// No description provided for @winDrawLose.
  ///
  /// In ko, this message translates to:
  /// **'승무패'**
  String get winDrawLose;

  /// No description provided for @win1Lose.
  ///
  /// In ko, this message translates to:
  /// **'승1패'**
  String get win1Lose;

  /// No description provided for @changeTime.
  ///
  /// In ko, this message translates to:
  /// **'변동시간'**
  String get changeTime;

  /// No description provided for @homeLose.
  ///
  /// In ko, this message translates to:
  /// **'홈패'**
  String get homeLose;

  /// No description provided for @homeWin.
  ///
  /// In ko, this message translates to:
  /// **'홈승'**
  String get homeWin;

  /// No description provided for @initial.
  ///
  /// In ko, this message translates to:
  /// **'초기'**
  String get initial;

  /// No description provided for @beforeMatch.
  ///
  /// In ko, this message translates to:
  /// **'경기전'**
  String get beforeMatch;

  /// No description provided for @duringMatch.
  ///
  /// In ko, this message translates to:
  /// **'경기중'**
  String get duringMatch;

  /// No description provided for @afterMatch.
  ///
  /// In ko, this message translates to:
  /// **'경기 종료'**
  String get afterMatch;

  /// No description provided for @alarmList.
  ///
  /// In ko, this message translates to:
  /// **'알람 목록'**
  String get alarmList;

  /// No description provided for @glossary.
  ///
  /// In ko, this message translates to:
  /// **'용어 설명'**
  String get glossary;

  /// No description provided for @receivedNotification.
  ///
  /// In ko, this message translates to:
  /// **'받은 알림'**
  String get receivedNotification;

  /// No description provided for @certificationBadge.
  ///
  /// In ko, this message translates to:
  /// **'인증뱃지'**
  String get certificationBadge;

  /// No description provided for @activityTemperature.
  ///
  /// In ko, this message translates to:
  /// **'활동온도'**
  String get activityTemperature;

  /// No description provided for @point.
  ///
  /// In ko, this message translates to:
  /// **'포인트'**
  String get point;

  /// No description provided for @notice.
  ///
  /// In ko, this message translates to:
  /// **'공지사항'**
  String get notice;

  /// No description provided for @event.
  ///
  /// In ko, this message translates to:
  /// **'이벤트'**
  String get event;

  /// No description provided for @inquiry.
  ///
  /// In ko, this message translates to:
  /// **'1:1 문의하기'**
  String get inquiry;

  /// No description provided for @faq.
  ///
  /// In ko, this message translates to:
  /// **'자주 묻는 질문'**
  String get faq;

  /// No description provided for @terms.
  ///
  /// In ko, this message translates to:
  /// **'약관'**
  String get terms;

  /// No description provided for @expertName.
  ///
  /// In ko, this message translates to:
  /// **'전문가명'**
  String get expertName;

  /// No description provided for @titleDisplay.
  ///
  /// In ko, this message translates to:
  /// **'타이틀 노출'**
  String get titleDisplay;

  /// No description provided for @winLose.
  ///
  /// In ko, this message translates to:
  /// **'승패'**
  String get winLose;

  /// No description provided for @handi.
  ///
  /// In ko, this message translates to:
  /// **'핸디'**
  String get handi;

  /// No description provided for @categoryName.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 명'**
  String get categoryName;

  /// No description provided for @title.
  ///
  /// In ko, this message translates to:
  /// **'제목'**
  String get title;

  /// No description provided for @expectedScore.
  ///
  /// In ko, this message translates to:
  /// **'예상 스코어'**
  String get expectedScore;

  /// No description provided for @inningTop.
  ///
  /// In ko, this message translates to:
  /// **'회 초'**
  String get inningTop;

  /// No description provided for @newbie.
  ///
  /// In ko, this message translates to:
  /// **'뉴비'**
  String get newbie;

  /// No description provided for @messageDisplay.
  ///
  /// In ko, this message translates to:
  /// **'메세지 노출'**
  String get messageDisplay;

  /// No description provided for @gujung.
  ///
  /// In ko, this message translates to:
  /// **'구중'**
  String get gujung;

  /// No description provided for @jinjung.
  ///
  /// In ko, this message translates to:
  /// **'진중'**
  String get jinjung;

  /// No description provided for @report.
  ///
  /// In ko, this message translates to:
  /// **'신고'**
  String get report;

  /// No description provided for @block.
  ///
  /// In ko, this message translates to:
  /// **'차단'**
  String get block;

  /// No description provided for @cheer.
  ///
  /// In ko, this message translates to:
  /// **'응원'**
  String get cheer;

  /// No description provided for @homeTeam.
  ///
  /// In ko, this message translates to:
  /// **'홈팀'**
  String get homeTeam;

  /// No description provided for @awayTeam.
  ///
  /// In ko, this message translates to:
  /// **'원정팀'**
  String get awayTeam;

  /// No description provided for @cheerMessageHint.
  ///
  /// In ko, this message translates to:
  /// **'응원 메시지 입력'**
  String get cheerMessageHint;

  /// No description provided for @startWithKakao.
  ///
  /// In ko, this message translates to:
  /// **'카카오로 시작하기'**
  String get startWithKakao;

  /// No description provided for @follow.
  ///
  /// In ko, this message translates to:
  /// **'팔로우'**
  String get follow;

  /// No description provided for @following.
  ///
  /// In ko, this message translates to:
  /// **'팔로잉'**
  String get following;

  /// No description provided for @questionListPlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'여기는 자주하는 질문 리스트가 나와요'**
  String get questionListPlaceholder;

  /// No description provided for @writePost.
  ///
  /// In ko, this message translates to:
  /// **'글쓰기'**
  String get writePost;

  /// No description provided for @writeComment.
  ///
  /// In ko, this message translates to:
  /// **'댓글 작성'**
  String get writeComment;

  /// No description provided for @reply.
  ///
  /// In ko, this message translates to:
  /// **'답글'**
  String get reply;

  /// No description provided for @profileEdit.
  ///
  /// In ko, this message translates to:
  /// **'프로필 수정'**
  String get profileEdit;

  /// No description provided for @logout.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get logout;

  /// No description provided for @withdrawal.
  ///
  /// In ko, this message translates to:
  /// **'회원탈퇴'**
  String get withdrawal;

  /// No description provided for @phoneVerification.
  ///
  /// In ko, this message translates to:
  /// **'휴대폰 인증'**
  String get phoneVerification;

  /// No description provided for @pointCharge.
  ///
  /// In ko, this message translates to:
  /// **'포인트 충전'**
  String get pointCharge;

  /// No description provided for @pointHistory.
  ///
  /// In ko, this message translates to:
  /// **'포인트 내역'**
  String get pointHistory;

  /// No description provided for @purchaseHistory.
  ///
  /// In ko, this message translates to:
  /// **'구매 내역'**
  String get purchaseHistory;

  /// No description provided for @saleHistory.
  ///
  /// In ko, this message translates to:
  /// **'판매 내역'**
  String get saleHistory;

  /// No description provided for @mention.
  ///
  /// In ko, this message translates to:
  /// **'멘션'**
  String get mention;

  /// No description provided for @predictionResult.
  ///
  /// In ko, this message translates to:
  /// **'[예측결과] 팀명 NN% 승 / 핸패 / 오버'**
  String get predictionResult;

  /// No description provided for @noticeSampleTitle.
  ///
  /// In ko, this message translates to:
  /// **'[공지] 공지사항 이름이에요'**
  String get noticeSampleTitle;

  /// No description provided for @inquiryQuestion.
  ///
  /// In ko, this message translates to:
  /// **'서비스 이용 관련해서 궁금한 점 있으신가요?'**
  String get inquiryQuestion;

  /// No description provided for @inquiryDescription.
  ///
  /// In ko, this message translates to:
  /// **'문의사항을 남겨 주시면 이메일 주소로 답변을 보내드립니다.'**
  String get inquiryDescription;

  /// No description provided for @inquiryTitle.
  ///
  /// In ko, this message translates to:
  /// **'문의 제목을 입력해주세요'**
  String get inquiryTitle;

  /// No description provided for @inquiryContent.
  ///
  /// In ko, this message translates to:
  /// **'문의 내용'**
  String get inquiryContent;

  /// No description provided for @inquiryContentHint.
  ///
  /// In ko, this message translates to:
  /// **'문의 내용을 입력해주세요'**
  String get inquiryContentHint;

  /// No description provided for @emailAddress.
  ///
  /// In ko, this message translates to:
  /// **'이메일 주소'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In ko, this message translates to:
  /// **'이메일을 입력해주세요'**
  String get emailHint;

  /// No description provided for @required.
  ///
  /// In ko, this message translates to:
  /// **'(필수)'**
  String get required;

  /// No description provided for @submitInquiry.
  ///
  /// In ko, this message translates to:
  /// **'문의하기'**
  String get submitInquiry;

  /// No description provided for @privacyPolicy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보처리방침'**
  String get privacyPolicy;

  /// No description provided for @serviceTerms.
  ///
  /// In ko, this message translates to:
  /// **'서비스 이용약관'**
  String get serviceTerms;

  /// No description provided for @eventImage.
  ///
  /// In ko, this message translates to:
  /// **'이벤트 이미지'**
  String get eventImage;

  /// No description provided for @ongoing.
  ///
  /// In ko, this message translates to:
  /// **'진행중'**
  String get ongoing;

  /// No description provided for @eventTitle.
  ///
  /// In ko, this message translates to:
  /// **'이벤트 제목'**
  String get eventTitle;

  /// No description provided for @commentLabel.
  ///
  /// In ko, this message translates to:
  /// **'댓글'**
  String get commentLabel;

  /// No description provided for @commentCount.
  ///
  /// In ko, this message translates to:
  /// **'({count}개)'**
  String commentCount(String count);

  /// No description provided for @commentContent.
  ///
  /// In ko, this message translates to:
  /// **'댓글에 대한 내용이 나옵니다.'**
  String get commentContent;

  /// No description provided for @postContent.
  ///
  /// In ko, this message translates to:
  /// **'글에 대한 내용이 들어갑니다'**
  String get postContent;

  /// No description provided for @moreReplies.
  ///
  /// In ko, this message translates to:
  /// **'답글 {count}개 더보기'**
  String moreReplies(int count);

  /// No description provided for @enterComment.
  ///
  /// In ko, this message translates to:
  /// **'댓글을 입력하세요.'**
  String get enterComment;

  /// No description provided for @minutesAgo.
  ///
  /// In ko, this message translates to:
  /// **'{n}분 전'**
  String minutesAgo(String n);

  /// No description provided for @registerPost.
  ///
  /// In ko, this message translates to:
  /// **'게시글 등록'**
  String get registerPost;

  /// No description provided for @selectCategory.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 선택'**
  String get selectCategory;

  /// No description provided for @categoryNameHint.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 이름'**
  String get categoryNameHint;

  /// No description provided for @mediaUpload.
  ///
  /// In ko, this message translates to:
  /// **'미디어 업로드'**
  String get mediaUpload;

  /// No description provided for @imageUpload.
  ///
  /// In ko, this message translates to:
  /// **'이미지 업로드'**
  String get imageUpload;

  /// No description provided for @maxImagesInfo.
  ///
  /// In ko, this message translates to:
  /// **'최대 10개 이미지 등록 가능'**
  String get maxImagesInfo;

  /// No description provided for @thumbnailInfo.
  ///
  /// In ko, this message translates to:
  /// **'가장 앞에 있는 이미지가 썸네일로 설정됩니다.'**
  String get thumbnailInfo;

  /// No description provided for @thumbnail.
  ///
  /// In ko, this message translates to:
  /// **'썸네일'**
  String get thumbnail;

  /// No description provided for @content.
  ///
  /// In ko, this message translates to:
  /// **'내용'**
  String get content;

  /// No description provided for @enterContentHint.
  ///
  /// In ko, this message translates to:
  /// **'콘텐츠 내용을 입력해주세요'**
  String get enterContentHint;

  /// No description provided for @register.
  ///
  /// In ko, this message translates to:
  /// **'등록하기'**
  String get register;

  /// No description provided for @cheerMessage.
  ///
  /// In ko, this message translates to:
  /// **'({teamName})응원 메세지'**
  String cheerMessage(String teamName);

  /// No description provided for @mentionMessage.
  ///
  /// In ko, this message translates to:
  /// **'({userName})멘션'**
  String mentionMessage(String userName);

  /// No description provided for @initialTemperature.
  ///
  /// In ko, this message translates to:
  /// **'첫 온도 36.5°C'**
  String get initialTemperature;

  /// No description provided for @detailActivityTemperature.
  ///
  /// In ko, this message translates to:
  /// **'상세 활동 온도'**
  String get detailActivityTemperature;

  /// No description provided for @likes.
  ///
  /// In ko, this message translates to:
  /// **'좋아요'**
  String get likes;

  /// No description provided for @attendance.
  ///
  /// In ko, this message translates to:
  /// **'출석'**
  String get attendance;

  /// No description provided for @pickExpertShort.
  ///
  /// In ko, this message translates to:
  /// **'픽전문'**
  String get pickExpertShort;

  /// No description provided for @activityTemperatureDescription.
  ///
  /// In ko, this message translates to:
  /// **'활동 온도는 36.5°C에서 시작하여 응원, 예측 게임, 게시글, 좋아요, 댓글, 출석, 픽 전문가 후원 활동에 따라 증가합니다. 게임, 커뮤니티 이용 가이드를 준수하지 않을 경우 서비스 운영 정책에 따라 활동 온도가 하락할 수 있습니다. 활동 온도가 일정 기준 이하로 떨어지면 서비스 이용이 제한됩니다.'**
  String get activityTemperatureDescription;

  /// No description provided for @badgeCount.
  ///
  /// In ko, this message translates to:
  /// **'인증뱃지 획득 수'**
  String get badgeCount;

  /// No description provided for @badgeCheerWarrior.
  ///
  /// In ko, this message translates to:
  /// **'응원의 전사'**
  String get badgeCheerWarrior;

  /// No description provided for @badgePredictionMaster.
  ///
  /// In ko, this message translates to:
  /// **'예측 마스터'**
  String get badgePredictionMaster;

  /// No description provided for @badgeHotPoster.
  ///
  /// In ko, this message translates to:
  /// **'핫게시터'**
  String get badgeHotPoster;

  /// No description provided for @badgeLikeFairy.
  ///
  /// In ko, this message translates to:
  /// **'좋아요 요정'**
  String get badgeLikeFairy;

  /// No description provided for @badgeCommentLeader.
  ///
  /// In ko, this message translates to:
  /// **'댓글 리더'**
  String get badgeCommentLeader;

  /// No description provided for @badgeAttendanceKing.
  ///
  /// In ko, this message translates to:
  /// **'출석왕'**
  String get badgeAttendanceKing;

  /// No description provided for @badgePickConsumer.
  ///
  /// In ko, this message translates to:
  /// **'픽 소비자'**
  String get badgePickConsumer;

  /// No description provided for @badgePassionUser.
  ///
  /// In ko, this message translates to:
  /// **'열정유저'**
  String get badgePassionUser;

  /// No description provided for @badgeTemperatureGuardian.
  ///
  /// In ko, this message translates to:
  /// **'온도 수호자'**
  String get badgeTemperatureGuardian;

  /// No description provided for @easyToto.
  ///
  /// In ko, this message translates to:
  /// **'이지토토'**
  String get easyToto;

  /// No description provided for @easyTotoDesc.
  ///
  /// In ko, this message translates to:
  /// **'소액으로 즐기는\n스포츠 복권'**
  String get easyTotoDesc;

  /// No description provided for @protoMatch.
  ///
  /// In ko, this message translates to:
  /// **'프로토 승부식'**
  String get protoMatch;

  /// No description provided for @protoMatchDesc.
  ///
  /// In ko, this message translates to:
  /// **'나만의 경기 분석으로\n배당률 적중'**
  String get protoMatchDesc;

  /// No description provided for @sportsToto.
  ///
  /// In ko, this message translates to:
  /// **'스포츠토토'**
  String get sportsToto;

  /// No description provided for @sportsTotoDesc.
  ///
  /// In ko, this message translates to:
  /// **'간단한 선택으로\n스포츠 즐기기'**
  String get sportsTotoDesc;

  /// No description provided for @charge.
  ///
  /// In ko, this message translates to:
  /// **'충전'**
  String get charge;

  /// No description provided for @chargeAction.
  ///
  /// In ko, this message translates to:
  /// **'충전하기'**
  String get chargeAction;

  /// No description provided for @identityVerification.
  ///
  /// In ko, this message translates to:
  /// **'본인인증'**
  String get identityVerification;

  /// No description provided for @cancelCharge.
  ///
  /// In ko, this message translates to:
  /// **'충전취소'**
  String get cancelCharge;

  /// No description provided for @use.
  ///
  /// In ko, this message translates to:
  /// **'사용'**
  String get use;

  /// No description provided for @beforeCharge.
  ///
  /// In ko, this message translates to:
  /// **'충전전'**
  String get beforeCharge;

  /// No description provided for @afterCharge.
  ///
  /// In ko, this message translates to:
  /// **'충전후'**
  String get afterCharge;

  /// No description provided for @myProfileEdit.
  ///
  /// In ko, this message translates to:
  /// **'내 프로필 편집'**
  String get myProfileEdit;

  /// No description provided for @complete.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get complete;

  /// No description provided for @change.
  ///
  /// In ko, this message translates to:
  /// **'변경'**
  String get change;

  /// No description provided for @checkDuplicate.
  ///
  /// In ko, this message translates to:
  /// **'중복확인'**
  String get checkDuplicate;

  /// No description provided for @replyToComment.
  ///
  /// In ko, this message translates to:
  /// **'답글달기'**
  String get replyToComment;

  /// No description provided for @selectMatch.
  ///
  /// In ko, this message translates to:
  /// **'경기선택'**
  String get selectMatch;

  /// No description provided for @matchDateTime.
  ///
  /// In ko, this message translates to:
  /// **'경기일시'**
  String get matchDateTime;

  /// No description provided for @close.
  ///
  /// In ko, this message translates to:
  /// **'닫기'**
  String get close;

  /// No description provided for @matchStatus.
  ///
  /// In ko, this message translates to:
  /// **'경기상태'**
  String get matchStatus;

  /// No description provided for @viewCount.
  ///
  /// In ko, this message translates to:
  /// **'조회수'**
  String get viewCount;

  /// No description provided for @recentGames.
  ///
  /// In ko, this message translates to:
  /// **'최근 {games}게임 {wins}승 {losses}패'**
  String recentGames(String games, String wins, String losses);

  /// No description provided for @mainSport.
  ///
  /// In ko, this message translates to:
  /// **'주종목'**
  String get mainSport;

  /// No description provided for @detailInfo.
  ///
  /// In ko, this message translates to:
  /// **'상세정보'**
  String get detailInfo;

  /// No description provided for @focusAnalysis.
  ///
  /// In ko, this message translates to:
  /// **'집중분석'**
  String get focusAnalysis;

  /// No description provided for @hit.
  ///
  /// In ko, this message translates to:
  /// **'적중'**
  String get hit;

  /// No description provided for @miss.
  ///
  /// In ko, this message translates to:
  /// **'실패'**
  String get miss;

  /// No description provided for @under.
  ///
  /// In ko, this message translates to:
  /// **'언더'**
  String get under;

  /// No description provided for @over.
  ///
  /// In ko, this message translates to:
  /// **'오버'**
  String get over;

  /// No description provided for @homeTeamLineup.
  ///
  /// In ko, this message translates to:
  /// **'홈팀 라인업'**
  String get homeTeamLineup;

  /// No description provided for @awayTeamLineup.
  ///
  /// In ko, this message translates to:
  /// **'원정팀 라인업'**
  String get awayTeamLineup;

  /// No description provided for @appearanceResult.
  ///
  /// In ko, this message translates to:
  /// **'출전결과'**
  String get appearanceResult;

  /// No description provided for @paidLabel.
  ///
  /// In ko, this message translates to:
  /// **'유료'**
  String get paidLabel;

  /// No description provided for @freeLabel.
  ///
  /// In ko, this message translates to:
  /// **'무료'**
  String get freeLabel;

  /// No description provided for @glossaryHandicapTitle.
  ///
  /// In ko, this message translates to:
  /// **'1. 핸디캡(Handicap, HCP)'**
  String get glossaryHandicapTitle;

  /// No description provided for @glossaryHandicapPurpose.
  ///
  /// In ko, this message translates to:
  /// **'목적: 실력 차이가 있는 경기에서 배당을 만들기 위해 \"가상의 점수 차\"를 미리 주고 시작하는 베팅 방식이다.'**
  String get glossaryHandicapPurpose;

  /// No description provided for @glossaryKeyConcept.
  ///
  /// In ko, this message translates to:
  /// **'핵심 개념'**
  String get glossaryKeyConcept;

  /// No description provided for @glossaryHandicapBullet1.
  ///
  /// In ko, this message translates to:
  /// **'강팀에게는 마이너스(-) 핸디캡을 줘서 가상으로 점수를 깎고,'**
  String get glossaryHandicapBullet1;

  /// No description provided for @glossaryHandicapBullet2.
  ///
  /// In ko, this message translates to:
  /// **'약팀에게는 플러스(+) 핸디캡을 줘서 가상으로 점수를 더해주는 것'**
  String get glossaryHandicapBullet2;

  /// No description provided for @glossaryHandicapBullet3.
  ///
  /// In ko, this message translates to:
  /// **'최종 점수에 핸디캡을 적용한 후 이긴 팀이 승리'**
  String get glossaryHandicapBullet3;

  /// No description provided for @glossaryExampleSoccer.
  ///
  /// In ko, this message translates to:
  /// **'예시 (축구)'**
  String get glossaryExampleSoccer;

  /// No description provided for @glossaryHandicapExample1.
  ///
  /// In ko, this message translates to:
  /// **'맨시티 vs 노팅엄 경기에서 맨시티 핸디캡 -1.5 선택'**
  String get glossaryHandicapExample1;

  /// No description provided for @glossaryHandicapExample2.
  ///
  /// In ko, this message translates to:
  /// **'경기 결과 2:0 → 핸디 적용 후 0.5:0 → 맨시티가 핸디캡 승리'**
  String get glossaryHandicapExample2;

  /// No description provided for @glossaryHandicapExample3.
  ///
  /// In ko, this message translates to:
  /// **'경기 결과 1:0 → 핸디 적용 후 -0.5:0 → 맨시티가 핸디캡 패배'**
  String get glossaryHandicapExample3;

  /// No description provided for @glossaryUnderOverTitle.
  ///
  /// In ko, this message translates to:
  /// **'2. 언더오버(Under/Over, U/O)'**
  String get glossaryUnderOverTitle;

  /// No description provided for @glossaryUnderOverPurpose.
  ///
  /// In ko, this message translates to:
  /// **'목적: 경기의 총 득점(양팀 합산)이 기준점보다 낮을지(Under) 높을지(Over)를 예측하는 베팅'**
  String get glossaryUnderOverPurpose;

  /// No description provided for @glossaryUnderOverBullet1.
  ///
  /// In ko, this message translates to:
  /// **'언더(Under): 기준점 미만일 것으로 예측'**
  String get glossaryUnderOverBullet1;

  /// No description provided for @glossaryUnderOverBullet2.
  ///
  /// In ko, this message translates to:
  /// **'오버(Over): 기준점 초과일 것으로 예측'**
  String get glossaryUnderOverBullet2;

  /// No description provided for @glossaryUnderOverExample1.
  ///
  /// In ko, this message translates to:
  /// **'기준점 2.5에서 경기 결과 2:1 (총 3골) → 오버 적중'**
  String get glossaryUnderOverExample1;

  /// No description provided for @glossaryUnderOverExample2.
  ///
  /// In ko, this message translates to:
  /// **'기준점 2.5에서 경기 결과 1:0 (총 1골) → 언더 적중'**
  String get glossaryUnderOverExample2;

  /// No description provided for @pointManagement.
  ///
  /// In ko, this message translates to:
  /// **'포인트 관리'**
  String get pointManagement;

  /// No description provided for @pointPolicyTitle.
  ///
  /// In ko, this message translates to:
  /// **'포인트 이용 정책 안내'**
  String get pointPolicyTitle;

  /// No description provided for @pointPolicy1.
  ///
  /// In ko, this message translates to:
  /// **'포인트는 현금으로 환전되거나 금전적 가치로 교환되지 않습니다. 회원 간 전달, 출금, 외부 결제 수단과의 교환은 불가능합니다.'**
  String get pointPolicy1;

  /// No description provided for @pointPolicy2.
  ///
  /// In ko, this message translates to:
  /// **'포인트는 서비스 내 전문가 분석 콘텐츠(Pick) 구매 용도로만 사용되며, 경기 결과에 따른 보상, 배당, 수익 분배와는 무관합니다.'**
  String get pointPolicy2;

  /// No description provided for @pointPolicy3.
  ///
  /// In ko, this message translates to:
  /// **'본 서비스의 포인트는 콘텐츠 이용을 위한 내부 결제 수단입니다.'**
  String get pointPolicy3;

  /// No description provided for @detailHistory.
  ///
  /// In ko, this message translates to:
  /// **'상세 내역'**
  String get detailHistory;

  /// No description provided for @chargeAmountHint.
  ///
  /// In ko, this message translates to:
  /// **'충전할 금액을 입력해주세요.'**
  String get chargeAmountHint;

  /// No description provided for @freePickRegister.
  ///
  /// In ko, this message translates to:
  /// **'무료픽 등록'**
  String get freePickRegister;

  /// No description provided for @matchSelection.
  ///
  /// In ko, this message translates to:
  /// **'경기 선택'**
  String get matchSelection;

  /// No description provided for @matchNotice.
  ///
  /// In ko, this message translates to:
  /// **'경기 시작 2일 전까지의 픽만 등록 가능합니다.'**
  String get matchNotice;

  /// No description provided for @analysisInfo.
  ///
  /// In ko, this message translates to:
  /// **'분석정보'**
  String get analysisInfo;

  /// No description provided for @enterTitle.
  ///
  /// In ko, this message translates to:
  /// **'제목을 입력해주세요'**
  String get enterTitle;

  /// No description provided for @enterAnalysis.
  ///
  /// In ko, this message translates to:
  /// **'분석 내용을 입력해주세요'**
  String get enterAnalysis;

  /// No description provided for @scoring.
  ///
  /// In ko, this message translates to:
  /// **'득점'**
  String get scoring;

  /// No description provided for @assist.
  ///
  /// In ko, this message translates to:
  /// **'도움'**
  String get assist;

  /// No description provided for @avgScore.
  ///
  /// In ko, this message translates to:
  /// **'평득'**
  String get avgScore;

  /// No description provided for @regularSeason.
  ///
  /// In ko, this message translates to:
  /// **'정규시즌'**
  String get regularSeason;

  /// No description provided for @year.
  ///
  /// In ko, this message translates to:
  /// **'년도'**
  String get year;

  /// No description provided for @countryName.
  ///
  /// In ko, this message translates to:
  /// **'국가명'**
  String get countryName;

  /// No description provided for @firstHalf.
  ///
  /// In ko, this message translates to:
  /// **'전반'**
  String get firstHalf;

  /// No description provided for @secondHalf.
  ///
  /// In ko, this message translates to:
  /// **'후반'**
  String get secondHalf;

  /// No description provided for @extraTime.
  ///
  /// In ko, this message translates to:
  /// **'연장'**
  String get extraTime;

  /// No description provided for @shootout.
  ///
  /// In ko, this message translates to:
  /// **'승부'**
  String get shootout;

  /// No description provided for @shooting.
  ///
  /// In ko, this message translates to:
  /// **'슈팅'**
  String get shooting;

  /// No description provided for @shotsOnTarget.
  ///
  /// In ko, this message translates to:
  /// **'유효슛'**
  String get shotsOnTarget;

  /// No description provided for @saves.
  ///
  /// In ko, this message translates to:
  /// **'세이브'**
  String get saves;

  /// No description provided for @offside.
  ///
  /// In ko, this message translates to:
  /// **'오프사이드'**
  String get offside;

  /// No description provided for @foul.
  ///
  /// In ko, this message translates to:
  /// **'파울'**
  String get foul;

  /// No description provided for @yellowCard.
  ///
  /// In ko, this message translates to:
  /// **'경고'**
  String get yellowCard;

  /// No description provided for @redCard.
  ///
  /// In ko, this message translates to:
  /// **'퇴장'**
  String get redCard;

  /// No description provided for @cornerKick.
  ///
  /// In ko, this message translates to:
  /// **'코너킥'**
  String get cornerKick;

  /// No description provided for @freeKick.
  ///
  /// In ko, this message translates to:
  /// **'프리킥'**
  String get freeKick;

  /// No description provided for @turnover.
  ///
  /// In ko, this message translates to:
  /// **'턴오버'**
  String get turnover;

  /// No description provided for @conceded.
  ///
  /// In ko, this message translates to:
  /// **'실점'**
  String get conceded;

  /// No description provided for @rebound.
  ///
  /// In ko, this message translates to:
  /// **'리바'**
  String get rebound;

  /// No description provided for @result.
  ///
  /// In ko, this message translates to:
  /// **'결과'**
  String get result;

  /// No description provided for @info.
  ///
  /// In ko, this message translates to:
  /// **'정보'**
  String get info;

  /// No description provided for @name.
  ///
  /// In ko, this message translates to:
  /// **'이름'**
  String get name;

  /// No description provided for @backNumber.
  ///
  /// In ko, this message translates to:
  /// **'백넘버'**
  String get backNumber;

  /// No description provided for @heightWeight.
  ///
  /// In ko, this message translates to:
  /// **'신장/몸무게'**
  String get heightWeight;

  /// No description provided for @send.
  ///
  /// In ko, this message translates to:
  /// **'전송'**
  String get send;

  /// No description provided for @verify.
  ///
  /// In ko, this message translates to:
  /// **'인증'**
  String get verify;

  /// No description provided for @textPlaceholder.
  ///
  /// In ko, this message translates to:
  /// **'텍스트홀더'**
  String get textPlaceholder;

  /// No description provided for @lotteryTypeSportsBetting.
  ///
  /// In ko, this message translates to:
  /// **'복권형 스포츠 배팅'**
  String get lotteryTypeSportsBetting;

  /// No description provided for @skillBasedSportsLottery.
  ///
  /// In ko, this message translates to:
  /// **'실력형 스포츠 복권'**
  String get skillBasedSportsLottery;

  /// No description provided for @sportsBetting.
  ///
  /// In ko, this message translates to:
  /// **'스포츠 베팅'**
  String get sportsBetting;

  /// No description provided for @viewOtherVersions.
  ///
  /// In ko, this message translates to:
  /// **'다른 버전 보기'**
  String get viewOtherVersions;

  /// No description provided for @selectVersion.
  ///
  /// In ko, this message translates to:
  /// **'버전 선택'**
  String get selectVersion;

  /// No description provided for @article1Purpose.
  ///
  /// In ko, this message translates to:
  /// **'제 1 조 (목적)'**
  String get article1Purpose;

  /// No description provided for @article2Effectiveness.
  ///
  /// In ko, this message translates to:
  /// **'제 2 조 (약관의 효력 및 변경)'**
  String get article2Effectiveness;

  /// No description provided for @article3Definitions.
  ///
  /// In ko, this message translates to:
  /// **'제 3 조 (용어의 정의)'**
  String get article3Definitions;

  /// No description provided for @article4Service.
  ///
  /// In ko, this message translates to:
  /// **'제 4 조 (서비스의 제공)'**
  String get article4Service;

  /// No description provided for @article5ServiceHours.
  ///
  /// In ko, this message translates to:
  /// **'제 5 조 (서비스 이용시간)'**
  String get article5ServiceHours;

  /// No description provided for @article4Contract.
  ///
  /// In ko, this message translates to:
  /// **'제 4 조 (이용 계약의 성립)'**
  String get article4Contract;

  /// No description provided for @article5Withdrawal.
  ///
  /// In ko, this message translates to:
  /// **'제 5 조 (회원 탈퇴 및 자격 상실)'**
  String get article5Withdrawal;

  /// No description provided for @article6ServiceSuspension.
  ///
  /// In ko, this message translates to:
  /// **'제 6 조 (서비스의 중단)'**
  String get article6ServiceSuspension;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In ko, this message translates to:
  /// **'스포츠 스코어 픽 개인정보처리방침'**
  String get privacyPolicyLink;

  /// No description provided for @teamInfo.
  ///
  /// In ko, this message translates to:
  /// **'팀 정보'**
  String get teamInfo;

  /// No description provided for @titleLabel.
  ///
  /// In ko, this message translates to:
  /// **'타이틀'**
  String get titleLabel;

  /// No description provided for @registrationComplete.
  ///
  /// In ko, this message translates to:
  /// **'등록 완료'**
  String get registrationComplete;

  /// No description provided for @freePickRegistered.
  ///
  /// In ko, this message translates to:
  /// **'무료픽이 등록되었습니다.'**
  String get freePickRegistered;

  /// No description provided for @starter.
  ///
  /// In ko, this message translates to:
  /// **'선발'**
  String get starter;

  /// No description provided for @substitute.
  ///
  /// In ko, this message translates to:
  /// **'교체'**
  String get substitute;

  /// No description provided for @memberReVerification.
  ///
  /// In ko, this message translates to:
  /// **'회원 재인증'**
  String get memberReVerification;

  /// No description provided for @reVerificationInfo.
  ///
  /// In ko, this message translates to:
  /// **'고객님의 정보보호와 안전한 서비스 이용을 위해 앱 재설치 및 데이터 삭제 시 재인증이 필요합니다.'**
  String get reVerificationInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In ko, this message translates to:
  /// **'휴대폰 번호'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In ko, this message translates to:
  /// **'전화번호를 입력해주세요'**
  String get enterPhoneNumber;

  /// No description provided for @enterVerificationCode.
  ///
  /// In ko, this message translates to:
  /// **'인증 번호를 입력해주세요.'**
  String get enterVerificationCode;

  /// No description provided for @purchasedPick.
  ///
  /// In ko, this message translates to:
  /// **'구매한 픽'**
  String get purchasedPick;

  /// No description provided for @alertedPick.
  ///
  /// In ko, this message translates to:
  /// **'알림한 픽'**
  String get alertedPick;

  /// No description provided for @offensiveComparison.
  ///
  /// In ko, this message translates to:
  /// **'공격력 비교'**
  String get offensiveComparison;

  /// No description provided for @defensiveComparison.
  ///
  /// In ko, this message translates to:
  /// **'수비력 비교'**
  String get defensiveComparison;

  /// No description provided for @homeVsAway.
  ///
  /// In ko, this message translates to:
  /// **'홈 vs 원정'**
  String get homeVsAway;

  /// No description provided for @matchDateLeague.
  ///
  /// In ko, this message translates to:
  /// **'경기일(리그)'**
  String get matchDateLeague;

  /// No description provided for @homeAdvantage.
  ///
  /// In ko, this message translates to:
  /// **'홈대 우세'**
  String get homeAdvantage;

  /// No description provided for @gifAnimationArea.
  ///
  /// In ko, this message translates to:
  /// **'GIF 애니메이션 영역'**
  String get gifAnimationArea;

  /// No description provided for @highlightGolScenes.
  ///
  /// In ko, this message translates to:
  /// **'경기 하이라이트, 골 장면 등'**
  String get highlightGolScenes;

  /// No description provided for @atMention.
  ///
  /// In ko, this message translates to:
  /// **'@멘션'**
  String get atMention;

  /// No description provided for @userSentNotification.
  ///
  /// In ko, this message translates to:
  /// **'님이 알림을 보냈습니다.'**
  String get userSentNotification;

  /// No description provided for @purchase.
  ///
  /// In ko, this message translates to:
  /// **'구매'**
  String get purchase;

  /// No description provided for @userWrittenContent.
  ///
  /// In ko, this message translates to:
  /// **'이용자가 작성한 글 노출'**
  String get userWrittenContent;

  /// No description provided for @defaultNickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임명'**
  String get defaultNickname;

  /// No description provided for @league.
  ///
  /// In ko, this message translates to:
  /// **'리그'**
  String get league;

  /// No description provided for @sampleTeamLiverpool.
  ///
  /// In ko, this message translates to:
  /// **'리버풀'**
  String get sampleTeamLiverpool;

  /// No description provided for @sampleTeamManUtd.
  ///
  /// In ko, this message translates to:
  /// **'맨체스터 유나이티드'**
  String get sampleTeamManUtd;

  /// No description provided for @termsArticle1Content.
  ///
  /// In ko, this message translates to:
  /// **'이 약관은 @@@@(이하 \"사이트\"라 합니다)에서 제공하는 인터넷서비스(이하 \"서비스\"라 합니다)의 이용 조건 및 절차에 관한 기본적인 사항을 규정함을 목적으로 합니다.'**
  String get termsArticle1Content;

  /// No description provided for @termsArticle2Item1.
  ///
  /// In ko, this message translates to:
  /// **'이 약관은 서비스 화면이나 기타의 방법으로 이용고객에게 공지함으로써 효력을 발생합니다.'**
  String get termsArticle2Item1;

  /// No description provided for @termsArticle2Item2.
  ///
  /// In ko, this message translates to:
  /// **'사이트는 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.'**
  String get termsArticle2Item2;

  /// No description provided for @termsArticle3Intro.
  ///
  /// In ko, this message translates to:
  /// **'이 약관에서 사용하는 용어의 정의는 다음과 같습니다.'**
  String get termsArticle3Intro;

  /// No description provided for @termsArticle3Item1.
  ///
  /// In ko, this message translates to:
  /// **'회원 : 사이트와 서비스 이용계약을 체결하거나 이용자 아이디(ID)를 부여받은 개인 또는 단체를 말합니다.'**
  String get termsArticle3Item1;

  /// No description provided for @termsArticle3Item2.
  ///
  /// In ko, this message translates to:
  /// **'신청자 : 회원가입을 신청하는 개인 또는 단체를 말합니다.'**
  String get termsArticle3Item2;

  /// No description provided for @termsArticle3Item3.
  ///
  /// In ko, this message translates to:
  /// **'아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 정하고 사이트가 승인하는 문자와 숫자의 조합을 말합니다.'**
  String get termsArticle3Item3;

  /// No description provided for @termsArticle3Item4.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 : 회원이 부여 받은 아이디(ID)와 일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.'**
  String get termsArticle3Item4;

  /// No description provided for @termsArticle4Intro.
  ///
  /// In ko, this message translates to:
  /// **'사이트는 다음과 같은 서비스를 제공합니다.'**
  String get termsArticle4Intro;

  /// No description provided for @termsArticle4Item1.
  ///
  /// In ko, this message translates to:
  /// **'스포츠 경기 정보 및 실시간 스코어 서비스'**
  String get termsArticle4Item1;

  /// No description provided for @termsArticle4Item2.
  ///
  /// In ko, this message translates to:
  /// **'예측 게임 및 포인트 적립 서비스'**
  String get termsArticle4Item2;

  /// No description provided for @termsArticle4Item3.
  ///
  /// In ko, this message translates to:
  /// **'커뮤니티 서비스'**
  String get termsArticle4Item3;

  /// No description provided for @termsArticle4Item4.
  ///
  /// In ko, this message translates to:
  /// **'기타 사이트가 정하는 서비스'**
  String get termsArticle4Item4;

  /// No description provided for @termsArticle5ContractItem1.
  ///
  /// In ko, this message translates to:
  /// **'이용계약은 이용자의 이용신청에 대하여 사이트가 승낙함으로써 성립합니다.'**
  String get termsArticle5ContractItem1;

  /// No description provided for @termsArticle5ContractItem2.
  ///
  /// In ko, this message translates to:
  /// **'이용계약의 성립 시기는 사이트가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.'**
  String get termsArticle5ContractItem2;

  /// No description provided for @termsArticle5WithdrawalItem1.
  ///
  /// In ko, this message translates to:
  /// **'회원은 사이트에 언제든지 탈퇴를 요청할 수 있으며, 사이트는 즉시 회원탈퇴를 처리합니다.'**
  String get termsArticle5WithdrawalItem1;

  /// No description provided for @sportsScorePickServiceTerms.
  ///
  /// In ko, this message translates to:
  /// **'스포츠 스코어 픽 서비스 이용약관'**
  String get sportsScorePickServiceTerms;

  /// No description provided for @termsArticle5ServiceHoursContent.
  ///
  /// In ko, this message translates to:
  /// **'서비스의 이용은 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다. 다만, 정기점검 등의 필요로 사이트가 정한 날이나 시간은 그러하지 아니합니다.'**
  String get termsArticle5ServiceHoursContent;

  /// No description provided for @termsArticle5WithdrawalItem2.
  ///
  /// In ko, this message translates to:
  /// **'회원이 다음 각 호의 사유에 해당하는 경우, 사이트는 회원자격을 제한 및 정지시킬 수 있습니다.'**
  String get termsArticle5WithdrawalItem2;

  /// No description provided for @termsArticle5WithdrawalItem3.
  ///
  /// In ko, this message translates to:
  /// **'가입 신청 시에 허위 내용을 등록한 경우'**
  String get termsArticle5WithdrawalItem3;

  /// No description provided for @termsArticle5WithdrawalItem4.
  ///
  /// In ko, this message translates to:
  /// **'다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우'**
  String get termsArticle5WithdrawalItem4;

  /// No description provided for @termsArticle6Content.
  ///
  /// In ko, this message translates to:
  /// **'사이트는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다. 이 경우 사이트는 회원에게 통지합니다.'**
  String get termsArticle6Content;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
