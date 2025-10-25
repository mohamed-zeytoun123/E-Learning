import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:e_learning/features/enroll/presentation/widgets/state_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnrollInfoCardWidget extends StatelessWidget {
  final String imageUrl;
  final String courseTitle;
  final CourseStateEnum courseState;
  final Widget stateSectionWidget;
  final double height;
  const EnrollInfoCardWidget({
    super.key,
    required this.imageUrl,
    required this.courseTitle,
    required this.courseState,
    required this.stateSectionWidget,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 361.w,
      height: height.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 12.h,
            top: 24.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CustomCachedImageWidget(
                      appImage: imageUrl,
                      width: 64.w,
                      height: 64.h,
                      fit: BoxFit.cover,
                      placeholder: Container(
                        color: Colors.grey.shade300,
                        child: Center(child: AppLoading.circular()),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    width: 144.w,
                    child: Text(
                      courseTitle,
                      style: AppTextStyles.s16w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  StateContainerWidget(courseState: courseState),
                ],
              ),
              SizedBox(height: 12.h),
              Divider(color: AppColors.dividerGrey),

              // Spacer(),
              SizedBox(height: 12.h),
              Expanded(child: stateSectionWidget),
            ],
          ),
        ),
      ),
    );
  }
}
