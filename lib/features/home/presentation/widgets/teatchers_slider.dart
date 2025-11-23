import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_state.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeatchersSlider extends StatelessWidget {
  const TeatchersSlider({super.key, this.maxItems});

  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        // Handle error state
        if (state.teachersStatus == ResponseStatusEnum.failure) {
          return SizedBox(
            height: 140.h,
            child: const CustomErrorWidget(),
          );
        }

        // Calculate display teachers with maxItems limit
        final teachers = state.teachers ?? [];
        final displayTeachers = maxItems != null && teachers.length > maxItems!
            ? teachers.take(maxItems!).toList()
            : teachers;

        return Skeletonizer(
          enabled: state.teachersStatus == ResponseStatusEnum.loading,
          child: SizedBox(
            height: 140.h,
            child: state.teachers != null
                ? (state.teachers!.isEmpty
                    ? Center(
                        child: Text(
                          'no_teachers_available'.tr(),
                          style: TextStyle(fontSize: 14.sp,color: context.colors.textPrimary),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.w),
                        itemCount: displayTeachers.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final teacher = displayTeachers[index];
                          return FittedBox(
                            child: TeatcherCard(
                              teacher: teacher,
                              onTap: () {
                                context.push(
                                  RouteNames.teatcherPage,
                                  extra: {'teacher': teacher},
                                );
                              },
                            ),
                          );
                        },
                      ))
                : const CustomErrorWidget(),
          ),
        );
      },
    );
  }
}
