import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final double progress; // Add a progress parameter

  const ProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  color: Colors.black,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'continueLearning'.tr()}!',
                    style:
                        AppTextStyles.s14w400.copyWith(color: colors.textGrey),
                  ),
                  Text(
                    'The Full Course Title',
                    style:
                        AppTextStyles.s16w400.copyWith(color: colors.textBlue),
                  ),
                ],
              ),
            ),
            24.sizedH,
            LinearPercentIndicator(
              lineHeight: 12.h,
              barRadius: Radius.circular(16),
              percent: progress,
              progressColor: colors.textBlue,
              backgroundColor: colors.textGrey,
              animation: true,
              animationDuration: 800,
            ),
            12.sizedH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${10} Of ${40} ${'Videos'.tr()}"),
                Text("${25}% ${'completed'.tr()}"),
              ],
            ),
            24.sizedH,
            CustomButton(
                title: 'view_all'.tr(),
                buttonColor: colors.buttonTapNotSelected)
          ],
        ),
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: context.colors.borderCard),
      ),
    );
  }
}
