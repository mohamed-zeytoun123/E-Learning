import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_loading_widget.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/app_message.dart' show AppMessage;
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_outlined_button.dart';
import 'package:e_learning/features/auth/data/models/params/login_params.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/forgot_password_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/login_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginInputParams loginInputParams = LoginInputParams();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginState != current.loginState,
      listener: (context, state) {
        if (state.loginState == ResponseStatusEnum.failure ||
            state.loginError != null) {
          AppMessage.showError(context, state.loginError ?? "wrong".tr());
        } else if (state.loginState == ResponseStatusEnum.success) {
          AppMessage.showSuccess(context, "login_successful".tr());
          // Navigate to home after successful login
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.go(RouteNames.mainHomePage);
            }
          });
        }
      },
      buildWhen: (previous, current) =>
          previous.loginState != current.loginState,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: AppPadding.defaultScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                const AppLogo(),
                5.sizedH,
                Text(
                  "log_in_to_your_account".tr(),
                  style: AppTextStyles.s16w600.copyWith(
                    color: colors.textBlue,
                  ),
                ),
                48.sizedH,
                Provider.value(
                    value: loginInputParams,
                    child: LoginForm(
                      formKey: _formKey,
                      loginInputParams: loginInputParams,
                    )),
                12.sizedH,
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordWidget(
                    onTap: () => context.push(RouteNames.forgetPassword),
                  ),
                ),
                24.sizedH,
                AppLoadingWidget(
                  isLoading: state.loginState == ResponseStatusEnum.loading,
                  child: CustomButton(
                    title: "log_in".tr(),
                    buttonColor: colors.textBlue,
                    textColor: AppColors.titlePrimary,
                    onTap: state.loginState == ResponseStatusEnum.loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                    loginInputParams.email?.trim() ?? '',
                                    loginInputParams.password?.trim() ?? '',
                                  );
                            }
                          },
                  ),
                ),
                72.sizedH,
                Text(
                  "dont_have_account".tr(),
                  style: AppTextStyles.s14w400.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                16.sizedH,
                CustomOutlinedButton(
                  title: "sign_up".tr(),
                  onTap: () => context.go(RouteNames.signUp),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
