import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/show_image_teacher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherRowWidget extends StatelessWidget {
  final String teacherName;
  final String teacherImageUrl;

  const TeacherRowWidget({
    super.key,
    required this.teacherName,
    required this.teacherImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.h,
      children: [
        ShowImageTeacherWidget(teacherImageUrl: teacherImageUrl),

        Expanded(
          child: Text(
            teacherName,
            style: AppTextStyles.s16w500.copyWith(color: AppColors.textBlack),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
