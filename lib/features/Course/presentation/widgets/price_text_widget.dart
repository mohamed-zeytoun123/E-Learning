import 'package:flutter/material.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceTextWidget extends StatelessWidget {
  final String price;

  const PriceTextWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          price,
          style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
        ),
        SizedBox(width: 4.w),
        Text(
          "S.P",
          style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
        ),
      ],
    );
  }
}
