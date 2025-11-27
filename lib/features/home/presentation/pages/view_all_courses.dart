import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ViewAllCourses extends StatelessWidget {
  const ViewAllCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (context) => CourseCubit(repo: di<CourceseRepository>())
        ..getCourses()
        ..getCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("courses".tr()),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const FiltersBottomSheetWidget(),
                  );
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
        ),
        body: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            final categories = state.categories ?? [];
            final labels =
                ['all'.tr()] + categories.map((c) => c.name).toList();

            return Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: AppPadding.defaultScreen.copyWith(end: 0),
                  child: ChipsBar(
                    labels: labels,
                    onChipSelected: (value) {
                      if (value == 'all'.tr()) {
                        // Show all courses
                        context.read<CourseCubit>().getCourses();
                      } else {
                        // Find category by name and filter
                        if (categories.isNotEmpty) {
                          final category = categories.firstWhere(
                            (c) => c.name == value,
                            orElse: () => categories.first,
                          );
                          context.read<CourseCubit>().getCourses(
                                filters: CourseFiltersModel()
                                    .copyWith(categoryId: category.id),
                              );
                        }
                      }
                    },
                    withFilter: true,
                    onFilterTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const FiltersBottomSheetWidget(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FilterWidget(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
