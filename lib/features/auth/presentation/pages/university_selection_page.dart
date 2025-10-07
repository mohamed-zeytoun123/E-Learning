import 'package:e_learning/core/constant/app_colors.dart';
import 'package:e_learning/core/constant/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/selected_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UniversitySelectionPage extends StatelessWidget {
  const UniversitySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(
          top: 120.h,
          bottom: 50.h,
          right: 15.w,
          left: 15.w,
        ),
        child: Center(
          child: Column(
            children: [
              HeaderAuthPagesWidget(),
              SizedBox(height: 5.h),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("Lets_make_your_account") ??
                    "Let’s Make Your Account !",
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("We_are_one_step_away") ??
                    "We Are One Step Away !",
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 40.h),
              SelectedInformationWidget(),
              SizedBox(height: 20.h),
              CustomButton(
                title:
                    AppLocalizations.of(context)?.translate("next") ?? "Next",
                titleStyle: AppTextStyles.s16w500.copyWith(
                  color: AppColors.titleBlack,
                  fontFamily: AppTextStyles.fontGeist,
                ),
                buttonColor: AppColors.buttonGreyF,
                borderColor: AppColors.buttonGreyF,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
