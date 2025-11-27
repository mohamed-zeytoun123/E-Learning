import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_bottom_sheet.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_notice_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_info_summary_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/your_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseAccessContentWidget extends StatelessWidget {
  final int completedVideos;
  final int totalVideos;
  final int videoCount;
  final double hoursCount;
  final int courseId;
  final String price;
  final bool isActive;

  const CourseAccessContentWidget({
    super.key,
    required this.completedVideos,
    required this.courseId,
    required this.totalVideos,
    required this.videoCount,
    required this.hoursCount,
    required this.price,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
      selector: (state) => state.appState,
      builder: (context, appState) {
        if (appState == AppStateEnum.guest) {
          return CourseSuspendedNoticeWidget(
            onContactPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: false,
                builder: (context) => const CourseSuspendedBottomSheet(),
              );
            },
          );
        } else if (appState == AppStateEnum.user) {
          if (isActive) {
            return YourProgressWidget(
              completedVideos: completedVideos,
              videoCount: videoCount,
            );
          } else {
            return CourseInfoSummaryWidget(
              videoCount: videoCount,
              hoursCount: hoursCount,
              price: price,
              courseId: courseId,
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
