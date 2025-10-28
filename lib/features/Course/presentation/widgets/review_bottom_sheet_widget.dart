import 'dart:developer';

import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_review_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class ReviewBottomSheetWidget extends StatelessWidget {
  final TextEditingController reviewController;
  const ReviewBottomSheetWidget({super.key, required this.reviewController});

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Container(
      height: 346.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: colors.buttonTapNotSelected,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.formSomeWhite,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Center(
            child: Text(
              AppLocalizations.of(context)?.translate("Rate_Your_Experience") ??
                  "Rate Your Experience!",
              style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
            ),
          ),
          SizedBox(height: 5.h),

          RatingStarsWidget(
            initialRating: 3.5,
            onRatingSelected: (value) {
              log('User selected rating: $value');
            },
          ),

          SizedBox(height: 10.h),

          Text(
            AppLocalizations.of(context)?.translate("Write_Your_Review") ??
                "Write Your Review",
            style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 10.h),

          InputReviewWidget(
            controller: reviewController,
            hint:
                AppLocalizations.of(context)?.translate("yourOpinion") ??
                "Your Opinion",
            hintKey: "yourOpinion",
          ),

          SizedBox(height: 20.h),

          Center(
            child: CustomButtonWidget(
              onTap: () {
                context.pop(context);
              },
              title:
                  AppLocalizations.of(context)?.translate("Send_Review") ??
                  "Send Review",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
