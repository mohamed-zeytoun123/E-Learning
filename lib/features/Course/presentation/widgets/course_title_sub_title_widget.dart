import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart' hide Colors, TextStyle;
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTitleSubTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;

  const CourseTitleSubTitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                titleStyle ??
                AppTextStyles.s16w500.copyWith(color: colors.textPrimary),
            maxLines: 1, // سماح بسطرين كحد أقصى
            overflow: TextOverflow.ellipsis, // إذا زاد، بيحط ...
          ),
          4.sizedH,
          Text(
            subtitle,
            style: AppTextStyles.s14w400.copyWith(color: colors.textGrey),
            maxLines: 1, // سطر واحد فقط
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
