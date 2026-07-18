class EndPoints {
  EndPoints._();

  //! EndPoints

  //? --- Auth  --- ;
  static String login = '/Users/login';
  static String register = '/Users/register';
  static String refresh = '/Users/refresh';
  static const String logout = '/Users/logout';

  // //? --- Home  --- ;
  // //* Instructor endpoints
  static const String getSliders = '/sliders';
  static const String getBestSeller = '/products-bestseller';
  // static String unenrollCourse(String courseId) =>
  //     'enrollments/my-courses/$courseId';

  //? --- Profile  --- ;
  static const String getProfile = '/Users/me';
  static const String completeProfile = '/Users/me/profile';
  static const String updateProfilePicture = '/Users/me/profile-picture';

  //? --- Explore  --- ;
  static const String getUsers = '/Users';
  static String getUserById(int id) => '/Users/$id';
  static const String requestSession = '/Sessions/request';
  static const String offerSession = '/Sessions/offer';

  //? --- Lookups  --- ;
  static const String getLanguages = '/Languages';
  static const String getMainSkillsWithSubSkills = '/MainSkills/with-subskills';

  //? --- Wallet  --- ;
  static const String creditTransactionHistory = '/CreditTransactions/history';

  //? --- Notifications  --- ;
  static const String getNotifications = '/Notifications';
  static const String unreadNotificationsCount =
      '/Notifications/unread-count';
}
