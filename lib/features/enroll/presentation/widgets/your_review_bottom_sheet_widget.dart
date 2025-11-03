import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/review_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class YourReviewBottomSheetWidget extends StatelessWidget {
  final String? reviewText;
  final int rating;
  final String timeAgo;

  const YourReviewBottomSheetWidget({
    super.key,
    required this.reviewText,
    this.rating = 1,
    this.timeAgo = "Unknown",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 299.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
          // الشريط العلوي
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
          SizedBox(height: 32.h),
          Text(
            AppLocalizations.of(context)?.translate("Your_Review") ??
                "Your Review",
            style: AppTextStyles.s16w600,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 20.h),
            child: ReviewBoxWidget(
              reviewText: reviewText!,
              rating: rating,
              timeAgo: timeAgo,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomButtonWidget(
              title: AppLocalizations.of(context)?.translate("Done") ?? "Done",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.textWhite,
              ),
              buttonColor: Theme.of(context).colorScheme.primary,
              borderColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
