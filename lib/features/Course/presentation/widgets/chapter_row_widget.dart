import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterRowWidget extends StatelessWidget {
  final int chapterNumber;
  final String chapterTitle;
  final int videoCount;
  final int durationMinutes;
  final VoidCallback? onTap;

  const ChapterRowWidget({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.videoCount,
    required this.durationMinutes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chapterText = chapterNumber < 10
        ? '0$chapterNumber'
        : '$chapterNumber';

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 88.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.formCircle,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      chapterText,
                      style: AppTextStyles.s16w600.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
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
                            color: AppColors.textBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          spacing: 5.w,
                          children: [
                            Text(
                              '$videoCount Videos',
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                            Icon(
                              Icons.circle,
                              size: 10.r,
                              color: AppColors.iconCircle,
                            ),
                            Text(
                              '$durationMinutes Mins',
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.iconBlack,
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
