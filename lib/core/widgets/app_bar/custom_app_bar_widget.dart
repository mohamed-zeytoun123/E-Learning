import 'package:e_learning/core/themes/theme_extensions.dart';
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
    final colors =context.colors;
    return AppBar(
      backgroundColor:colors.background,
      centerTitle: false,
      titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
      title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color: colors.textPrimary)),
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      leading: showBack
          ? IconButton(
              icon:  Icon(Icons.arrow_back_ios_new_rounded,color: colors.textPrimary,),
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
