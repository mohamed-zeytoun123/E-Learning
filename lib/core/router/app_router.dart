import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/features/Video/presentation/pages/video_playing_page.dart';
import 'package:e_learning/features/chapter/presentation/pages/chapter_page.dart';
import 'package:e_learning/features/chapter/presentation/pages/quiz_page.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/pages/cource_info_page.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/pages/forget_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/log_in_page.dart';
import 'package:e_learning/features/auth/presentation/pages/otp_page.dart';
import 'package:e_learning/features/auth/presentation/pages/reset_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/sign_up_page.dart';
import 'package:e_learning/features/auth/presentation/pages/university_selection_page.dart';
import 'package:e_learning/features/home/presentation/pages/article_details.dart';
import 'package:e_learning/features/home/presentation/pages/main_home_page.dart';
import 'package:e_learning/features/home/presentation/pages/search_page.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/home/presentation/pages/teatcher_page.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_articles.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_teachers.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_courses.dart';
import 'package:e_learning/features/enroll/presentation/pages/enroll_page.dart';
import 'package:e_learning/features/profile/presentation/pages/downloads_page.dart';
import 'package:e_learning/features/profile/presentation/pages/profile_page.dart';
import 'package:e_learning/features/profile/presentation/pages/saved_courses_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e_learning/features/Course/presentation/pages/courses_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.mainHomePage,
    routes: [
      GoRoute(
        path: RouteNames.selectedMethodLogin,
        //?--------------------------------------------------------------------------
        // builder: (context, state) => const SelectedMethodLogInPage(), //! base
        builder: (context, state) => CoursesPage(),
        //?--------------------------------------------------------------------------
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(repository: appLocator<AuthRepository>()),
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.logIn,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(repository: appLocator<AuthRepository>()),
          child: LogInPage(),
        ),
      ),

      //?-----  Viedeo Featchers   --------------------------------------------------------------
      GoRoute(
        path: RouteNames.viedioPage,
        builder: (context, state) => const VideoPlayingPage(),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.universitySelection,
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final blocProvider = args["blocProvide"] as AuthCubit;
          final phone = args["phone"] as String;
          return BlocProvider.value(
            value: blocProvider,
            child: UniversitySelectionPage(phone: phone),
          );
        },
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.otpScreen,
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final blocProvider = args["blocProvide"] as AuthCubit;
          final phone = args["phone"] as String;
          final purpose = args["purpose"] as String;
          return BlocProvider.value(
            value: blocProvider,
            child: OtpPage(phone: phone, purpose: purpose),
          );
        },
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.forgetPassword,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(repository: appLocator<AuthRepository>()),
          child: ForgetPasswordPage(),
        ),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.searchPage,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: RouteNames.teatcherPage,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          final teacher = args?['teacher'] as TeacherModel?;
          return BlocProvider(
            create: (context) =>
                CourseCubit(repo: appLocator<CourceseRepository>()),
            child: TeatcherPage(teacher: teacher),
          );
        },
      ),
      GoRoute(
        path: RouteNames.mainHomePage,
        builder: (context, state) => const MainHomePage(),
      ),
      GoRoute(
        path: RouteNames.aticleDetails,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          final articleId = args?['articleId'] as int?;
          if (articleId == null) {
            // Handle case where articleId is not provided
            return Scaffold(
              appBar: AppBar(title: Text("news".tr())),
              body: Center(child: Text('article_not_found'.tr())),
            );
          }
          return BlocProvider(
            create: (context) =>
                ArticleCubit(repo: appLocator<ArticleRepository>())
                  ..getArticleDetails(articleId: articleId),
            child: ArticleDetailsPage(articleId: articleId),
          );
        },
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final phone = args["phone"] as String;
          final resetToken = args["resetToken"] as String;

          return BlocProvider<AuthCubit>(
            create: (context) =>
                AuthCubit(repository: appLocator<AuthRepository>()),
            child: ResetPasswordPage(phone: phone, resetToken: resetToken),
          );
        },
      ),

      //?------ Course Featchers -------------------------------------------------------------
      GoRoute(
        path: RouteNames.courses,
        builder: (context, state) => const CoursesPage(),
      ),
      GoRoute(
        path: RouteNames.viewAllArticles,
        builder: (context, state) => const ViewAllArticles(),
      ),
      GoRoute(
        path: RouteNames.viewAllTeachers,
        builder: (context, state) => const ViewAllTeachers(),
      ),
      GoRoute(
        path: RouteNames.viewAllCourses,
        builder: (context, state) => const ViewAllCourses(),
      ),

      GoRoute(
        path: RouteNames.courceInf,
        name: RouteNames.courceInf,
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final courseSlug = args["courseSlug"] as String;

          final courseCubit = args["courseCubit"] as CourseCubit;

          return BlocProvider.value(
            value: courseCubit,
            child: CourceInfoPage(courseSlug: courseSlug),
          );
        },
      ),

      //?----- Chapter Featchers  --------------------------------------------------------------
      GoRoute(
        path: RouteNames.chapterPage,
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final courseSlug = args["courseSlug"] as String;
          final courseTitle = args["courseTitle"] as String;
          final courseImage = args["courseImage"] as String;
          final chapterId = args["chapterId"] as int;
          final index = args["index"] as int;
          final isActive = args["isActive"] as bool;
          return ChapterPage(
            isActive: isActive,
            courseSlug: courseSlug,
            chapterId: chapterId,
            courseImage: courseImage,
            courseTitle: courseTitle,
            index: index,
          );
        },
      ),

      GoRoute(
        path: RouteNames.quizPage,
        builder: (context, state) => const QuizPage(),
      ),

      //? --------------------------- Profile Pages --------------------------
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.savedCourses,
        builder: (context, state) => const SavedCoursesPage(),
      ),
      GoRoute(
        path: RouteNames.downloads,
        builder: (context, state) => const DownloadsPage(),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.enroll,
        builder: (context, state) => const EnrollPage(),
      ),
    ],
  );
}
