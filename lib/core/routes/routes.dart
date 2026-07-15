class Routes {
  Routes._();

  //* splash and welcome routes
  static const String splash = '/';

  //* Auth routes
  static const String login = '/login';
  static const String register = '/register';

  //* Complete profile routes
  static const String completeProfile = '/complete-profile';

  //* Main routes
  static const String main = '/main';

  //* Explore routes
  static const String publicProfilePath = '/public-profile/:userId';
  static String publicProfile(int userId) => '/public-profile/$userId';
}
