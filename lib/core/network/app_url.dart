class AppUrls {
  static const String _baseURl = 'http://192.168.1.105:8010/api';

  //?---------------------------------------------------------------

  //* Auth
  static final String login = "$_baseURl/auth/login";
  static final String signUp = "$_baseURl/auth/register";
  static final String logOut = "$_baseURl/auth/logout";

  //* Refresh Token
  static final String refreashToken = "$_baseURl/auth/refresh";

  //?---------------------------------------------------------------
}
