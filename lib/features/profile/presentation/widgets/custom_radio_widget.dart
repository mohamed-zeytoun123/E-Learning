import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
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
      title: Text(title,
          style: AppTextStyles.s14w400
              .copyWith(color: context.colors.textPrimary)),
      value: value,
      activeColor: context.colors.textBlue,
      fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return context.colors.textBlue;
        }
        return context.colors.buttonTapNotSelected;
      }),
    );
  }
}
