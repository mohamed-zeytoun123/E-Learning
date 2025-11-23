import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_state.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeachersTabContent extends StatefulWidget {
  const TeachersTabContent({super.key});

  @override
  State<TeachersTabContent> createState() => _TeachersTabContentState();
}

class _TeachersTabContentState extends State<TeachersTabContent> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = context.read<TeacherCubit>().state;
      if (state.hasNextPage &&
          state.teachersStatus != ResponseStatusEnum.loading) {
        _loadMoreTeachers();
      }
    }
  }

  void _loadMoreTeachers() {
    final nextPage = _currentPage + 1;
    context.read<TeacherCubit>().getTeachers(
          page: nextPage,
          pageSize: 10,
          search: _searchQuery.isEmpty ? null : _searchQuery,
        );
    _currentPage = nextPage;
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _currentPage = 1;
    });
    if (query.isEmpty) {
      context.read<TeacherCubit>().getTeachers(page: 1, pageSize: 10);
    } else {
      context.read<TeacherCubit>().getTeachers(
            page: 1,
            pageSize: 10,
            search: query,
          );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
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
              hintText: 'search_teachers'.tr(),
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
              // Debounce search
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchController.text == value) {
                  _performSearch(value);
                }
              });
            },
            onSubmitted: _performSearch,
          ),
        ),
        // Teachers List
        Expanded(
          child: BlocBuilder<TeacherCubit, TeacherState>(
            builder: (context, state) {
              if (state.teachersStatus == ResponseStatusEnum.loading &&
                  (state.teachers?.isEmpty ?? true)) {
                return GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: TeatcherCard(
                        teacher: TeacherModel(
                          id: 0,
                          fullName: 'Loading...',
                          coursesNumber: 0,
                          students: 0,
                          courses: [],
                        ),
                      ),
                    );
                  },
                );
              }

              if (state.teachersStatus == ResponseStatusEnum.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.textError,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        state.teachersError ?? 'something_went_wrong'.tr(),
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textError,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              final teachers = state.teachers ?? [];

              if (teachers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 64.sp,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'no_teachers_found'.tr(),
                        style: AppTextStyles.s18w600.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.7,
                ),
                itemCount: teachers.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= teachers.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final teacher = teachers[index];
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
      ],
    );
  }
}

