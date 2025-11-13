import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_state.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ViewAllTeachers extends StatelessWidget {
  const ViewAllTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TeacherCubit(repo: appLocator<TeacherRepository>())..getTeachers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("teachers".tr()),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: BlocBuilder<TeacherCubit, TeacherState>(
          builder: (context, state) {
            // Handle error state
            if (state.teachersStatus == ResponseStatusEnum.failure) {
              return const CustomErrorWidget();
            }

            // Handle loading state
            if (state.teachersStatus == ResponseStatusEnum.loading) {
              return Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  padding: AppPadding.appPadding.copyWith(top: 32),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 28,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return TeatcherCard(
                      teacher: TeacherModel(
                        id: 0,
                        fullName: 'Loading...',
                        coursesNumber: 0,
                        students: 0,
                        courses: [],
                      ),
                    );
                  },
                ),
              );
            }

            // Handle empty state
            if (state.teachers == null || state.teachers!.isEmpty) {
              return Center(
                child: Text(
                  'no_teachers_available'.tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              );
            }

            // Show teachers grid
            return GridView.builder(
              padding: AppPadding.appPadding.copyWith(top: 32),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 28,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: state.teachers!.length,
              itemBuilder: (context, index) {
                final teacher = state.teachers![index];
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
            );
          },
        ),
      ),
    );
  }
}
