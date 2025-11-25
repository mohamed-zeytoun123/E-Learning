import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
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
    final colors =context.colors;
    return SizedBox(
      width: 361.w,
      height: height.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(color: colors.borderCard),
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
                  12.sizedW,
                  SizedBox(
                    width: 144.w,
                    child: Text(
                      courseTitle,
                      style: AppTextStyles.s16w500.copyWith(color: colors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  StateContainerWidget(courseState: courseState),
                ],
              ),
              12.sizedH,
              Divider(color: colors.dividerGrey),

              // Spacer(),
              12.sizedH,
              Expanded(child: stateSectionWidget),
            ],
          ),
        ),
      ),
    );
  }
}
