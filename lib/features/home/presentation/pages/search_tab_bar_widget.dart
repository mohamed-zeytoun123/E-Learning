import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchTabBarWidget extends StatefulWidget {
  final SearchCubit searchCubit;

  const SearchTabBarWidget({super.key, required this.searchCubit});

  @override
  State<SearchTabBarWidget> createState() => _SearchTabBarWidgetState();
}

class _SearchTabBarWidgetState extends State<SearchTabBarWidget> {
  final ScrollController _coursesScrollController = ScrollController();
  final ScrollController _articlesScrollController = ScrollController();
  final ScrollController _teachersScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _coursesScrollController.addListener(_onCoursesScroll);
    _articlesScrollController.addListener(_onArticlesScroll);
    _teachersScrollController.addListener(_onTeachersScroll);
  }

  @override
  void dispose() {
    _coursesScrollController.removeListener(_onCoursesScroll);
    _coursesScrollController.dispose();
    _articlesScrollController.removeListener(_onArticlesScroll);
    _articlesScrollController.dispose();
    _teachersScrollController.removeListener(_onTeachersScroll);
    _teachersScrollController.dispose();
    super.dispose();
  }

  void _onCoursesScroll() {
    if (!mounted) return;
    if (_coursesScrollController.position.pixels >=
        _coursesScrollController.position.maxScrollExtent * 0.85) {
      final state = widget.searchCubit.state;
      if (state.coursesHasNextPage &&
          state.status != ResponseStatusEnum.loading) {
        widget.searchCubit.loadMoreCourses();
      }
    }
  }

  void _onArticlesScroll() {
    if (!mounted) return;
    if (_articlesScrollController.position.pixels >=
        _articlesScrollController.position.maxScrollExtent * 0.85) {
      final state = widget.searchCubit.state;
      if (state.articlesHasNextPage &&
          state.status != ResponseStatusEnum.loading) {
        widget.searchCubit.loadMoreArticles();
      }
    }
  }

  void _onTeachersScroll() {
    if (!mounted) return;
    if (_teachersScrollController.position.pixels >=
        _teachersScrollController.position.maxScrollExtent * 0.85) {
      final state = widget.searchCubit.state;
      if (state.teachersHasNextPage &&
          state.status != ResponseStatusEnum.loading) {
        widget.searchCubit.loadMoreTeachers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: widget.searchCubit,
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          initialIndex: state.selectedTabIndex,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  widget.searchCubit.changeTabIndex(index);
                },
                indicatorColor: AppColors.textGrey,
                labelColor: AppColors.blackText,
                unselectedLabelColor: AppColors.textGrey,
                tabs: [
                  Tab(
                    text: 'courses'.tr(),
                  ),
                  Tab(
                    text: 'articles'.tr(),
                  ),
                  Tab(
                    text: 'teachers'.tr(),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Courses Tab
                    _buildCoursesTab(context, state),
                    // Articles Tab
                    _buildArticlesTab(context, state),
                    // Teachers Tab
                    _buildTeachersTab(context, state),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoursesTab(BuildContext context, SearchState state) {
    if (state.status == ResponseStatusEnum.loading && state.courses.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure && state.courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  widget.searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 60.sp,
              color: AppColors.textError.withOpacity(0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              'no_courses_available'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.textError,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'select_another_category'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textError.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    final isLoadingMore = state.status == ResponseStatusEnum.loading &&
        state.courses.isNotEmpty;

    return Padding(
      padding: AppPadding.appPadding.copyWith(top: 16.h),
      child: ListView.separated(
        controller: _coursesScrollController,
        itemCount: state.courses.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemBuilder: (context, index) {
          if (index >= state.courses.length) {
            return Padding(
              padding: EdgeInsets.all(16.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final course = state.courses[index];
          final courseCubit = CourseCubit(
            repo: appLocator<CourceseRepository>(),
          );
          return CourseInfoCardWidget(
            imageUrl: course.image ?? '',
            title: course.title,
            subtitle: course.collegeName,
            rating: (course.averageRating ?? 0).toDouble(),
            price: course.price,
            isFavorite: course.isFavorite,
            onTap: () {
              context.push(
                RouteNames.courceInf,
                extra: {
                  'courseId': course.id,
                  'courseCubit': courseCubit,
                },
              );
            },
            onSave: () {
              courseCubit.toggleFavorite(
                courseId: '${course.id}',
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}, ${date.year}';
  }

  Widget _buildArticlesTab(BuildContext context, SearchState state) {
    if (state.status == ResponseStatusEnum.loading && state.articles.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure && state.articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  widget.searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 60.sp,
              color: AppColors.textError.withOpacity(0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              'no_articles_available'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.textError,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'select_another_category'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textError.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    final isLoadingMore = state.status == ResponseStatusEnum.loading &&
        state.articles.isNotEmpty;

    return Padding(
      padding: AppPadding.appPadding.copyWith(top: 16.h),
      child: ListView.separated(
        controller: _articlesScrollController,
        itemCount: state.articles.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          if (index >= state.articles.length) {
            return Padding(
              padding: EdgeInsets.all(16.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final article = state.articles[index];
          return InkWell(
            onTap: () {
              context.push(
                RouteNames.aticleDetails,
                extra: {'articleId': article.id},
              );
            },
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: article.image != null && article.image!.isNotEmpty
                    ? CustomCachedImageWidget(
                        appImage: article.image!,
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        Assets.resourceImagesPngHomeeBg,
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: AppTextStyles.s16w500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.stars,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            article.readingTime,
                            style: AppTextStyles.s12w400
                                .copyWith(color: AppColors.stars),
                          )
                        ],
                      ),
                      Text(
                        _formatDate(article.createdAt),
                        style: AppTextStyles.s12w400
                            .copyWith(color: AppColors.textGrey),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeachersTab(BuildContext context, SearchState state) {
    if (state.status == ResponseStatusEnum.loading && state.teachers.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure && state.teachers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  widget.searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.teachers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 60.sp,
              color: AppColors.textError.withOpacity(0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              'no_teachers_available'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.textError,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'select_another_category'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textError.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    final isLoadingMore = state.status == ResponseStatusEnum.loading &&
        state.teachers.isNotEmpty;

    return Padding(
      padding: AppPadding.appPadding.copyWith(top: 16.h),
      child: ListView.separated(
        controller: _teachersScrollController,
        itemCount: state.teachers.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          if (index >= state.teachers.length) {
            return Padding(
              padding: EdgeInsets.all(16.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final teacher = state.teachers[index];
          return Align(
            alignment: AlignmentDirectional.centerStart,
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
      ),
    );
  }
}
