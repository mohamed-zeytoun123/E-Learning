import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/validator/validator_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputPhoneWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final double? width;

  const InputPhoneWidget({
    super.key,
    required this.controller,
    this.width,
    this.icon,
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
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus();
              },
              decoration: InputDecoration(
                hintText: "phone_number".tr(),
                prefixIcon: icon != null ? Icon(icon) : null,
              ),
              validator: (value) => Validator.phoneValidation(value),
            ),
          ),
        ],
      ),
    );
  }
}
