import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final EnrollmentModel? enrollment;

  const ProgressCard({super.key, this.enrollment});

  @override
  Widget build(BuildContext context) {
    if (enrollment == null) {
      return const SizedBox.shrink();
    }

    final progress = enrollment!.progressPercentage / 100.0;
    final totalVideos = enrollment!.totalVideos;
    final completedVideos = enrollment!.completedVideos;
    final colors = context.colors;

    return Card(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: enrollment!.courseImage != null &&
                        enrollment!.courseImage!.isNotEmpty
                    ? CustomCachedImageWidget(
                        appImage: enrollment!.courseImage!,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        Assets.resourceImagesPngHomeeBg,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'continueLearning'.tr()}!',
                    style:
                        AppTextStyles.s14w400.copyWith(color: colors.textGrey),
                  ),
                  Text(
                    enrollment!.courseTitle,
                    style: AppTextStyles.s16w400
                        .copyWith(color: AppColors.primaryTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 12.h,
              barRadius: Radius.circular(16),
              percent: progress.clamp(0.0, 1.0),
              progressColor: colors.textBlue,
              backgroundColor: AppColors.dividerGrey,
              animation: true,
              animationDuration: 800,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${completedVideos} ${'of'.tr()} ${totalVideos} ${'videos'.tr()}"),
                Text("${enrollment!.progressPercentage}% ${'completed'.tr()}"),
              ],
            ),
            SizedBox(height: 24.h),
            CustomButtonWidget(
              title: 'see_all'.tr(),
              titleStyle: AppTextStyles.s16w400
                  .copyWith(color: AppColors.primaryTextColor),
              buttonColor: Color(0xffECF6FE),
              borderColor: Colors.transparent,
              onTap: () {
                context.push(
                  RouteNames.courceInf,
                  extra: {
                    'courseId': enrollment!.course,
                  },
                );
              },
            )
          ],
        ),
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: context.colors.borderCard),
      ),
    );
  }
}
