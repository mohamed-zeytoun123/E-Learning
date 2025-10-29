import 'package:flutter/material.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceTextWidget extends StatelessWidget {
  final String price;

  const PriceTextWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          price,
          style: AppTextStyles.s16w400.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "S.P",
          style: AppTextStyles.s16w400.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
