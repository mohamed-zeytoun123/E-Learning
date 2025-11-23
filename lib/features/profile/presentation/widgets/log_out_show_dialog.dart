import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return showDialogLogOut();
    },
  );
}

class showDialogLogOut extends StatelessWidget {
  const showDialogLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(repository: appLocator<AuthRepository>()),
      child: Builder(
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text('Confirm Logout'),
            content: Text(
              'Are you sure you want to log out from your account?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الحوار
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    previous.loginState != current.logoutStatus||previous.errorlogout != current.errorlogout,
                    buildWhen: (previous, current) => previous.loginState != current.logoutStatus,
                listener: (context, state) {
                  if (state.logoutStatus == ResponseStatusEnum.failure) {
                    AppMessage.showFlushbar(
                      context: context,
                      title:
                          AppLocalizations.of(context)?.translate("wrrong") ??
                          "Wrrong",
                      mainButtonOnPressed: () {
                        context.pop();
                      },
                      mainButtonText:
                          AppLocalizations.of(context)?.translate("ok") ?? "Ok",
                      iconData: Icons.error,
                      backgroundColor: AppColors.messageError,
                      message: state.errorlogout,
                      isShowProgress: true,
                    );
                  }
                  else if(state.logoutStatus == ResponseStatusEnum.success){
                   context.go(RouteNames.selectedMethodLogin);
                  }
                },
                builder: (context, state) {
                  if (state.logoutStatus == ResponseStatusEnum.loading)
                    return SizedBox(width: 40,
                    height: 30,
                      child: Center(
                        child: SizedBox(height: 20.h,width: 20,
                          child: CircularProgressIndicator()),
                      ),
                    );

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      //   appLocator<SharedPreferencesService>().removeAll();
                      // BlocProvider.of<AuthCubit>(context).logout(state.loginError!);
                                       context.go(RouteNames.selectedMethodLogin);


                      // Navigator.of(context).pop(); // إغلاق الحوار
                      // أضف هنا منطق تسجيل الخروج

                      print('تم تسجيل الخروج');
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
