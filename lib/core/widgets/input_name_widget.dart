import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/validator/validator_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputNameWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final double? width;
  final String hint;
  final String hintKey;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Size? minimumSize;
  final MaterialTapTargetSize? tapTargetSize;

  const InputNameWidget({
    super.key,
    required this.controller,
    this.width,
    this.icon,
    required this.hint,
    required this.hintKey,
    this.padding,
    this.foregroundColor,
    this.minimumSize,
    this.tapTargetSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width ?? 361).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70.h,
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus();
              },
              decoration: InputDecoration(
                hintText: hintKey.tr(),
                prefixIcon: icon != null ? Icon(icon) : null,
              ),
              validator: (value) => Validator.validateName(value),
            ),
          ),
        ],
      ),
    );
  }
}
