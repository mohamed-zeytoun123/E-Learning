import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/model/enums/chapter_state_enum.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterRowWidget extends StatelessWidget {
  final int chapterNumber;
  final String chapterTitle;
  final int videoCount;
  final int durationMinutes;
  final VoidCallback? onTap;
  final ChapterStateEnum chapterState;
  final int id;
  final bool isLoading; // ✅ باراميتر اللودينغ

  const ChapterRowWidget({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.videoCount,
    required this.durationMinutes,
    this.onTap,
    required this.chapterState,
    required this.id,
    this.isLoading = false, // ✅ القيمة الافتراضية false
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // ✅ أثناء التحميل، منعرض شيمر Skeleton
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: AppLoading.skeleton(height: 88.h),
      );
    }

    final chapterText = chapterNumber < 10
        ? '0$chapterNumber'
        : '$chapterNumber';

    final isUnlocked = chapterState == ChapterStateEnum.open;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isUnlocked ? onTap : null,
            splashColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 88.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhiteWidget,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.formSecondary,
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
                            IconCircleWidget(),
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
                    isUnlocked ? Icons.arrow_forward_ios : Icons.lock_outline,
                    size: 20.sp,
                    color: isUnlocked
                        ? AppColors.iconBlue
                        : AppColors.iconOrange,
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
