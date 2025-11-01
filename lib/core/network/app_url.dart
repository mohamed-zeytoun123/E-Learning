class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.100.23";

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

  //* Refresh Token
  static final String refreashToken = "$_baseURl/auth/refresh";

  //* Get University
  static final String getUniversities = "$_baseURl/universities/";

  //* Get Colleges
  static final String getColleges = "$_baseURl/colleges/";

  //* Enrollments
  static final String myCourses = "$_baseURl/enrollments/my-courses/";

  //* Course Ratings
  static String courseRating(String courseSlug) => "$_baseURl/courses/$courseSlug/ratings/";

  //?---------------------------------------------------------------
}
