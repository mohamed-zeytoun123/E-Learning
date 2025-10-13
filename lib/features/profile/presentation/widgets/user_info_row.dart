import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final String title;
  final String value;
  const UserInfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
        ),
        Text(value, style: AppTextStyles.s14w400),
      ],
    );
  }
}
