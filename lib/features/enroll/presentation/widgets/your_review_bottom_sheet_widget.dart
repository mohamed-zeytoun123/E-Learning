import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/review_box_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
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
            "your_review".tr(),
     style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 20.h),
            child: ReviewBoxWidget(reviewText: reviewText ?? "no_reviews_yet".tr()),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomButtonWidget(
              title: "done".tr(),
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.textWhite,
              ),
              buttonColor: colors.textBlue,
              borderColor: colors.textBlue,
              onTap: () {
                log('=====================>> Review Button Pressed');
              },
            ),
          ),
        ],
      ),
    );
  }
}
