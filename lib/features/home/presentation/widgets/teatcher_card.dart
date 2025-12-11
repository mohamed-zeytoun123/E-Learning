import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeatcherCard extends StatelessWidget {
  final TeacherModel teacher;
  final VoidCallback? onTap;
  final double? avatarSize;

  const TeatcherCard({
    super.key,
    required this.teacher,
    this.onTap,
    this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = avatarSize ?? 80.0;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: teacher.avatar != null && teacher.avatar!.isNotEmpty
                ? CustomCachedImageWidget(
                    appImage: teacher.avatar!,
                    width: size.w,
                    height: size.h,
                    fit: BoxFit.fill,
                  )
                : CircleAvatar(
                    radius: (size / 2).r,
                    backgroundColor: AppColors.textGrey.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      size: (size / 2).sp,
                      color: AppColors.textGrey,
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 100.w,
            child: Text(
              teacher.fullName,
              style: AppTextStyles.s14w400,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${teacher.coursesNumber} ${'courses'.tr()}',
            style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
