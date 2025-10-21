import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_count_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/teacher_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabAboutWidget extends StatelessWidget {
  const BodyTabAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Instructor",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
            TeacherRowWidget(
              teacherName: "John Doe",
              teacherImageUrl: "https://picsum.photos/361/180",
            ),
            Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),

            Text(
              "About The Course",
              style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
            ),
            SizedBox(height: 8.h),
            Text(
              "Description About Course’s Content And Subjects, Description About Course’s Content And Subjects, Description About Course’s Content And Subjects, Description About Course’s Content And Subjects.",
              style: AppTextStyles.s16w400.copyWith(color: AppColors.textBlack),
            ),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Paid Price",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                PriceTextWidget(price: "199999"),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(
                color: AppColors.dividerGrey,
                thickness: 1,
                height: 0.h,
              ),
            ),
            Text(
              "Content",
              style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconCountTextWidget(
                      icon: Icons.videocam_outlined,
                      count: 28.toString(),
                      text: 'Videos',
                    ),
                    IconCountTextWidget(
                      icon: Icons.access_time,
                      count: 20.toString(),
                      text: 'Hours',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconCountTextWidget(
                      icon: Icons.assignment_outlined,
                      count: 10.toString(),
                      text: 'Chapters',
                    ),
                    IconCountTextWidget(
                      icon: Icons.edit_note,
                      count: 10.toString(),
                      text: 'Quizes',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
