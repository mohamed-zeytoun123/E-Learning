import 'dart:developer';

import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_review_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class ReviewBottomSheetWidget extends StatelessWidget {
  ReviewBottomSheetWidget({super.key});
  final TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 346.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
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
                color: AppColors.formWhite,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Center(
            child: Text(
              "Rate Your Experience!",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
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
            "Write Your Review",
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          ),
          SizedBox(height: 10.h),

          InputReviewWidget(
            controller: reviewController,
            hint: "Your Opinion",
            hintKey: "yourOpinion",
          ),

          SizedBox(height: 20.h),

          Center(
            child: CustomButtonWidget(
              onTap: () {
                context.pop(context);
              },
              title: "Send Review",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              icon: Icon(
                Icons.arrow_outward_outlined,
                color: AppColors.iconWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
