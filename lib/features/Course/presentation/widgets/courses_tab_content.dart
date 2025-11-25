import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesTabContent extends StatefulWidget {
  const CoursesTabContent({super.key});

  @override
  State<CoursesTabContent> createState() => _CoursesTabContentState();
}

class _CoursesTabContentState extends State<CoursesTabContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isEmpty) {
      context.read<CourseCubit>().getCourses(page: 1, pageSize: 10);
    } else {
      context.read<CourseCubit>().getCourses(
            page: 1,
            pageSize: 10,
            search: query,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'search_courses'.tr(),
              prefixIcon: const Icon(Icons.search, color: AppColors.iconBlue),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.iconGrey),
                      onPressed: () {
                        _searchController.clear();
                        _performSearch('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.backgroundPage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.buttonPrimary, width: 2),
              ),
            ),
            onChanged: (value) {
              // Debounce search - perform search after user stops typing
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchController.text == value) {
                  _performSearch(value);
                }
              });
            },
            onSubmitted: _performSearch,
          ),
        ),
        // Courses List
        Expanded(
          child: BlocBuilder<CourseCubit, CourseState>(
            buildWhen: (previous, current) =>
                previous.coursesStatus != current.coursesStatus ||
                previous.courses != current.courses,
            builder: (context, state) {
              if (state.coursesStatus == ResponseStatusEnum.loading &&
                  (state.courses?.courses?.isEmpty ?? true)) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.coursesStatus == ResponseStatusEnum.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.textError,
                      ),
                      16.sizedH,
                      Text(
                        state.coursesError ?? 'something_went_wrong'.tr(),
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textError,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return const FilterWidget();
            },
          ),
        ),
      ],
    );
  }
}

