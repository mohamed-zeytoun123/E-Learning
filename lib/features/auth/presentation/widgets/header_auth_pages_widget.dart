import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_logo/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAuthPagesWidget extends StatelessWidget {
  const HeaderAuthPagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        AppLogoWidget(imagePath: "no image"),
        SizedBox(height: 20.h),
        Text(
          "‘AppName’",
          style: AppTextStyles.s16w600.copyWith(color:colors.textGrey ),//textBlack
        ),
      ],
    );
  }
}
