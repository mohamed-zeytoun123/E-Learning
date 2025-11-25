import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_outlined_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileGuestHeader extends StatelessWidget {
  const ProfileGuestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 198.h,
      width: 362.w,
      child: Card(
        color: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: context.colors.borderCard),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Column(
            children: [
              Text(
                "Sign_In_To_Gain_Access_To_Your_Courses".tr(),
                style: AppTextStyles.s14w600.copyWith(
                  color: context.colors.textPrimary,
                ),
                maxLines: 1,
              ),
              24.sizedH,
              CustomOutlinedButton(
                title: "Log_in".tr(),
                onTap: () {
                  GoRouter.of(context).go(RouteNames.logIn);
                },
              ),
              12.sizedH,
              CustomButton(
                title: "Sign_up".tr(),
                buttonColor: context.colors.textBlue,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
