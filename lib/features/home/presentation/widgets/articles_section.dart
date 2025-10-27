import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key, this.itemsForShow});
  final int? itemsForShow;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: itemsForShow ?? 20,
      itemBuilder: (context, index) {
        return ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              Assets.resourceImagesPngHomeeBg,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Article Title',
                style: AppTextStyles.s16w500,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.stars,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'mins'.tr(),
                        style: AppTextStyles.s12w400
                            .copyWith(color: AppColors.stars),
                      )
                    ],
                  ),
                  Text(
                    '15 Oct, 2025',
                    style: AppTextStyles.s12w400
                        .copyWith(color: AppColors.textGrey),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
