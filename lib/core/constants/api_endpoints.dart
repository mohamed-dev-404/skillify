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
  static const String getProfile = '/profile';
  // static const String updateProfile = 'users/profile';
  // static const String createUploadUrl = 'users/profile-picture/presigned-url';
  // static const String saveProfilePic = 'users/profile-picture';
}
