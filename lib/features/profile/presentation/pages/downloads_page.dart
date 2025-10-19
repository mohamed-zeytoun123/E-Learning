import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_download_item.dart';
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
          itemCount: 9,
          itemBuilder: (context, index) =>
              CustomDownloadItem(vidTitle: "Video's Title", vidDuration: 52),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: AppColors.dividerGrey);
          },
        ),
      ),
    );
  }
}
