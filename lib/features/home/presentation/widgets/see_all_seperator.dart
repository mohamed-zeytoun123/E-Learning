import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SeeAllSeperator extends StatelessWidget {
  const SeeAllSeperator({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Padding(
      padding: AppPadding.appPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.s18w600.copyWith(
              color: colors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'view_all'.tr(),
                  style: AppTextStyles.s14w400
                      .copyWith(color:colors.textBlue),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: colors.textBlue,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
