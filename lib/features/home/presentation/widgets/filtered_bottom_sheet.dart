import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/home/presentation/widgets/filter_wrap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showFilterBottomSheet(
  BuildContext context, {
  SearchCubit? searchCubit,
  CourseCubit? courseCubit,
}) {
  showModalBottomSheet(
    backgroundColor: AppColors.background,
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      // If CourseCubit is provided, use it; otherwise create a new one
      if (courseCubit != null) {
        // Ensure data is loaded (categories for courses)
        courseCubit.getUniversities();
        courseCubit.getCategories();
        courseCubit.getStudyYears();
        return BlocProvider<CourseCubit>.value(
          value: courseCubit,
          child: _FilterBottomSheetContent(
            searchCubit: searchCubit,
            courseCubit: courseCubit,
          ),
        );
      } else {
        return BlocProvider<CourseCubit>(
          create: (context) => CourseCubit(
            repo: di(),
          )
            ..getUniversities()
            ..getColleges()
            ..getStudyYears(),
          child: _FilterBottomSheetContent(searchCubit: searchCubit),
        );
      }
    },
  );
}

class _FilterBottomSheetContent extends StatefulWidget {
  final SearchCubit? searchCubit;
  final CourseCubit? courseCubit;

  const _FilterBottomSheetContent({
    this.searchCubit,
    this.courseCubit,
  });

  @override
  State<_FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<_FilterBottomSheetContent> {
  int? _selectedCollegeId;
  int? _selectedCategoryId;
  int? _selectedStudyYearId;
  int? _selectedUniversityIndex;
  int? _selectedCollegeIndex;
  int? _selectedCategoryIndex;
  int? _selectedStudyYearIndex;

  @override
  void initState() {
    super.initState();
    // Load current filters from SearchCubit or CourseCubit if available
    if (widget.searchCubit != null) {
      final filters = widget.searchCubit!.state.filters;
      _selectedCollegeId = filters?.collegeId;
      _selectedStudyYearId = filters?.studyYear;
    } else if (widget.courseCubit != null) {
      final filters = widget.courseCubit!.state.coursefilters;
      _selectedCategoryId = filters?.categoryId;
      _selectedStudyYearId = filters?.studyYear;
    }
  }

  void _applyFilters() {
    if (widget.searchCubit != null) {
      // For search: use colleges
      final filters = CourseFiltersModel(
        collegeId: _selectedCollegeId,
        studyYear: _selectedStudyYearId,
      );
      widget.searchCubit!.updateFilters(filters);

      // Re-search if there's an active query
      final searchQuery = widget.searchCubit!.state.searchQuery;
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        widget.searchCubit!.searchCourses(
          searchQuery: searchQuery,
          filters: filters,
          ordering: '-price',
          page: 1,
          pageSize: 5,
        );
      }
    } else if (widget.courseCubit != null) {
      // For courses: use categories
      widget.courseCubit!.applyFiltersByIds(
        categoryId: _selectedCategoryId,
        studyYear: _selectedStudyYearId,
      );
    }

    Navigator.pop(context);
  }

