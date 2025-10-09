class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.1.103";

  //?---------------------------------------------------------------

  static const String _baseURl = 'http://$_ip:8100/api/v1';

  //?---------------------------------------------------------------

  //* Auth
  static final String login = "$_baseURl/auth/login";
  static final String signUp = "$_baseURl/auth/register";
  static final String logOut = "$_baseURl/auth/logout";

  //* Refresh Token
  static final String refreashToken = "$_baseURl/auth/refresh";

  //?---------------------------------------------------------------
}
