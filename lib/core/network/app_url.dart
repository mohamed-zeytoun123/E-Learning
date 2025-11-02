class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.100.23";
//  static const String _local = "10.0.2.2";
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

  //*profile Url
  static final String privacyPolicy = "$_baseURl/privacy-policy/";
  static final String aboutUs = "$_baseURl/about-us/";
    static final String termsConditions = "$_baseURl/terms-conditions/";
  //?---------------------------------------------------------------
}
