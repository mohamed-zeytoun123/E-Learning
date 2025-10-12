import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/pages/forget_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/log_in_page.dart';
import 'package:e_learning/features/auth/presentation/pages/otp_page.dart';
import 'package:e_learning/features/auth/presentation/pages/reset_password_page.dart';
import 'package:e_learning/features/auth/presentation/pages/selected_method_log_in_age.dart';
import 'package:e_learning/features/auth/presentation/pages/sign_up_page.dart';
import 'package:e_learning/features/auth/presentation/pages/university_selection_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.selectedMethodLogin,
    routes: [
      GoRoute(
        path: RouteNames.selectedMethodLogin,
        builder: (context, state) => const SelectedMethodLogInPage(),
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
          return BlocProvider.value(
            value: blocProvider,
            child: const UniversitySelectionPage(),
          );
        },

        //  const UniversitySelectionPage(),
      ),

      //?-------------------------------------------------------------------
      GoRoute(
        path: RouteNames.otpScreen,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(repository: appLocator<AuthRepository>()),
          child: OtpPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
    ],
  );
}
