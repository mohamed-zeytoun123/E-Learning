import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileRowWidget extends StatelessWidget {
  final String chapterTitle;
  final int sizeFile;
  final VoidCallback? onTap;

  const FileRowWidget({
    super.key,
    required this.chapterTitle,
    required this.sizeFile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
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
                      color: colors.buttonTapNotSelected,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.insert_drive_file_outlined,
                      color: AppColors.iconBlue,
                      size: 25.sp,
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
                        Text(
                          '$sizeFile MB',
                          style: AppTextStyles.s14w400.copyWith(
                            color: colors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.iconBlue,
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
