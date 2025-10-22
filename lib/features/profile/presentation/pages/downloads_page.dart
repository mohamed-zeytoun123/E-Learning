import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar.dart';
import 'package:e_learning/features/chapter/presentation/widgets/video_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Downloads', showBack: true),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 32.h),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              // context.push(RouteNames.c)
            },
            child: VideoRowWidget(
              chapterTitle: "Video’s Title",
              durationMinutes: 52,
              onTap: () {
                log("Chapter 4 pressed");
                //Todo complete videos
              },
              completedVideos: 14,
              totalVideos: 40,
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1.h, color: AppColors.dividerGrey),
        ),
      ),
    );
  }
}
