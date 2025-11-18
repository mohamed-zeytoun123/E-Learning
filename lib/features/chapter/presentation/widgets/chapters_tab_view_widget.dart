import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/download/download_attachment_function.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_files_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_quizzes_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_vedio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChaptersTabViewWidget extends StatelessWidget {
  final bool isActive;
  final int unlockedVideos;
  final int chapterId;

  const ChaptersTabViewWidget({
    super.key,
    required this.isActive,
    required this.chapterId,
    this.unlockedVideos = 3,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);

          return Column(
            children: [
              TabBar(
                controller: tabController,
                dividerColor: AppColors.dividerGrey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.textPrimary,
                indicatorWeight: 2.h,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textGrey,
                labelStyle: AppTextStyles.s14w600,
                onTap: (index) {
                  if (!isActive && index != 0) {
                    tabController.index = 0;
                  }
                },
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text("Videos"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.insert_drive_file_outlined, size: 20.sp),
                        SizedBox(width: 4.w),
                        Row(
                          children: [
                            Text("Files"),
                            if (!isActive)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Icon(
                                  Icons.lock,
                                  size: 16.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_note, size: 20.sp),
                        SizedBox(width: 4.w),
                        Row(
                          children: [
                            Text("Quizzes"),
                            if (!isActive)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Icon(
                                  Icons.lock,
                                  size: 16.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: isActive
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    BodyTabVedioWidget(
                      isActive: isActive,
                      onVideoTap: (index) {
                        if (isActive || index < unlockedVideos) {
                          // context.push("/chapter/video/$index");
                        }
                      },
                    ),
                    BodyTabFilesWidget(
                      onFileTap: (index) {
                        if (isActive) {
                          final attachment = context
                              .read<ChapterCubit>()
                              .state
                              .attachments?[index];

                          downloadAttachment(
                            attachmentId: context
                                .read<ChapterCubit>()
                                .state
                                .attachments![index]
                                .id,
                            token: context.read<AppManagerCubit>().state.token,
                          );
                          // context.push("/chapter/file/$index");
                        }
                      },
                    ),
                    BodyTabQuizzesWidget(chapterId: chapterId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
