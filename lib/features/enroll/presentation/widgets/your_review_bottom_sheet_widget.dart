import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/enroll/presentation/widgets/review_box_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourReviewBottomSheetWidget extends StatelessWidget {
  final String? reviewText;
  const YourReviewBottomSheetWidget({super.key, required this.reviewText});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ModalSheetCustomContainerWidget(
      height: 299.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your_Review".tr(),
            style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 20.h),
            child: ReviewBoxWidget(reviewText: reviewText ?? "No Reviews Yet"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomButton(
              title: "Done".tr(),
              buttonColor: colors.textBlue,
              onTap: () {
                // Button action handled
              },
            ),
          ),
        ],
      ),
    );
  }
}
