import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarCourseWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onSearch;

  const CustomAppBarCourseWidget({
    super.key,
    required this.title,
    this.showBack = false,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppBar(
      backgroundColor: colors.appBarBlack,///a
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
      actions: [
        if (onSearch != null)
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppColors.iconWhite),
            onPressed: onSearch,
          ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onSearch;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.showBack = false,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppBar(
      // نحذف backgroundColor لأنه سيُستبدل بتدرّج
      backgroundColor: Colors.transparent,
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
      actions: [
        if (onSearch != null)
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppColors.iconWhite),
            onPressed: onSearch,
          ),
      ],
      // elevation: 0,

      /// هنا بنضيف التدرّج العمودي
      flexibleSpace: Container(
        decoration:  BoxDecoration(border: Border(bottom: BorderSide(color: colors.appBarWhite,style: BorderStyle.none)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color(0xff284C69), // لون غامق بالأعلى
              // Color(0xff547792), 
              context.colors.appBarBlack,
              context.colors.appBarWhite
              // أفتح شوي بالأسفل
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
