import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceTextWidget extends StatelessWidget {
  final String price;

  const PriceTextWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final colors= context.colors;
    return Row(
      spacing: 4.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          price,
          style: AppTextStyles.s16w400.copyWith(
            color: colors.textBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "S.P",
          style: AppTextStyles.s16w400.copyWith(
            color:colors.textBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
