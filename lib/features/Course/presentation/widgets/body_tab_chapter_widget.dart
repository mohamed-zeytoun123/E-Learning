import 'dart:developer';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/model/enums/chapter_state_enum.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/chapter_row_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_enroll_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BodyTabChapterWidget extends StatelessWidget {
  const BodyTabChapterWidget({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chapter",
            style: AppTextStyles.s18w600.copyWith(color: colors.textPrimary),
          ),
          Expanded(
            child: BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
              selector: (state) => state.appState,
              builder: (context, appState) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    bool isChapterEnabled = false;

                    if (appState == AppStateEnum.guest) {
                      isChapterEnabled = false;
                    } else if (appState == AppStateEnum.user) {
                      if (isActive) {
                        isChapterEnabled = true;
                      } else {
                        isChapterEnabled = index < 1;
                      }
                    }

                    return ChapterRowWidget(
                      chapterNumber: index + 1,
                      chapterTitle: "Chapter’s Title",
                      videoCount: 4,
                      durationMinutes: 126,
                      chapterState: isChapterEnabled
                          ? ChapterStateEnum.open
                          : ChapterStateEnum.locked,
                      onTap: isChapterEnabled
                          ? () {
                              log("Chapter $index pressed");
                              context.push(
                                RouteNames.chapterPage,
                                extra: {"isActive": isActive},
                              );
                            }
                          : null,
                      index: index,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1.h, color:colors.dividerGrey ),
                );
              },
            ),
          ),

          BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
            selector: (state) => state.appState,
            builder: (context, appState) {
              if (appState == AppStateEnum.guest) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: const CourseSuspendedWidget(),
                );
              } else if (appState == AppStateEnum.user && !isActive) {
                return CourseEnrollWidget();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
