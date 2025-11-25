import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/chapter/data/models/download_item.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/course/presentation/widgets/video_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoRowWidget extends StatelessWidget {
  final String chapterTitle;
  final int durationSecond;
  final VoidCallback? onTap;
  final double? completedVideos;
  final bool isLocked;
  final String videoId;

  const VideoRowWidget({
    super.key,
    this.completedVideos,
    required this.chapterTitle,
    required this.durationSecond,
    this.onTap,
    this.isLocked = true,
    required this.videoId,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
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
                                color: AppColors.formSecondary,
                                borderRadius: BorderRadius.circular(999.r),
                              ),
                              alignment: Alignment.center,
                              child: isLocked 
                                ? Icon(
                                    Icons.lock,
                                    color: AppColors.iconOrange,
                                    size: 25.sp,
                                  )
                                : BlocBuilder<ChapterCubit, ChapterState>(
                                    buildWhen: (previous, current) => 
                                        previous.downloads != current.downloads,
                                    builder: (context, state) {
                                      // Find the download item for this video
                                      final downloadItem = state.downloads.firstWhere(
                                        (d) => d.videoId == videoId,
                                        orElse: () => DownloadItem(
                                          videoId: videoId,
                                          fileName: "",
                                          isDownloading: false,
                                          progress: 0.0,
                                        ),
                                      );
                                      
                                      if (downloadItem.isDownloading) {
                                        // Show progress percentage instead of just loading icon
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              value: downloadItem.progress,
                                              strokeWidth: 3,
                                              valueColor: const AlwaysStoppedAnimation<Color>(
                                                AppColors.buttonPrimary,
                                              ),
                                              backgroundColor: AppColors.dividerGrey,
                                            ),
                                            Text(
                                              '${(downloadItem.progress * 100).toInt()}%',
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (downloadItem.isCompleted) {
                                        // Show checkmark when completed
                                        return Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 25.sp,
                                        );
                                      } else if (downloadItem.hasError) {
                                        // Show error icon
                                        return Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 25.sp,
                                        );
                                      } else {
                                        // Show play icon when not downloading
                                        return Icon(
                                          Icons.play_arrow,
                                          color: AppColors.iconBlue,
                                          size: 25.sp,
                                        );
                                      }
                                    },
                                  ),
                            ),
                          ],
                        ),
                        12.sizedW,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                padding: EdgeInsets.only(right: 10.w),
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  chapterTitle,
                                  style: AppTextStyles.s16w600.copyWith(
                                    color: AppColors.textBlack,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              4.sizedH,
                              Text(
                                '$durationSecond Mins',
                                style: AppTextStyles.s14w400.copyWith(
                                  color: AppColors.textGrey,
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
                    if (durationSecond != 0 &&
                        completedVideos != null &&
                        !isLocked)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: VideoProgressWidget(
                          completedVideosSecond: completedVideos!,
                          totalVideoSecond: durationSecond,
                          hieghtProgress: 4,
                          showDetiels: false,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
