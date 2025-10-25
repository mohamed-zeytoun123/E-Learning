import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r), // You can adjust this value
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      toolbarHeight: 100.h,
      title: Text.rich(
        TextSpan(
          text: 'welcome'.tr(),
          style: AppTextStyles.s18w600.copyWith(color: Colors.white),
          children: [
            TextSpan(
              text: ' user name !',
              style: AppTextStyles.s18w600.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(155.h);
}
