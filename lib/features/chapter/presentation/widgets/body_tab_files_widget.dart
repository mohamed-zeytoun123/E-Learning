import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/widgets/file_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabFilesWidget extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onFileTap;

  const BodyTabFilesWidget({super.key, this.isActive = true, this.onFileTap});

  @override
  State<BodyTabFilesWidget> createState() => _BodyTabFilesWidgetState();
}

class _BodyTabFilesWidgetState extends State<BodyTabFilesWidget> {
  @override
  void initState() {
    final chapterId = context.read<ChapterCubit>().state.chapter?.id ?? 0;
    context.read<ChapterCubit>().getChapterAttachments(chapterId: chapterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attachments = context.read<ChapterCubit>().state.attachments ?? [];

    if (attachments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 50.sp,
              color: AppColors.textGrey,
            ),
            SizedBox(height: 10.h),
            Text(
              "No files available for this chapter.",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          final file = attachments[index];
          return InkWell(
            onTap: widget.isActive
                ? () {
                    if (widget.onFileTap != null) widget.onFileTap!(index);
                    log("File ${file.id} pressed");
                  }
                : null,
            child: FileRowWidget(
              chapterTitle: file.fileName,
              sizeFile: double.tryParse(file.fileSizeMb) ?? 0,
              onTap: widget.isActive
                  ? () {
                      if (widget.onFileTap != null) widget.onFileTap!(index);
                      log("File ${file.id} pressed");
                    }
                  : null,
            ),
          );
        },
        separatorBuilder: (_, __) =>
            Divider(height: 1.h, color: AppColors.dividerGrey),
      ),
    );
  }
}
