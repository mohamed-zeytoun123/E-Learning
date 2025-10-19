import 'package:e_learning/features/profile/presentation/widgets/downloads_vid_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDownloadItem extends StatelessWidget {
  final String vidTitle;
  final int vidDuration;

  const CustomDownloadItem({
    super.key,
    required this.vidTitle,
    required this.vidDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: SizedBox(
            height: 48.h,
            width: 48.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Theme.of(context).colorScheme.primary,
                size: 28.sp,
              ),
            ),
          ),
          title: Text(vidTitle),
          subtitle: Text('$vidDuration mins'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: DownloadsVidProgressWidget(
            completedTime: 25,
            totalVidTime: 100,
          ),
        ),
      ],
    );
  }
}
