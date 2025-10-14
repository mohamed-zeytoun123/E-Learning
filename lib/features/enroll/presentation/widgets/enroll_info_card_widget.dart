import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnrollInfoCardWidget extends StatelessWidget {
  final String imageUrl;
  final String courseTitle;
  const EnrollInfoCardWidget({
    super.key,
    required this.imageUrl,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 193.h,
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
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CustomCachedImage(
                    appImage: imageUrl,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    placeholder: Container(
                      color: Colors.grey.shade300,
                      child: Center(child: AppLoading.circular()),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(courseTitle, style: AppTextStyles.s16w500),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
