import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/chapter_state_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterRowWidget extends StatelessWidget {
  final int chapterNumber;
  final String chapterTitle;
  final int videoCount;
  final int durationMinutes;
  final VoidCallback? onTap;
  final ChapterStateEnum chapterState;
  final int index;

  const ChapterRowWidget({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.videoCount,
    required this.durationMinutes,
    this.onTap,
    required this.chapterState,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
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
            child: SizedBox(
              height: 88.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: context.colors.buttonTapNotSelected,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      chapterText,
                      style: AppTextStyles.s16w600.copyWith(
                        color: context.colors.textBlue,
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
                            color: colors.textPrimary,
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
                                color: colors.textGrey,
                              ),
                            ),
                            IconCircleWidget(),
                            Text(
                              '$durationMinutes Mins',
                              style: AppTextStyles.s14w400.copyWith(
                                color: colors.textGrey,
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
                        ? colors.textBlue
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
