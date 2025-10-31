class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.1.101";

  //?---------------------------------------------------------------

  static const String _baseURl = 'http://$_ip:8100/api/v1';

  //?---------------------------------------------------------------

  //* Auth
  static final String login = "$_baseURl/auth/login";
  static final String signUp = "$_baseURl/auth/register";
  static final String logOut = "$_baseURl/auth/logout";
  static final String verifyOtp = "$_baseURl/auth/verify-otp";
  static final String verifyForgotPasswordOtp = "$_baseURl/auth/forgot/verify";
  static final String forgetPassword = "$_baseURl/auth/forgot/start";
  static final String resetPassword = "$_baseURl/auth/forgot/reset";

  //?------------------- Refresh Token -------------------

  //* Refresh Token
  static final String refreashToken = "$_baseURl/auth/refresh";

  //?------------------- Universities & Colleges -------------------
  //* Get University
  static final String getUniversities = "$_baseURl/universities/";

  //* Get Colleges
  static final String getColleges = "$_baseURl/colleges/";

  //* Get Categories
  static final String getCategories = "$_baseURl/categories/";

  //?------------------- Courses -------------------

  //* Get Courses
  static final String getCourses =
      "$_baseURl/courses/?college=&study_year=&category=&teacher=&search=&ordering=-created_at";

  //* Get Course Details by Slug
  static String courseDetails(String courseSlug) =>
      "$_baseURl/courses/$courseSlug/";

  //* Get Chapters by Course ID
  static String getChapters(String courseSlug) =>
      '$_baseURl/courses/$courseSlug/chapters/';

  //* Get Ratings
  static String getRatings(String courseSlug) =>
      '$_baseURl/courses/$courseSlug/ratings/?ordering=-created_at';

  //* Get Chapter by ID
  static String getChapterById(String courseSlug, int chapterId) =>
      "$_baseURl/courses/$courseSlug/chapters/$chapterId/";

  //?---------------------------------------------------------------
}
