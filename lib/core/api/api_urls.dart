class AppUrls {
  static const String _ip =
      "192.168.1.240"; // Change this to your computer's actual IP

  static const String baseURl = 'http://$_ip:8100/api/v1';

  static const String drmKey = 'PVqK16VcxqZLwrQs4iflv6MUikMMtRsY0BkVPbNPxBg=';

  static final String login = "$baseURl/auth/login";
  static final String signUp = "$baseURl/auth/register";
  static final String logOut = "$baseURl/auth/logout";
  static final String verifyOtp = "$baseURl/auth/verify-otp";
  static final String verifyForgotPasswordOtp = "$baseURl/auth/forgot/verify";
  static final String forgetPassword = "$baseURl/auth/forgot/start";
  static final String resetPassword = "$baseURl/auth/forgot/reset";

  //?------------------- Refresh Token -------------------

  static final String refreashToken = "$baseURl/auth/refresh";

  static final String getUniversities = "$baseURl/universities/";

  static final String getColleges = "$baseURl/colleges/";

  static final String getCategories = "$baseURl/categories/";

  //?------------------- Courses -------------------

  // static final String getCourses =
  //     "$_baseURl/courses/?college=&study_year=&category=&teacher=&search=&ordering=-created_at";

  static String getCourses({Map<String, dynamic>? queryParameters}) {
    String url = "$baseURl/courses/";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => "${e.key}=${Uri.encodeComponent(e.value.toString())}")
          .join("&");
      url = "$url?$queryString";
    }
    return url;
  }

  static final String getStudyYears = "$baseURl/study-years/";

  static String courseDetails(String courseSlug) =>
      "$baseURl/courses/$courseSlug/";

  // static String getChapters(String courseSlug) =>
  //     '$_baseURl/courses/$courseSlug/chapters/';
  static String getChapters(
    String courseId, {
    Map<String, dynamic>? queryParameters,
  }) {
    String url = "$baseURl/courses/$courseId/chapters/";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => "${e.key}=${Uri.encodeComponent(e.value.toString())}")
          .join("&");
      url = "$url?$queryString";
    }
    return url;
  }

  static String addRating(String courseId) =>
      "$baseURl/courses/$courseId/ratings/";

  static String getRatings(
    String courseId, {
    Map<String, dynamic>? queryParameters,
  }) {
    String url = '$baseURl/courses/$courseId/ratings/';

    if (queryParameters != null && queryParameters.isNotEmpty) {
      final qp =
          queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&');
      url = '$url?$qp';
    }

    return url;
  }

  static String getChapterById(String courseId, String chapterId) =>
      "$baseURl/courses/$courseId/chapters/$chapterId/";

  static String favoriteCourse(String courseSlug) =>
      "$baseURl/courses/$courseSlug/favorite/";

  static String getChapterAttachments(int chapterId) =>
      "$baseURl/chapters/$chapterId/attachments/";

  static String getVideos({required int chapterId, int page = 1}) {
    return "$baseURl/videos/?chapter_id=$chapterId&page=$page";
  }

  //?------------------- Quizzes -------------------

  static String getQuizByChapter(String chapterId) =>
      "$baseURl/chapters/$chapterId/quiz/";

  static String startQuiz(int quizId) => "$baseURl/quizzes/$quizId/start/";

  static String submitQuizAnswer(int quizId) =>
      "$baseURl/quiz-attempts/$quizId/submit-answer/";

  static String submitCompletedQuiz(int attemptId) =>
      "$baseURl/quiz-attempts/$attemptId/submit/";

  //?------------------- Enrollment -------------------

  static final String enrollCourse = "$baseURl/enrollments/enroll/";
  
  static final String myCourses = "$baseURl/enrollments/my-courses/";
  
  static String courseRating(String courseSlug) =>
      "$baseURl/courses/$courseSlug/ratings/";

  //?------------------- Video -------------------

  static String getSecureVideoUrl(String videoId) =>
      "$baseURl/videos/$videoId/streaming-url/";

  static String downloadVideo(String videoId) =>
      "$baseURl/videos/$videoId/download/";

  static String updateVideoProgress(int videoId) =>
      "$baseURl/videos/$videoId/progress/";

  static String getVideoComments(int videoId, {int page = 1}) =>
      "$baseURl/videos/$videoId/comments/?page=$page";

  static String addVideoComment(int videoId) =>
      "$baseURl/videos/$videoId/comments/";

  static final String getTeachers = "$baseURl/teachers/";

  static final String getArticles = "$baseURl/articles/";

  static String articleDetails(String articleSlug) =>
      "$baseURl/articles/$articleSlug/";

  static String relatedArticles(int articleId) =>
      "$baseURl/articles/$articleId/related/";

  static final String privacyPolicy = "$baseURl/privacy-policy/";
  static final String aboutUs = "$baseURl/about-us/";
  static final String termsConditions = "$baseURl/terms-conditions/";
  static final String profileUserInfo = "$baseURl/profile/";
  static final String saveCourses = "$baseURl/my-favorites/";

  static final String getAdvertisements = "$baseURl/advertisements/";

  static final String getChannels = "$baseURl/channels/";
}
