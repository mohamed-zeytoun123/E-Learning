class AppUrls {
  //?---------------------------------------------------------------

  static const String _ip = "192.168.1.102";

  //?---------------------------------------------------------------

  static const String baseURl = 'http://$_ip:8100/api/v1';

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
  static final String getUniversities = "$baseURl/universities/";

  //* Get Colleges
  static final String getColleges = "$baseURl/colleges/";

  //* Get Categories
  static final String getCategories = "$baseURl/categories/";

  //?------------------- Courses -------------------

  //* Get Courses
  // static final String getCourses =
  //     "$_baseURl/courses/?college=&study_year=&category=&teacher=&search=&ordering=-created_at";

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
  static final String getStudyYears = "$baseURl/study-years/";

  //* Get Course Details by Slug
  static String courseDetails(String courseSlug) =>
      "$baseURl/courses/$courseSlug/";

  //* Get Chapters by Course ID
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

  //?------------------- Quizzes -------------------
  //* step 1 : Get Quiz By Chapter ID
  static String getQuizByChapter(String chapterId) =>
      "$baseURl/chapters/$chapterId/quiz/";

  //* Step 2 : Start Quiz
  static String startQuiz(int quizId) => "$baseURl/quizzes/$quizId/start/";

  //* Step 3 : Submit Quiz Answer
  static String submitQuizAnswer(int quizId) =>
      "$baseURl/quiz-attempts/$quizId/submit-answer/";

  //?------------------- Enrollment -------------------
  //* Enroll in a Course
  static final String enrollCourse = "$baseURl/enrollments/enroll/";
  //?---------------------------------------------------------------
}
