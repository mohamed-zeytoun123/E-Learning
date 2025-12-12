import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r), // You can adjust this value
        ),
      ),
      backgroundColor: colors.textBlue,
      toolbarHeight: 100.h,
      title: Text.rich(
        TextSpan(
          text: 'welcome'.tr(),
          style: AppTextStyles.s18w600.copyWith(color: colors.textPrimary),
          children: [
            TextSpan(
              text: ' ${'user_name'.tr()} !',
              style: AppTextStyles.s18w600.copyWith(color: colors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(155.h);
}
