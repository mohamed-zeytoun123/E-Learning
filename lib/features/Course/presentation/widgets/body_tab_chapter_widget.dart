import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/chapter_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabChapterWidget extends StatelessWidget {
  const BodyTabChapterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chapter",
            style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => ChapterRowWidget(
                chapterNumber: 4,
                chapterTitle: "Chapter’s Title",
                videoCount: 4,
                durationMinutes: 126,
                onTap: () {
                  log("Chapter 4 pressed");
                  //todo go to chapters
                },
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1.h, color: AppColors.dividerGrey),
            ),
          ),
        ],
      ),
    );
  }
}
