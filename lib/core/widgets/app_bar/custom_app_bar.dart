import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  const CustomAppBar({super.key, required this.title, required this.showBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBlack,
      centerTitle: false,
      titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
      title: Text(
        title,
        style: AppTextStyles.s18w600.copyWith(color: AppColors.textWhite),
      ),
      leading: showBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.iconWhite,
              ),
              onPressed: () => context.pop(),
            )
          : null,

      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
