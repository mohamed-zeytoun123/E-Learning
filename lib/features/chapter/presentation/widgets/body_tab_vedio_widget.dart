import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/chapter/presentation/widgets/video_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabVedioWidget extends StatelessWidget {
  final bool isActive;
  final int unlockedVideos;
  final Function(int index)? onVideoTap;

  const BodyTabVedioWidget({
    super.key,
    this.isActive = false,
    this.unlockedVideos = 3,
    this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          final isVideoEnabled = isActive || index < unlockedVideos;
          return InkWell(
            onTap: isVideoEnabled
                ? () {
                    if (onVideoTap != null) {
                      onVideoTap!(index);
                    }
                    log("Video $index pressed");
                  }
                : null,
            child: VideoRowWidget(
              chapterTitle: "Video ${index + 1} Title",
              durationMinutes: 126,
              completedVideos: 22,
              totalVideos: 40,
              isLocked: !isVideoEnabled,
              onTap: isVideoEnabled
                  ? () {
                      if (onVideoTap != null) onVideoTap!(index);
                    }
                  : null,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.h, color: context.colors.dividerGrey),
      ),
    );
  }
}
