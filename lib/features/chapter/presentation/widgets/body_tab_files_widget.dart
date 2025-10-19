import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/chapter/presentation/widgets/file_row_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/video_row_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/chapter_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BodyTabFilesWidget extends StatelessWidget {
  const BodyTabFilesWidget({super.key});

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
          child: FileRowWidget(
            chapterTitle: "PDF Filename",
            sizeFile: 126,
            onTap: () {
              log("Chapter 4 pressed");
              //todo go to chapters
            },
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.h, color: AppColors.dividerGrey),
      ),
    );
  }
}
