import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCard extends StatelessWidget {
  final String price;
  final String title, collegeName;
  final double? rating;
  final String? imageUrl;
  final String courseSlug;

  const CourseCard(
      {super.key,
      required this.price,
      required this.title,
      required this.collegeName,
      required this.courseSlug,
      this.rating,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return InkWell(
      onTap: () {
        final courseCubit = context.read<CourseCubit>();
        context.push(
          RouteNames.courceInf,
          extra: {
            'courseSlug': courseSlug,
            'courseCubit': courseCubit,
          },
        );
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          Card(
            color: colors.buttonTapNotSelected,
            elevation: 1, // 👈 adds soft shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            clipBehavior:
                Clip.antiAlias, // 👈 ensures image respects rounded corners
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: LayoutBuilder(
                builder: (context, paddingConstraints) {
                  final cardContentWidth = paddingConstraints.maxWidth > 0 &&
                          paddingConstraints.maxWidth.isFinite
                      ? paddingConstraints.maxWidth
                      : 300.w;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🖼 Course image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: CustomCachedImageWidget(
                          appImage: imageUrl!,
                          fit: BoxFit.cover,
                          width: cardContentWidth,
                          height: 160.h,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // 📘 Course Title
                      Text(
                        title,
                        style: AppTextStyles.s16w500.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      // 🏫 University
                      Text(
                        collegeName,
                        style: AppTextStyles.s14w400
                            .copyWith(color: colors.textGrey),
                      ),

                      const SizedBox(height: 20),

                      // ⭐ Rating + Price
                      SizedBox(
                        width: cardContentWidth,
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
                                    rating?.toString() ?? '0',
                                    style: AppTextStyles.s14w400.copyWith(
                                      color: AppColors.stars,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$price S.P',
                              style: AppTextStyles.s18w600
                                  .copyWith(color: colors.textBlue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          PositionedDirectional(
            end: 25.w,
            top: 25.h,
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.bookmark_border_outlined,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
