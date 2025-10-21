import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/chapter/presentation/widgets/video_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabVedioWidget extends StatelessWidget {
  const BodyTabVedioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // context.push(RouteNames.c )
          },
          child: VideoRowWidget(
            chapterTitle: "Video’s Title",
            durationMinutes: 126,
            onTap: () {
              log("Chapter 4 pressed");
              //todo go to chapters
            },
            completedVideos: 22,
            totalVideos: 40,
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.h, color: AppColors.dividerGrey),
      ),
    );
  }
}
