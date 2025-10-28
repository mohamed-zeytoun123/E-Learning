import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/chapter/presentation/widgets/file_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabFilesWidget extends StatelessWidget {
  final bool isActive;
  final void Function(int index)? onFileTap;

  const BodyTabFilesWidget({super.key, this.isActive = true, this.onFileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => InkWell(
          onTap: isActive
              ? () {
                  if (onFileTap != null) onFileTap!(index);
                  log("File $index pressed");
                }
              : null,
          child: FileRowWidget(
            chapterTitle: "PDF Filename",
            sizeFile: 126,
            onTap: isActive
                ? () {
                    if (onFileTap != null) onFileTap!(index);
                    log("File $index pressed");
                  }
                : null,
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.h, color:context.colors.dividerGrey),
      ),
    );
  }
}
