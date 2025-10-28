import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  final String title;
  final dynamic value;
  const CustomRadioWidget({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: Text(title, style: AppTextStyles.s14w400.copyWith(color: context.colors.textPrimary)),
      value: value,
      activeColor: Theme.of(context).colorScheme.primary,
      fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return context.colors.textBlue;
        }
        return AppColors.buttonTapNotSelected;
      }),
    );
  }
}
