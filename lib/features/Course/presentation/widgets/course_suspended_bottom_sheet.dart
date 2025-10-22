import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseSuspendedBottomSheet extends StatelessWidget {
  const CourseSuspendedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
            child: Container(
              width: 60.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.dividerGrey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // 👈 النصوص من اليسار
              children: [
                SizedBox(height: 10.h),

                Text(
                  "Course Has Been Suspended !",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Contact Us To Activate Your Course",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),

                SizedBox(height: 25.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ContactIcon(
                      iconPath: AppIcons.iconWhatsApp,
                      onTap: () {},
                      color: const Color(0xff25D366),
                      nameApp: 'WhatsApp',
                    ),
                    _ContactIcon(
                      iconPath: AppIcons.iconTelegram,
                      onTap: () {},
                      color: const Color(0xff2AABEE),
                      nameApp: 'Telegram',
                    ),
                    _ContactIcon(
                      iconPath: AppIcons.iconGmail,
                      onTap: () {},
                      color: const Color(0xffEDF7FF),
                      nameApp: 'Email',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactIcon extends StatelessWidget {
  final String iconPath;
  final String nameApp;
  final VoidCallback onTap;
  final Color color;

  const _ContactIcon({
    required this.iconPath,
    required this.nameApp,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Column(
        spacing: 5.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(child: Image(image: AssetImage(iconPath))),
          ),
          Text(
            nameApp,
            style: AppTextStyles.s12w400.copyWith(color: AppColors.textBlack),
          ),
        ],
      ),
    );
  }
}
