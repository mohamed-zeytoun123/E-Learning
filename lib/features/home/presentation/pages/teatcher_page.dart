import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/home/presentation/widgets/course_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TeatcherPage extends StatelessWidget {
  final TeacherModel? teacher;

  const TeatcherPage({
    super.key,
    this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    if (teacher == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("teachers".tr()),
        ),
        body: Center(
          child: Text('teacher_not_found'.tr()),
        ),
      );
    }

    final teacherData = teacher!;
    final courses = teacherData.courses;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("teachers".tr()),
      ),
      body: Padding(
        padding: AppPadding.appPadding.copyWith(top: 56),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Teacher Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999.r),
                    child: teacherData.avatar != null &&
                            teacherData.avatar!.isNotEmpty
                        ? CustomCachedImageWidget(
                            appImage: teacherData.avatar!,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            radius: 40.r,
                            backgroundColor:
                                AppColors.textGrey.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              size: 40.sp,
                              color: AppColors.textGrey,
                            ),
                          ),
                  ),
                  SizedBox(height: 32.h),
                  // Teacher Name
                  Text(
                    teacherData.fullName,
                    style: AppTextStyles.s18w600,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  // Teacher Bio
                  if (teacherData.bio != null && teacherData.bio!.isNotEmpty)
                    Text(
                      teacherData.bio!,
                      style: AppTextStyles.s14w400
                          .copyWith(color: AppColors.textGrey),
                      textAlign: TextAlign.center,
                    ),
                  // Qualifications
                  if (teacherData.qualifications != null &&
                      teacherData.qualifications!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      teacherData.qualifications!,
                      style: AppTextStyles.s12w400
                          .copyWith(color: AppColors.textGrey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 64.h),
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${teacherData.coursesNumber}',
                            style: AppTextStyles.s16w600
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          Text(
                            'courses'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: AppColors.textGrey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${teacherData.students}',
                            style: AppTextStyles.s16w600
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          Text(
                            'students'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: AppColors.textGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 64.h),
                  // Courses Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'courses'.tr(),
                      style: AppTextStyles.s18w600.copyWith(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            // Courses List
            if (courses.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'no_courses_available'.tr(),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              )
            else
              SliverList.separated(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return FittedBox(
                    child: CourseCard(
                      price: course.price,
                      title: course.title,
                      collegeName: course.collegeName,
                      imageUrl: course.image ?? '',
                      rating: course.averageRating,
                      courseSlug: course.slug,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
              ),
          ],
        ),
      ),
    );
  }
}
