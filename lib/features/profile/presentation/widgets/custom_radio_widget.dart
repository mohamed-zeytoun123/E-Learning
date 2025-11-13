import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  const CustomRadioWidget({
    super.key,
    required this.title,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(title, style: AppTextStyles.s14w400),
      value: value,
      activeColor: Theme.of(context).colorScheme.primary,
      fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(context).colorScheme.primary;
        }
        return AppColors.buttonTapNotSelected;
      }),
    );
  }
}
