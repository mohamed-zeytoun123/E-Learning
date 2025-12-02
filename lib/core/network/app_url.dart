class AppUrls {
  //?---------------------------------------------------------------

  // static const String _ip = "";
  // static const String _ip = "192.168.1.22";
  static const String _ip = "192.168.1.100";

  //?---------------------------------------------------------------

  static const String baseURl = 'http://$_ip:8100/api/v1';
  // static const String baseURl = 'https://elearning.onedoorit.com';
  // https://elearning.onedoorit.com/

  //?---------------------------------------------------------------

  static const String drmKey = 'PVqK16VcxqZLwrQs4iflv6MUikMMtRsY0BkVPbNPxBg=';

  //?---------------------------------------------------------------

  //* Auth
  static final String login = "$baseURl/auth/login";
  static final String signUp = "$baseURl/auth/register";
  static final String logOut = "$baseURl/auth/logout";
  static final String verifyOtp = "$baseURl/auth/verify-otp";
  static final String verifyForgotPasswordOtp = "$baseURl/auth/forgot/verify";
  static final String forgetPassword = "$baseURl/auth/forgot/start";
  static final String resetPassword = "$baseURl/auth/forgot/reset";

  //?------------------- Refresh Token -------------------

  //* Refresh Token
  static final String refreashToken = "$baseURl/auth/refresh";

  //?------------------- Universities & Colleges -------------------
  //* Get University
  static final String getUniversities =
      "$baseURl/universities/?page=1&page_size=10000";

  //* Get Colleges
  static final String getColleges = "$baseURl/colleges/";

  //* Get Categories
  static final String getCategories = "$baseURl/categories/";

  //?------------------- Courses -------------------

  //* Get Courses as function to accept query params
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

  //* Get Study Years
  static final String getStudyYears =
      "$baseURl/study-years/?page=1&page_size=10000";

  //* Get Course Details by Slug
  static String courseDetails(String courseSlug) =>
      "$baseURl/courses/$courseSlug/";

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

  //* Add Rating
  static String addRating(String courseId) =>
      "$baseURl/courses/$courseId/ratings/";

  static String getRatings(
    String courseId, {
    Map<String, dynamic>? queryParameters,
  }) {
    String url = '$baseURl/courses/$courseId/ratings/';

    if (queryParameters != null && queryParameters.isNotEmpty) {
      final qp = queryParameters.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      url = '$url?$qp';
    }

    return url;
  }

  //* Get Chapter by ID
  static String getChapterById(String courseId, String chapterId) =>
      "$baseURl/courses/$courseId/chapters/$chapterId/";

  //* Add/Remove Favorite for a Course
  static String favoriteCourse(String courseSlug) =>
      "$baseURl/courses/$courseSlug/favorite/";

  //* Get Attachments for a Chapter
  static String getChapterAttachments(int chapterId) =>
      "$baseURl/chapters/$chapterId/attachments/";

  //* Get list of videos for a chapter with pagination
  static String getVideos({required int chapterId, int page = 1}) {
    return "$baseURl/videos/?chapter_id=$chapterId&page=$page";
  }

  //?------------------- Quizzes -------------------
  //* step 1 : Get Quiz By Chapter ID
  static String getQuizByChapter(String chapterId) =>
      "$baseURl/chapters/$chapterId/quiz/";

  //* Step 2 : Start Quiz
  static String startQuiz(int quizId) => "$baseURl/quizzes/$quizId/start/";

  //* Step 3 : Submit Quiz Answer
  static String submitQuizAnswer(int quizId) =>
      "$baseURl/quiz-attempts/$quizId/submit-answer/";

  //* Step 4 : Submit Completed Quiz (final submit and grading)
  static String submitCompletedQuiz(int attemptId) =>
      "$baseURl/quiz-attempts/$attemptId/submit/";

  //?------------------- Enrollment -------------------
  //* Enroll in a Course
  static final String enrollCourse = "$baseURl/enrollments/enroll/";

  //?------------------- Video -------------------
  //* Get Secure Video Streaming URL
  static String getSecureVideoUrl(String videoId) =>
      "$baseURl/videos/$videoId/streaming-url/";

  //* Download Video File
  static String downloadVideo(String videoId) =>
      "$baseURl/videos/$videoId/download/";

  //* Update Video Progress
  static String updateVideoProgress(int videoId) =>
      "$baseURl/videos/$videoId/progress/";

  //?------------------- Comments -------------------

  //* Get Comments for a Video
  static String getVideoComments(int videoId, {int page = 1}) =>
      "$baseURl/videos/$videoId/comments/?page=$page";

  //* Add Comment to Video
  static String addVideoComment(String videoId) =>
      "$baseURl/videos/$videoId/comments/";

  //* Reply to a Comment
  static String replyToComment(int commentId) =>
      "$baseURl/comments/$commentId/reply/";

  //?------------------- Channels -------------------
  //* Get All Channels
  static final String getChannels = "$baseURl/channels/";

  //?---------------------------------------------------------------
}
