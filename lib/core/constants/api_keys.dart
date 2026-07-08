//! --- JSON KEYS (The names that Dio sends and receives) ---

class ApiKeys {
  ApiKeys._();

  //? --- Common Response & General Keys ---
  static const String data = 'data';
  static const String errors = 'errors';
  static const String error = 'error';
  static const String message = 'message';
  static const String id = 'id';
  static const String status = 'status';
  static const String name = 'name';
  static const String fullName = 'fullName';
  static const String description = 'description';
  static const String slug = 'slug';
  static const String iconKey = 'iconKey';
  static const String subSkills = 'subSkills';

  //? User Model Keys
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordComfirmation = 'password_confirmation';
  static const String profilePic = 'profilePic';
  static const String role = 'role';
  static const String address = 'address';
  static const String city = 'city';
  static const String phone = 'phone';
  static const String image = 'image';

  //? Pagination Keys
  static const String pagination = 'pagination';
  static const String totalElements = 'totalElements';
  static const String currentPage = 'currentPage';
  static const String size = 'size';
  static const String totalPages = 'totalPages';
  static const String hasNextPage = 'hasNextPage';
  static const String hasPrevPage = 'hasPrevPage';

  //? Fetch Users Params Keys
  static const String page = 'page';
  static const String sortBy = 'sortBy';
  static const String sortOrder = 'sortOrder';
  static const String search = 'search';

  //? Auth Keys
  static const String authorization = 'Authorization';
  static const String user = 'user';
  static const String token = 'token';
  static const String expiresIn = 'expiresIn';
  static const String refreshToken = 'refreshToken';
  static const String accessToken = 'accessToken';
  static const String resetToken = 'resetToken';
  static const String accessTokenExpiresInSeconds =
      'accessTokenExpiresInSeconds';
  static const String accessTokenExpiresAt = 'accessTokenExpiresAt';
  static const String refreshTokenExpiresAt = 'refreshTokenExpiresAt';
  static const String code = 'code';
  static const String action = 'action';
  static const String newPassword = 'newPassword';
  static const String confirmNewPassword = 'confirmNewPassword';
  static const String roles = 'roles';
  static const String student = 'student';
  static const String confirmPassword = 'confirmPassword';

  //? Complete Profile form-data keys (PascalCase — as the API multipart expects)
  static const String profilePictureForm = 'ProfilePicture';
  static const String bioForm = 'Bio';
  static const String jobTitleForm = 'JobTitle';
  static const String offeredMainSkillForm = 'OfferedMainSkill';
  static const String offeredSubSkillsForm = 'OfferedSubSkills';
  static const String offeredDescriptionForm = 'OfferedDescription';
  static const String neededSkillsForm = 'NeededSkills';
  static const String languageIdsForm = 'LanguageIds';
  static const String mainSkillIdForm = 'mainSkillId';
  static const String subSkillIdsForm = 'subSkillIds';
}

//! --- API VALUES (Fixed values that the server expects inside the fields) ---

class ApiValues {
  ApiValues._();

  static const String bearer = 'Bearer';
}
