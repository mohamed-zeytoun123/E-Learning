import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/input_review_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_stars_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colors = context.colors;
    return Container(
      height: 346.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: colors.background,
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
                color: colors.textGrey,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          10.sizedH,

          // العنوان
          Center(
            child: Text(
              "Rate_Your_Experience".tr(),
              style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
            ),
          ),
          5.sizedH,

          // النجوم
          RatingStarsWidget(
            initialRating: selectedRating,
            onRatingSelected: (value) {
              setState(() => selectedRating = value);
              widget.onRatingChanged?.call(value);
            },
          ),

          10.sizedH,

          // عنوان النص
          Text(
            "Write_Your_Review".tr(),
            style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
          ),
          10.sizedH,

          // حقل الكتابة
          InputReviewWidget(
            controller: widget.reviewController,
            hint: "yourOpinion".tr(),
            hintKey: "yourOpinion",
          ),

          20.sizedH,

          // زر الإرسال
          Center(
            child: CustomButton(
              onTap: () {
                context.pop({
                  'rating': selectedRating,
                  'review': widget.reviewController.text.trim(),
                });
              },
              title: "Send_Review".tr(),
              buttonColor: colors.textBlue,
            ),
          ),
        ],
      ),
    );
  }
}
