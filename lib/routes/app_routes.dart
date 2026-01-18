class AppRoutes {
  AppRoutes._();

  // Root
  static const String splash = '/';
  static const String main = '/main';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Live
  static const String live = '/live';
  static const String matchDetail = '/match/:id';
  static const String teamDetail = '/team/:id';
  static const String playerDetail = '/player/:id';

  // Proto
  static const String proto = '/proto';

  // Pick (픽전문가)
  static const String pick = '/pick';
  static const String expertDetail = '/expert/:id';
  static const String pickDetail = '/pick/:id';

  // Community
  static const String community = '/community';
  static const String postDetail = '/post/:id';
  static const String postWrite = '/post/write';

  // Ranking
  static const String ranking = '/ranking';
  static const String userProfile = '/user/:id';

  // My Page
  static const String myPage = '/my';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String myPicks = '/my/picks';
  static const String myPosts = '/my/posts';
  static const String myComments = '/my/comments';
  static const String myFavorites = '/my/favorites';
  static const String editProfile = '/my/edit';
}
