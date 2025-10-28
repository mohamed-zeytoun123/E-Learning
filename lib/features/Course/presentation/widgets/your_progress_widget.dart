import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/video_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourProgressWidget extends StatelessWidget {
  const YourProgressWidget({
    required this.completedVideos,
    required this.totalVideos,
    super.key,
  });
  final int completedVideos;
  final int totalVideos;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color:colors.dividerGrey , thickness: 1, height: 16.h),
        Text(
          "Your Progress",
          style: AppTextStyles.s16w400.copyWith(color: colors.textBlue),
        ),
        SizedBox(height: 5.h),
        VideoProgressWidget(
          completedVideos: completedVideos,
          totalVideos: totalVideos,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
