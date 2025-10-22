import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
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
    return ModalSheetCustomContainerWidget(
      height: 299.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Your_Review") ??
                "Your Review",
            style: AppTextStyles.s16w600,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 20.h),
            child: ReviewBoxWidget(reviewText: reviewText ?? "No Reviews Yet"),
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
                log('=====================>> Review Button Pressed');
              },
            ),
          ),
        ],
      ),
    );
  }
}
