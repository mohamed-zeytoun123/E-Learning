import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_state.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchTeachersTabContent extends StatefulWidget {
  final SearchCubit searchCubit;
  
  const SearchTeachersTabContent({
    super.key,
    required this.searchCubit,
  });

  @override
  State<SearchTeachersTabContent> createState() => _SearchTeachersTabContentState();
}

class _SearchTeachersTabContentState extends State<SearchTeachersTabContent> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  String? _lastSearchQuery;

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
    final searchState = widget.searchCubit.state;
    final searchQuery = searchState.searchQuery;
    final nextPage = _currentPage + 1;
    context.read<TeacherCubit>().getTeachers(
          page: nextPage,
          pageSize: 10,
          search: searchQuery,
        );
    _currentPage = nextPage;
  }

  void _performSearch(String? query) {
    setState(() {
      _currentPage = 1;
    });
    if (query == null || query.isEmpty) {
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      bloc: widget.searchCubit,
      listener: (context, searchState) {
        // Only perform search when there's a valid query and history is not shown
        if (!searchState.showHistory && 
            searchState.searchQuery != null && 
            searchState.searchQuery!.isNotEmpty &&
            searchState.searchQuery != _lastSearchQuery) {
          _lastSearchQuery = searchState.searchQuery;
          _performSearch(searchState.searchQuery);
        } else if (searchState.showHistory) {
          // Reset when showing history
          _lastSearchQuery = null;
        }
      },
      child: BlocBuilder<SearchCubit, SearchState>(
        bloc: widget.searchCubit,
        builder: (context, searchState) {
          // Initialize search on first build if there's a query and history is not shown
          if (!searchState.showHistory &&
              _lastSearchQuery == null && 
              searchState.searchQuery != null &&
              searchState.searchQuery!.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _lastSearchQuery = searchState.searchQuery;
              _performSearch(searchState.searchQuery);
            });
          }
          
          // Show empty state when showing history or no search query
          if (searchState.showHistory || 
              searchState.searchQuery == null || 
              searchState.searchQuery!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 64.sp,
                    color: AppColors.textGrey,
                  ),
                  16.sizedH,
                  Text(
                    'search_for_teachers'.tr(),
                    style: AppTextStyles.s18w600.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Teachers List
          return BlocBuilder<TeacherCubit, TeacherState>(
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
                      16.sizedH,
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
                      16.sizedH,
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
          );
        },
      ),
    );
  }
}

