import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoRowWidget extends StatelessWidget {
  final String chapterTitle;
  final int durationMinutes;
  final VoidCallback? onTap;
  final int? completedVideos;
  final int? totalVideos;
  final bool isLocked;

  const VideoRowWidget({
    super.key,
    this.completedVideos,
    this.totalVideos,
    required this.chapterTitle,
    required this.durationMinutes,
    this.onTap,
    this.isLocked = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLocked ? null : onTap,
            splashColor: isLocked
                ? Colors.transparent
                : Colors.grey.withOpacity(0.2),
            highlightColor: isLocked
                ? Colors.transparent
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 88.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: context.colors.buttonTapNotSelected,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_arrow,
                              color: AppColors.iconBlue,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chapterTitle,
                              style: AppTextStyles.s16w600.copyWith(
                                color: context.colors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '$durationMinutes Mins',
                              style: AppTextStyles.s14w400.copyWith(
                                color: context.colors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isLocked ? Icons.lock : Icons.arrow_forward_ios,
                        size: 20.sp,
                        color: isLocked
                            ? AppColors.iconOrange
                            : AppColors.iconBlue,
                      ),
                    ],
                  ),
                  if (totalVideos != null &&
                      completedVideos != null &&
                      !isLocked)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: VideoProgressWidget(
                        completedVideos: completedVideos!,
                        totalVideos: totalVideos!,
                        hieghtProgress: 4,
                        showDetiels: false,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
