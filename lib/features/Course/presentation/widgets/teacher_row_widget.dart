import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
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
    final colors= context.colors;
    return Row(
      spacing: 12.h,
      children: [
        ShowImageTeacherWidget(teacherImageUrl: teacherImageUrl),
        Expanded(
          child: Text(
            teacherName,
            style: AppTextStyles.s16w500.copyWith(color:colors.textPrimary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
