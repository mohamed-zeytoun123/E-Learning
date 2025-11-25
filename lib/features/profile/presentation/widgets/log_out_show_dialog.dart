import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
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
      create: (context) => AuthCubit(repository: di<AuthRepository>()),
      child: Builder(
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text('Confirm_Logout'.tr()),
            content: Text(
              'Are_you_sure_you_want_to_log_out'.tr(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الحوار
                },
                child: Text(
                  'Cancel'.tr(),
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    previous.loginState != current.logoutStatus ||
                    previous.errorlogout != current.errorlogout,
                buildWhen: (previous, current) =>
                    previous.loginState != current.logoutStatus,
                listener: (context, state) {
                  if (state.logoutStatus == ResponseStatusEnum.failure) {
                    AppMessage.showError(context, state.errorlogout ?? "wrrong".tr());
                  } else if (state.logoutStatus == ResponseStatusEnum.success) {
                    context.go(RouteNames.selectedMethodLogin);
                  }
                },
                builder: (context, state) {
                  if (state.logoutStatus == ResponseStatusEnum.loading) {
                    return SizedBox(
                      width: 40,
                      height: 30,
                      child: Center(
                        child: SizedBox(
                            height: 20.h,
                            width: 20,
                            child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      context.go(RouteNames.selectedMethodLogin);
                    },
                    child: Text(
                      'Log_Out'.tr(),
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
