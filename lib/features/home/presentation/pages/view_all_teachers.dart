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

class ViewAllTeachers extends StatefulWidget {
  const ViewAllTeachers({super.key});

  @override
  State<ViewAllTeachers> createState() => _ViewAllTeachersState();
}

class _ViewAllTeachersState extends State<ViewAllTeachers> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.85) {
      final cubit = context.read<TeacherCubit>();
      final state = cubit.state;

      // Only load more if there's a next page and not already loading
      if (state.hasNextPage &&
          state.teachersStatus != ResponseStatusEnum.loading) {
        cubit.loadMoreTeachers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherCubit(repo: appLocator<TeacherRepository>())
        ..getTeachers(page: 1, pageSize: 10),
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
        ),
        body: BlocBuilder<TeacherCubit, TeacherState>(
          builder: (context, state) {
            // Handle error state (only show if no teachers loaded)
            if (state.teachersStatus == ResponseStatusEnum.failure &&
                (state.teachers == null || state.teachers!.isEmpty)) {
              return const CustomErrorWidget();
            }

            // Handle initial loading state (when no teachers loaded yet)
            if (state.teachersStatus == ResponseStatusEnum.loading &&
                (state.teachers == null || state.teachers!.isEmpty)) {
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
                      avatarSize: 120,
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
            final teachers = state.teachers ?? [];
            final isLoadingMore =
                state.teachersStatus == ResponseStatusEnum.loading &&
                    teachers.isNotEmpty;

            return GridView.builder(
              controller: _scrollController,
              padding: AppPadding.appPadding.copyWith(top: 32),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 28,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: teachers.length + (isLoadingMore ? 2 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at the bottom when loading more
                if (index >= teachers.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final teacher = teachers[index];
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TeatcherCard(
                    teacher: teacher,
                    avatarSize: 120,
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
