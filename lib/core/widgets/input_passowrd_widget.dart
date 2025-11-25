import 'package:e_learning/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/validator/validator_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputPasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  final double? width;
  final String hint;
  final String hintKey;

  const InputPasswordWidget({
    super.key,
    required this.controller,
    this.width,
    required this.hint,
    required this.hintKey,
  });

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (widget.width ?? 375).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75.h,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              obscureText: _obscureText,
              obscuringCharacter: '*',
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus();
              },
              decoration: InputDecoration(
                hintText: widget.hintKey.tr(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textGrey,
                  ),
                  onPressed: _toggleVisibility,
                ),
              ),
              validator: (value) => Validator.validatePassword(value),
            ),
          ),
        ],
      ),
    );
  }
}
