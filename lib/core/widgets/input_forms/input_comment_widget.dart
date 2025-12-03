import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class InputCommentWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool autofocus;
  final FocusNode? focusNode; // Add this parameter

  const InputCommentWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.autofocus = false,
    this.focusNode, // Add this parameter
  });

  @override
  State<InputCommentWidget> createState() => _InputCommentWidgetState();
}

class _InputCommentWidgetState extends State<InputCommentWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Use provided focus node or create a new one
    _focusNode = widget.focusNode ?? FocusNode();
    
    // Request focus with a delayed approach to prevent animation jank
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use a delayed approach to prevent conflicts with keyboard animations
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) {
            FocusScope.of(context).requestFocus(_focusNode);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    // Only dispose if we created the focus node (not provided externally)
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49.h,
      width: 361.w,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        autofocus: false, // Disable direct autofocus to prevent animation issues
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.borderBrand),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.borderBrand),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.borderPrimary),
          ),
        ),
        style: AppTextStyles.s14w400.copyWith(color: AppColors.textBlack),
      ),
    );
  }
}