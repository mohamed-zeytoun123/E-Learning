import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.showBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.background,
      centerTitle: false,
      titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
      title: Text(title, style: AppTextStyles.s18w600.copyWith(
        color: context.colors.textPrimary,
      ),),
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      leading: showBack
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,color: context.colors.textPrimary,),
              onPressed: () {
                context.pop();
                // log(message)
              },
            )
          : null,

      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
