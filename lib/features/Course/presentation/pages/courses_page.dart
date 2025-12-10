// import 'package:e_learning/core/initial/app_init_dependencies.dart';
// import 'package:e_learning/core/style/app_padding.dart';
// import 'package:e_learning/core/widgets/chips_bar.dart';
// import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
// import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
// import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
// import 'package:e_learning/features/home/presentation/widgets/filtered_bottom_sheet.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CoursesPage extends StatelessWidget {
//   const CoursesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CourseCubit>(
//       create: (context) => CourseCubit(
//         repo: appLocator<CourceseRepository>(),
//         authRepo: appLocator<AuthRepository>(),
//       )
//         ..getCourses()
//         ..getFilterCategories()
//         ..getColleges(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("courses".tr()),
//         ),
//         body: BlocBuilder<CourseCubit, CourseState>(
//           builder: (context, state) {
//             final categories = state.categories ?? [];
//             final labels =
//                 ['all'.tr()] + categories.map((c) => c.name).toList();

//             return Column(
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: AppPadding.appPadding.copyWith(end: 0),
//                   child: ChipsBar(
//                     labels: labels,
//                     onChipSelected: (value) {
//                       if (value == 'all'.tr()) {
//                         // Show all courses
//                         context.read<CourseCubit>().getCourses();
//                       } else {
//                         // Find category by name and filter
//                         if (categories.isNotEmpty) {
//                           final category = categories.firstWhere(
//                             (c) => c.name == value,
//                             orElse: () => categories.first,
//                           );
//                           context.read<CourseCubit>().getCourses(
//                                 categoryId: category.id,
//                               );
//                         }
//                       }
//                     },
//                     withFilter: true,
//                     onFilterTap: () {
//                       final courseCubit = context.read<CourseCubit>();
//                       showFilterBottomSheet(
//                         context,
//                         courseCubit: courseCubit,
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: FilterWidget(),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_category_tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (context) => CourseCubit(repo: appLocator<CourceseRepository>())
        ..getColleges()
        ..getCourses(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CourseCubit>();

          return Scaffold(
            backgroundColor: AppColors.backgroundPage,
            appBar: CustomAppBarCourseWidget(
              title: "Course’s Title",
              showBack: true,
              onSearch: () {
                log("app search");

                // cubit.getColleges();
                // cubit.getUniversities();
                // cubit.getCategories();
                // cubit.getStudyYears();

                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (_) => BlocProvider.value(
                //     value: cubit,
                //     child: const FiltersBottomSheetWidget(),
                //   ),
                // );
              },
            ),
            body: CustomCategoryTabBarWidget(),
          );
        },
      ),
    );
  }
}
