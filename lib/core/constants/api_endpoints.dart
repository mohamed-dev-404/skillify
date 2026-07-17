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

  //? --- Lookups  --- ;
  static const String getLanguages = '/Languages';
  static const String getMainSkillsWithSubSkills = '/MainSkills/with-subskills';

  //? --- Sessions --- ;
  static const String getRequestedSessions = '/api/Sessions/requested';
  static const String getReceivedSessions = '/api/Sessions/received';
  static String sessionById(int sessionId) => '/api/Sessions/$sessionId';
  static String zegoToken(int sessionId) =>
      '/api/Sessions/$sessionId/zego-token';
  static String acceptSession(int sessionId) =>
      '/api/Sessions/$sessionId/accept';
  static String declineSession(int sessionId) =>
      '/api/Sessions/$sessionId/decline';
  static String cancelSession(int sessionId) =>
      '/api/Sessions/$sessionId/cancel';
  static String rescheduleSession(int sessionId) =>
      '/api/Sessions/$sessionId/reschedule';
}
