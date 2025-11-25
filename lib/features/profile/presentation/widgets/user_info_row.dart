import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
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
          style: AppTextStyles.s14w400.copyWith(color:context.colors.textPrimary),
        ),
        Text(value, style: AppTextStyles.s14w400.copyWith(color:context.colors.textGrey)),
      ],
    );
  }
}
