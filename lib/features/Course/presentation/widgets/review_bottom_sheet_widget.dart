import 'dart:developer';

import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/input_review_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_stars_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:go_router/go_router.dart';

class ReviewBottomSheetWidget extends StatefulWidget {
  final TextEditingController reviewController;
  final void Function(int rating)? onRatingChanged;

  const ReviewBottomSheetWidget({
    super.key,
    required this.reviewController,
    this.onRatingChanged,
  });

  @override
  State<ReviewBottomSheetWidget> createState() =>
      _ReviewBottomSheetWidgetState();
}

class _ReviewBottomSheetWidgetState extends State<ReviewBottomSheetWidget> {
  int selectedRating = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 346.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الشريط العلوي الصغير
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

          // العنوان
          Center(
            child: Text(
              "Rate Your Experience!".tr(),
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
          ),
          SizedBox(height: 5.h),

          // النجوم
          RatingStarsWidget(
            initialRating: selectedRating,
            onRatingSelected: (value) {
              log('User selected rating: $value');
              setState(() => selectedRating = value);
              widget.onRatingChanged?.call(value);
            },
          ),

          SizedBox(height: 10.h),

          // عنوان النص
          Text(
            "Write Your Review".tr(),
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          ),
          SizedBox(height: 10.h),

          // حقل الكتابة
          InputReviewWidget(
            controller: widget.reviewController,
            hint: "Your Opinion".tr(),
            hintKey: "yourOpinion",
          ),

          SizedBox(height: 20.h),

          // زر الإرسال
          Center(
            child: CustomButton(
              onTap: () {
                context.pop({
                  'rating': selectedRating,
                  'review': widget.reviewController.text.trim(),
                });
              },
              title: "Send Review".tr(),
              buttonColor: AppColors.buttonPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
