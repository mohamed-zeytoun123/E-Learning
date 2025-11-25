import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model.dart';
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
    final colors = context.colors;
    if (teacher == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "teachers".tr(),
            style: TextStyle(color: colors.textPrimary),
          ),
        ),
        body: Center(
          child: Text('teacher_not_found'.tr(),
              style: TextStyle(fontSize: 14.sp, color: colors.textPrimary)),
        ),
      );
    }

    final teacherData = teacher!;
    final courses = teacherData.courses;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.background,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        ),
        title:
            Text("teachers".tr(), style: TextStyle(color: colors.textPrimary)),
      ),
      body: Padding(
        padding: AppPadding.defaultScreen.copyWith(top: 56),
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
                            backgroundColor: colors.textGrey.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              size: 40.sp,
                              color: colors.textGrey,
                            ),
                          ),
                  ),
                  32.sizedH,
                  // Teacher Name
                  Text(
                    teacherData.fullName,
                    style: AppTextStyles.s18w600
                        .copyWith(color: colors.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                  12.sizedH,
                  // Teacher Bio
                  if (teacherData.bio != null && teacherData.bio!.isNotEmpty)
                    Text(
                      teacherData.bio!,
                      style: AppTextStyles.s14w400
                          .copyWith(color: colors.textGrey),
                      textAlign: TextAlign.center,
                    ),
                  // Qualifications
                  if (teacherData.qualifications != null &&
                      teacherData.qualifications!.isNotEmpty) ...[
                    8.sizedH,
                    Text(
                      teacherData.qualifications!,
                      style: AppTextStyles.s12w400
                          .copyWith(color: AppColors.textGrey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  64.sizedH,
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
                                .copyWith(color: colors.textBlue),
                          ),
                          Text(
                            'courses'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: colors.textGrey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${teacherData.students}',
                            style: AppTextStyles.s16w600
                                .copyWith(color: colors.textBlue),
                          ),
                          Text(
                            'students'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: colors.textGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                  64.sizedH,
                  // Courses Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'courses'.tr(),
                      style: AppTextStyles.s18w600.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  24.sizedH,
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
                separatorBuilder: (context, index) => 20.sizedH,
              ),
          ],
        ),
      ),
    );
  }
}
