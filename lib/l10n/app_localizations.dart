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
