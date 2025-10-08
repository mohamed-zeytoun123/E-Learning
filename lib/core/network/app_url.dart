class AppUrls {
  static final String _baseUrl = "http://94.72.98.154/abdulrahim/public/api";
  static final String login = "$_baseUrl/auth/login";
  static final String signUp = "$_baseUrl/auth/register";
  
  //* home
  static String getTopSalon = "$_baseUrl/branches?top=1";
  static String getNearest = "$_baseUrl/branches?nearest=1";
  static String getNearestFetchSalon = "$_baseUrl/branches?nearest=1&type=2";
  static String getNearestFetchFreelance =
      "$_baseUrl/branches?nearest=1&type=1";
  static String getSliders = "$_baseUrl/sliders";
  static String getProducts = "$_baseUrl/products";
  static String getServices = "$_baseUrl/services";
}
