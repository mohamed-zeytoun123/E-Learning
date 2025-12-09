// import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ShowImageTeacherWidget extends StatelessWidget {
//   const ShowImageTeacherWidget({super.key, required this.teacherImageUrl});

//   final String teacherImageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(999.r),
//       child: CustomCachedImageWidget(
//         appImage: teacherImageUrl,
//         width: 64.w,
//         height: 64.h,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowImageTeacherWidget extends StatelessWidget {
  const ShowImageTeacherWidget({super.key, required this.teacherImageUrl});

  final String teacherImageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: CustomCachedImageWidget(
        appImage: teacherImageUrl,
        width: 64.w,
        height: 64.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
