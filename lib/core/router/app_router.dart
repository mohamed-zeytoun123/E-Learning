import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/features/Course/presentation/pages/cource_info_page.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/pages/forget_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/log_in_page.dart';
import 'package:e_learning/features/auth/presentation/pages/otp_page.dart';
import 'package:e_learning/features/auth/presentation/pages/reset_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/sign_up_page.dart';
import 'package:e_learning/features/auth/presentation/pages/university_selection_page.dart';
import 'package:e_learning/features/home/presentation/pages/main_home_page.dart';
import 'package:e_learning/features/home/presentation/pages/news_articles_page.dart';
import 'package:e_learning/features/profile/presentation/pages/profile_page.dart';
import 'package:e_learning/features/home/presentation/pages/home_page.dart';
import 'package:e_learning/features/home/presentation/pages/home_page_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e_learning/features/Course/presentation/pages/courses_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    // initialLocation: RouteNames.selectedMethodLogin,
    initialLocation: RouteNames.homePage,
    routes: [
      GoRoute(
        path: RouteNames.selectedMethodLogin,
        //?--------------------------------------------------------------------------
        // builder: (context, state) => const SelectedMethodLogInPage(), //! base
        builder: (context, state) => const CourceInfoPage(),
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
        path: RouteNames.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.homePage,
        builder: (context, state) => const MainHomePage(),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.articlesAndNews,
        builder: (context, state) => const NewsArticlesPage(),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.courses,
        builder: (context, state) => const CoursesPage(),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.courceInf,
        builder: (context, state) => const CourceInfoPage(),
      ),

      //?-------------------------------------------------------------------
      //?-------------------------- Profile Page -------------------------------
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
