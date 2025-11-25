import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
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
    return BlocBuilder<ChapterCubit, ChapterState>(
      builder: (context, state) {
        /// ---------------------------- Loading State ----------------------------
        if (state.attachmentsStatus == ResponseStatusEnum.loading) {
          return Center(child: AppLoading.circular());
        }

        final attachments = state.attachments ?? [];

        /// ---------------------------- Empty State ----------------------------
        if (state.attachmentsStatus == ResponseStatusEnum.success &&
            attachments.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  size: 50.sp,
                  color: AppColors.textGrey.withOpacity(0.5),
                ),
                12.sizedH,
                Text(
                  "No files available",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                6.sizedH,
                Text(
                  "This chapter does not contain any files",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        /// ---------------------------- Failure State ----------------------------
        if (state.attachmentsStatus == ResponseStatusEnum.failure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 50.sp,
                  color: AppColors.iconError,
                ),
                12.sizedH,
                Text(
                  state.attachmentsError ?? "Failed to load files",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s14w600.copyWith(
                    color: AppColors.textError,
                  ),
                ),
                15.sizedH,
                CustomButton(
                  title: "Retry",
                  buttonColor: AppColors.buttonPrimary,
                  onTap: () {
                    final chapterId =
                        context.read<ChapterCubit>().state.chapter?.id ?? 0;
                    context.read<ChapterCubit>().getChapterAttachments(
                          chapterId: chapterId,
                        );
                  },
                ),
              ],
            ),
          );
        }

        /// ---------------------------- Success State (list) ----------------------------
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              final file = attachments[index];
              final downloadState = context
                  .watch<ChapterCubit>()
                  .state
                  .attachmentDownloads[file.id];

              return InkWell(
                onTap: widget.isActive
                    ? () {
                        if (widget.onFileTap != null) widget.onFileTap!(index);
                      }
                    : null,
                child: FileRowWidget(
                  chapterTitle: file.fileName,
                  sizeFile: double.tryParse(file.fileSizeMb) ?? 0,
                  isDownloading: downloadState?.isDownloading ?? false,
                  downloadProgress: downloadState?.progress ?? 0.0,
                  isDownloaded: downloadState?.isDownloaded ?? false,
                  onTap: widget.isActive
                      ? () {
                          if (widget.onFileTap != null) {
                            widget.onFileTap!(index);
                          }
                        }
                      : null,
                ),
              );
            },
            separatorBuilder: (_, __) =>
                Divider(height: 1.h, color: AppColors.dividerGrey),
          ),
        );
      },
    );
  }
}
