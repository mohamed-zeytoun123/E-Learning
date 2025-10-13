import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_title_subtitle_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_bottom_container.dart';
import 'package:e_learning/features/Course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_hours_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourceInfoPage extends StatelessWidget {
  const CourceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarCourseWidget(title: "Courses", showBack: true),
      body: Stack(
        children: [
          Container(color: AppColors.background),

          CustomCachedImage(
            appImage: 'https://example.com/your_image.jpg',
            width: double.infinity,
            height: 262,
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 220.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              child: CustomBottomContainer(
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 302.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: AppColors.borderBrand,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 4),
                            blurRadius: 6.r,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CourseTitleSubtitle(
                                titleStyle: AppTextStyles.s18w600.copyWith(
                                  color: AppColors.textBlack,
                                ),
                                title: 'Flutter Development',
                                subtitle: 'Learn to build apps with Flutter',
                              ),
                              RatingWidget(rating: 4.5),
                            ],
                          ),

                          VideoHoursWidget(videoCount: 22, hoursCount: 22),

                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            height: 0.h,
                          ),

                          Row(
                            children: [
                              Text(
                                "Price",
                                style: AppTextStyles.s16w400.copyWith(
                                  color: AppColors.textGrey,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              PriceTextWidget(price: "180000000"),
                            ],
                          ),

                          CustomButton(
                            title: "Enroll Course",
                            titleStyle: AppTextStyles.s16w500.copyWith(
                              color: AppColors.titlePrimary,
                              fontFamily: AppTextStyles.fontGeist,
                            ),
                            icon: Icon(
                              Icons.arrow_outward_rounded,
                              color: AppColors.iconWhite,
                              size: 20.sp,
                            ),
                            buttonColor: AppColors.buttonPrimary,
                            borderColor: AppColors.borderPrimary,
                            onTap: () {
                              log("😂😂😂");
                            },
                          ),
                        ],
                      ),
                    ),
                    CourseTabViewWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
