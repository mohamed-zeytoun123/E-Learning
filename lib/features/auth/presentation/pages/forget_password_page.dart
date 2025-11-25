import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/input_phone_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/forget_password_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: 120.h,
            bottom: 50.h,
            right: 15.w,
            left: 15.w,
          ),
          child: Center(
            child: Column(
              children: [
                AppLogo(),
                150.sizedH,
                Text(
                  "Enter_Your_Phone_Number".tr(),
                  style: AppTextStyles.s16w600,
                ),
                48.sizedH,
                Form(
                  key: _formKey,
                  child: InputPhoneWidget(controller: phoneController),
                ),
                12.sizedH,
                ForgetPasswordButtonWidget(
                  borderColor: AppColors.borderBrand,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  textColor: AppColors.titlePrimary,
                  formKey: _formKey,
                  phoneController: phoneController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
