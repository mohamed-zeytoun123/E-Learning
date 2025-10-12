import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              Assets.resourceImagesPngHomeeBg,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'Article Title',
            style: AppTextStyles.s16w500,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        );
      },
    );
  }
}
