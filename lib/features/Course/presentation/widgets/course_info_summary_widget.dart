import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_bottom_sheet.dart';
import 'package:e_learning/features/Course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_hours_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseInfoSummaryWidget extends StatelessWidget {
  final int videoCount;
  final int hoursCount;
  final String price;

  const CourseInfoSummaryWidget({
    super.key,
    required this.videoCount,
    required this.hoursCount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VideoHoursWidget(videoCount: videoCount, hoursCount: hoursCount),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Divider(
            color: AppColors.dividerGrey,
            thickness: 1,
            height: 10.h,
          ),
        ),
        Row(
          children: [
            Text(
              "Price",
              style: AppTextStyles.s16w400.copyWith(color: AppColors.textGrey),
            ),
            SizedBox(width: 5.w),
            PriceTextWidget(price: price),
          ],
        ),
        SizedBox(height: 10.h),
        CustomButtonWidget(
          title: "Enroll Now",
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.titlePrimary,
          ),
          buttonColor: AppColors.buttonPrimary,
          borderColor: AppColors.borderPrimary,
          icon: Icon(Icons.arrow_outward_sharp, color: AppColors.iconWhite),
          onTap: () {
            // context.push(RouteNames.enroll);
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: false,
              builder: (context) => const CourseEnrollBottomSheet(),
            );
          },
        ),
      ],
    );
  }
}
