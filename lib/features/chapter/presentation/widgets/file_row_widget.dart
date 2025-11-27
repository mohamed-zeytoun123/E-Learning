import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileRowWidget extends StatelessWidget {
  final String chapterTitle;
  final double sizeFile;
  final VoidCallback? onTap;
  final bool isDownloading;
  final double downloadProgress;
  final bool isDownloaded;

  const FileRowWidget({
    super.key,
    required this.chapterTitle,
    required this.sizeFile,
    this.onTap,
    this.isDownloading = false,
    this.downloadProgress = 0.0,
    this.isDownloaded = false,
  });

  @override
  Widget build(BuildContext context) {
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
                  Stack(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.formSecondary,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        alignment: Alignment.center,
                        child: isDownloading
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 35.w,
                                    height: 35.h,
                                    child: CircularProgressIndicator(
                                      value: downloadProgress,
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.iconBlue,
                                      ),
                                      backgroundColor: AppColors.dividerGrey,
                                    ),
                                  ),
                                  Text(
                                    '${(downloadProgress * 100).toInt()}%',
                                    style: AppTextStyles.s14w600.copyWith(
                                      color: AppColors.textPrimary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              )
                            : Icon(
                                Icons.insert_drive_file_outlined,
                                color: AppColors.iconBlue,
                                size: 25.sp,
                              ),
                      ),
                      if (isDownloaded)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 10.sp,
                            ),
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
                            color: AppColors.textBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '$sizeFile MB',
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textGrey,
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
