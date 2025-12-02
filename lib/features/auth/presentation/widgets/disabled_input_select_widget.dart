import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisabledInputSelectWidget extends StatelessWidget {
  final String hint;
  final String onTapMessage;

  const DisabledInputSelectWidget({
    super.key,
    required this.hint,
    required this.onTapMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppMessage.showFlushbar(
          context: context,
          message: onTapMessage,
          iconData: Icons.error_outline_outlined,
          iconColor: AppColors.iconWhite,
          title: "Error",
          backgroundColor: AppColors.messageWarning,
          isShowProgress: true,
        );
      },
      child: Container(
        width: 361.w,
        height: 49.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderSecondary, width: 1.5),
          color: AppColors.backgroundDisabled,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          hint,
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
        ),
      ),
    );
  }
}
