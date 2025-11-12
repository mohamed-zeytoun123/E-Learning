class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.1.1";
  static const String _local = "10.0.2.2";
  //?---------------------------------------------------------------

  static const String _baseURl = 'http://$_ip:8100/api/v1';

  //?---------------------------------------------------------------

  //* Auth
  static final String login = "$_baseURl/auth/login";
  static final String signUp = "$_baseURl/auth/register"; //auth/logout
  static final String logOut = "$_baseURl/auth/logout";
  static final String verifyOtp = "$_baseURl/auth/verify-otp";
  static final String verifyForgotPasswordOtp = "$_baseURl/auth/forgot/verify";
  static final String forgetPassword = "$_baseURl/auth/forgot/start";
  static final String resetPassword = "$_baseURl/auth/forgot/reset";

  //* Refresh Token
  static final String refreashToken = "$_baseURl/auth/refresh";

  //* Get University
  static final String getUniversities = "$_baseURl/universities/";

  //* Get Colleges
  static final String getColleges = "$_baseURl/colleges/";

  //* Get Categories
  static final String getCategories = "$_baseURl/categories/";

  //* Get Courses as function to accept query params
  static String getCourses({Map<String, dynamic>? queryParameters}) {
    String url = "$_baseURl/courses/";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => "${e.key}=${Uri.encodeComponent(e.value.toString())}")
          .join("&");
      url = "$url?$queryString";
    }
    return url;
  }

  //* Get Study Years
  static final String getStudyYears = "$_baseURl/study-years/";

  //* Get Course Details by Slug
  static String courseDetails(String courseSlug) =>
      "$_baseURl/courses/$courseSlug/";

  //* Get Chapters by Course ID
  static String getChapters(
    String courseSlug, {
    Map<String, dynamic>? queryParameters,
  }) {
    String url = "$_baseURl/courses/$courseSlug/chapters/";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => "${e.key}=${Uri.encodeComponent(e.value.toString())}")
          .join("&");
      url = "$url?$queryString";
    }
    return url;
  }

  //* Get Ratings
  static String getRatings(String courseSlug) =>
      '$_baseURl/courses/$courseSlug/ratings/?ordering=-created_at';

  //* Get Chapter by ID
  static String getChapterById(String courseSlug, int chapterId) =>
      "$_baseURl/courses/$courseSlug/chapters/$chapterId/";

  //* Add/Remove Favorite for a Course
  static String favoriteCourse(String courseSlug) =>
      "$_baseURl/courses/$courseSlug/favorite/";

  //* Get Teachers
  static final String getTeachers = "$_baseURl/teachers/";

  //* Get Articles
  static final String getArticles = "$_baseURl/articles/";

  //* Get Article Details by Slug
  static String articleDetails(String articleSlug) =>
      "$_baseURl/articles/$articleSlug/";

  //* Get Related Articles by Article ID
  static String relatedArticles(int articleId) =>
      "$_baseURl/articles/$articleId/related/";

  //*profile Url
  static final String privacyPolicy = "$_baseURl/privacy-policy/";
  static final String aboutUs = "$_baseURl/about-us/";
  static final String termsConditions = "$_baseURl/terms-conditions/";
  static final String profileUserInfo = "$_baseURl/profile/";
  
  //?---------------------------------------------------------------
}
