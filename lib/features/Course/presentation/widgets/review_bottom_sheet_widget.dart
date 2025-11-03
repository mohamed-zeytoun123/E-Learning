import 'dart:developer';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_review_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_stars_widget.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class ReviewBottomSheetWidget extends StatefulWidget {
  final String courseSlug;
  final TextEditingController reviewController;
  final void Function(int rating)? onRatingChanged;

  const ReviewBottomSheetWidget({
    super.key,
    required this.reviewController,
    this.onRatingChanged,
    required this.courseSlug,
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
              AppLocalizations.of(context)?.translate("Rate_Your_Experience") ??
                  "Rate Your Experience!",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
          ),
          SizedBox(height: 5.h),

          // النجوم
          RatingStarsWidget(
            initialRating: selectedRating.toDouble(),
            onRatingSelected: (value) {
              log('User selected rating: $value');
              setState(() => selectedRating = value.toInt());
              widget.onRatingChanged?.call(value.toInt());
            },
          ),

          SizedBox(height: 10.h),

          // عنوان النص
          Text(
            AppLocalizations.of(context)?.translate("Write_Your_Review") ??
                "Write Your Review",
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          ),
          SizedBox(height: 10.h),

          // حقل الكتابة
          InputReviewWidget(
            controller: widget.reviewController,
            hint:
                AppLocalizations.of(context)?.translate("Your_Opinion") ??
                "Your Opinion",
            hintKey: "YourOpinion",
          ),

          SizedBox(height: 20.h),

          // زر الإرسال
          Center(
            child: CustomButtonWidget(
              onTap: () {
                log('Final rating: $selectedRating');
                // Validate review text
                if (widget.reviewController.text.trim().isEmpty) {
                  AppMessage.showSnackBar(
                    context: context,
                    message:
                        AppLocalizations.of(
                          context,
                        )?.translate("Please_write_a_review!") ??
                        "Please write a review!",
                    backgroundColor: AppColors.messageError,
                  );
                  log('Review text is empty');
                  context.pop();
                } else {
                  // Create rating parameters
                  final params = CreateRatingParams(
                    courseSlug: widget.courseSlug,
                    rating: selectedRating.round(), // Convert double to int
                    comment: widget.reviewController.text.trim(),
                  );
                  context.read<EnrollCubit>().createRating(params);
                  context.pop();

                  // Show success message
                  AppMessage.showSnackBar(
                    context: context,
                    message:
                        AppLocalizations.of(
                          context,
                        )?.translate("Rating_submitted_successfully!") ??
                        "Rating submitted successfully!",
                    backgroundColor: AppColors.messageSuccess,
                  );
                }
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
