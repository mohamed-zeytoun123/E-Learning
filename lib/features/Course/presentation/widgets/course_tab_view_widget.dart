// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';
// import 'package:e_learning/features/course/presentation/widgets/body_tab_about_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/body_tab_chapter_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/body_tab_reviews_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CourseTabViewWidget extends StatelessWidget {
//   const CourseTabViewWidget({super.key, required this.isActive});
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         children: [
//           TabBar(
//             dividerColor: AppColors.dividerGrey,
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicatorColor: AppColors.textPrimary,
//             indicatorWeight: 2.h,
//             labelColor: AppColors.textPrimary,
//             unselectedLabelColor: AppColors.textGrey,
//             labelStyle: AppTextStyles.s14w600,
//             tabs: [
//               Tab(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.play_arrow, size: 20.sp),
//                     SizedBox(width: 4.w),
//                     Text("Chapter"),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.format_align_left_outlined, size: 20.sp),
//                     SizedBox(width: 4.w),
//                     Text("About"),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.chat_outlined, size: 20.sp),
//                     SizedBox(width: 4.w),
//                     Text("Reviews"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 BodyTabChapterWidget(isActive: isActive),
//                 BodyTabAboutWidget(isActive: isActive),
//                 BodyTabReviewsWidget(isActive: isActive),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/body_tab_about_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/body_tab_chapter_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/body_tab_reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTabViewWidget extends StatelessWidget {
  const CourseTabViewWidget({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: AppColors.dividerGrey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.textPrimary,
            indicatorWeight: 2.h,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textGrey,
            labelStyle: AppTextStyles.s14w600,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Chapter"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.format_align_left_outlined, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("About"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_outlined, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Reviews"),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                BodyTabChapterWidget(isActive: isActive),
                BodyTabAboutWidget(isActive: isActive),
                BodyTabReviewsWidget(isActive: isActive),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
