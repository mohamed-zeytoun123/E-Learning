import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart' hide Colors;
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final double progress; // Add a progress parameter

  const ProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  Assets.resourceImagesPngHomeeBg,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'continueLearning'.tr()}!',
                    style: AppTextStyles.s14w400
                        .copyWith(color: AppColors.textGrey),
                  ),
                  Text(
                    'The Full Course Title',
                    style: AppTextStyles.s16w400
                        .copyWith(color: AppColors.primaryTextColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            LinearPercentIndicator(
              lineHeight: 12.h,
              barRadius: Radius.circular(16),
              percent: progress,
              progressColor: AppColors.primaryColor,
              backgroundColor: AppColors.iconGrey,
              animation: true,
              animationDuration: 800,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${10} Of ${40} ${'Videos'.tr()}"),
                Text("${25}% ${'completed'.tr()}"),
              ],
            ),
            SizedBox(height: 24.h),
            CustomButtonWidget(
                title: 'view_all'.tr(),
                titleStyle: AppTextStyles.s16w400
                    .copyWith(color: AppColors.primaryTextColor),
                buttonColor: Color(0xffECF6FE),
                borderColor: Colors.transparent)
          ],
        ),
      ),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    );
  }
}
