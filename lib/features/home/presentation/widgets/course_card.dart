import 'package:flutter/material.dart';
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/home/presentation/widgets/home_banner.dart';
import 'package:e_learning/features/home/presentation/widgets/custom_appbar.dart';
import 'package:e_learning/features/home/presentation/widgets/see_all_seperator.dart';
import 'package:e_learning/features/home/presentation/widgets/top_home_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white,
          elevation: 1, // 👈 adds soft shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          clipBehavior:
              Clip.antiAlias, // 👈 ensures image respects rounded corners
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Course image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: Image.asset(
                    Assets.resourceImagesPngHomeeBg,
                    fit: BoxFit.cover,
                    width: 300.w,
                    height: 160.h,
                  ),
                ),

                SizedBox(height: 16.h),

                // 📘 Course Title
                Text(
                  'Course Title \\ Name',
                  style: AppTextStyles.s16w500,
                ),

                SizedBox(height: 4.h),

                // 🏫 University
                Text(
                  'College - University',
                  style:
                      AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
                ),

                const SizedBox(height: 20),

                // ⭐ Rating + Price
                SizedBox(
                  width: 300.w, // fixed card width in your CourseCard layout
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.ligthGray,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_outlined,
                              color: AppColors.stars,
                              size: 14.h,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '4',
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.stars,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '180000 S.P',
                        style: AppTextStyles.s18w600
                            .copyWith(color: AppColors.primaryTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          end: 25.w,
          top: 25.h,
          child: CircleAvatar(
            radius: 22.r,
            backgroundColor: Colors.white,
            child: Icon(Icons.bookmark_border_outlined),
          ),
        )
      ],
    );
  }
}
