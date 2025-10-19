import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_files_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_quizzes_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_vedio_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChaptersTabViewWidget extends StatelessWidget {
  const ChaptersTabViewWidget({super.key});

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
                    Icon(Icons.play_circle_outline, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Chapters"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.insert_drive_file_outlined, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Files"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit_note, size: 20.r),
                    SizedBox(width: 4.w),
                    Text("Quizzes"),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                BodyTabVedioWidget(),
                BodyTabFilesWidget(),
                BodyTabQuizzesWidget(),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