  void _resetFilters() {
    setState(() {
      _selectedCollegeId = null;
      _selectedCategoryId = null;
      _selectedStudyYearId = null;
      _selectedUniversityIndex = null;
      _selectedCollegeIndex = null;
      _selectedCategoryIndex = null;
      _selectedStudyYearIndex = null;
    });

    if (widget.searchCubit != null) {
      widget.searchCubit!.updateFilters(null);
      final searchQuery = widget.searchCubit!.state.searchQuery;
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        widget.searchCubit!.searchCourses(
          searchQuery: searchQuery,
          filters: null,
          ordering: '-price',
          page: 1,
          pageSize: 5,
        );
      }
    } else if (widget.courseCubit != null) {
      widget.courseCubit!.applyFiltersByIds(
        categoryId: null,
        studyYear: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        final isForCourses = widget.courseCubit != null;

        final isLoading =
            (state.universitiesState != ResponseStatusEnum.success &&
                    state.universitiesState != ResponseStatusEnum.failure) ||
                (isForCourses
                    ? (state.categoriesStatus != ResponseStatusEnum.success &&
                        state.categoriesStatus != ResponseStatusEnum.failure)
                    : (state.collegesStatus != ResponseStatusEnum.success &&
                        state.collegesStatus != ResponseStatusEnum.failure)) ||
                (state.studyYearsStatus != ResponseStatusEnum.success &&
                    state.studyYearsStatus != ResponseStatusEnum.failure);

        final hasError =
            state.universitiesState == ResponseStatusEnum.failure ||
                (isForCourses
                    ? state.categoriesStatus == ResponseStatusEnum.failure
                    : state.collegesStatus == ResponseStatusEnum.failure) ||
                state.studyYearsStatus == ResponseStatusEnum.failure;

        if (isLoading) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.buttonPrimary),
            ),
          );
        }

        if (hasError) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50.sp, color: AppColors.textError),
                  12.sizedH,
                  Text(
                    'Error loading filters',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final universities = state.universities ?? [];
        final colleges = state.colleges ?? [];
        final categories = state.categories ?? [];
        final studyYears = state.studyYears ?? [];

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'filters'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Scrollable content
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Universities
                      if (universities.isNotEmpty)
                        _buildFilterSection(
                          'universities'.tr(),
                          universities.map((u) => u.name).toList(),
                          _selectedUniversityIndex ?? -1,
                          (index) {
                            setState(() {
                              if (_selectedUniversityIndex == index) {
                                _selectedUniversityIndex = null;
                              } else {
                                _selectedUniversityIndex = index;
                              }
                            });
                          },
                        ),
                      if (universities.isNotEmpty) SizedBox(height: 16),

                      // Categories (for courses) or Colleges (for search)
                      if (isForCourses && categories.isNotEmpty)
                        _buildFilterSection(
                          'categories'.tr(),
                          categories.map((c) => c.name).toList(),
                          _selectedCategoryIndex ?? -1,
                          (index) {
                            setState(() {
                              if (_selectedCategoryIndex == index) {
                                _selectedCategoryIndex = null;
                                _selectedCategoryId = null;
                              } else {
                                _selectedCategoryIndex = index;
                                _selectedCategoryId = categories[index!].id;
                              }
                            });
                          },
                        ),
                      if (isForCourses && categories.isNotEmpty)
                        SizedBox(height: 16),

                      // Colleges (for search only)
                      if (!isForCourses && colleges.isNotEmpty)
                        _buildFilterSection(
                          'colleges'.tr(),
                          colleges.map((c) => c.name).toList(),
                          _selectedCollegeIndex ?? -1,
                          (index) {
                            setState(() {
                              if (_selectedCollegeIndex == index) {
                                _selectedCollegeIndex = null;
                                _selectedCollegeId = null;
                              } else {
                                _selectedCollegeIndex = index;
                                _selectedCollegeId = colleges[index!].id;
                              }
                            });
                          },
                        ),
                      if (!isForCourses && colleges.isNotEmpty)
                        SizedBox(height: 16),

                      // Study Years
                      if (studyYears.isNotEmpty)
                        _buildFilterSection(
                          'study_years'.tr(),
                          studyYears.map((y) => y.name).toList(),
                          _selectedStudyYearIndex ?? -1,
                          (index) {
                            setState(() {
                              if (_selectedStudyYearIndex == index) {
                                _selectedStudyYearIndex = null;
                                _selectedStudyYearId = null;
                              } else {
                                _selectedStudyYearIndex = index;
                                _selectedStudyYearId = studyYears[index!].id;
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ),

              // Fixed buttons
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFilters,
                      child: Text('reset'.tr()),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      child: Text('apply'.tr()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    int selectedIndex,
    Function(int?) onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        FilterWrap(
          labels: options,
          selectedIndex: selectedIndex,
          onSelected: (index, label) {
            onSelected(index ?? -1);
          },
        ),
      ],
    );
  }
}
