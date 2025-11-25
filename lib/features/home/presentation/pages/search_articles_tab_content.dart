import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchArticlesTabContent extends StatefulWidget {
  final SearchCubit searchCubit;
  
  const SearchArticlesTabContent({
    super.key,
    required this.searchCubit,
  });

  @override
  State<SearchArticlesTabContent> createState() => _SearchArticlesTabContentState();
}

class _SearchArticlesTabContentState extends State<SearchArticlesTabContent> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  String? _lastSearchQuery;

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = context.read<ArticleCubit>().state;
      if (state.hasNextPage &&
          state.articlesStatus != ResponseStatusEnum.loading) {
        _loadMoreArticles();
      }
    }
  }

  void _loadMoreArticles() {
    final searchState = widget.searchCubit.state;
    final searchQuery = searchState.searchQuery;
    final nextPage = _currentPage + 1;
    context.read<ArticleCubit>().getArticles(
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
      context.read<ArticleCubit>().getArticles(page: 1, pageSize: 10);
    } else {
      context.read<ArticleCubit>().getArticles(
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
                    Icons.article_outlined,
                    size: 64.sp,
                    color: AppColors.textGrey,
                  ),
                  16.sizedH,
                  Text(
                    'search_for_articles'.tr(),
                    style: AppTextStyles.s18w600.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Articles List
          return BlocBuilder<ArticleCubit, ArticleState>(
            builder: (context, state) {
              if (state.articlesStatus == ResponseStatusEnum.loading &&
                  (state.articles?.isEmpty ?? true)) {
                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: 5,
                  separatorBuilder: (context, index) => 12.sizedH,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            color: AppColors.textGrey.withOpacity(0.2),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20.h,
                              width: double.infinity,
                              color: AppColors.textGrey.withOpacity(0.2),
                            ),
                            8.sizedH,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 16.h,
                                  width: 80.w,
                                  color: AppColors.textGrey.withOpacity(0.2),
                                ),
                                Container(
                                  height: 16.h,
                                  width: 100.w,
                                  color: AppColors.textGrey.withOpacity(0.2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              if (state.articlesStatus == ResponseStatusEnum.failure) {
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
                        state.articlesError ?? 'something_went_wrong'.tr(),
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textError,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              final articles = state.articles ?? [];

              if (articles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64.sp,
                        color: AppColors.textGrey,
                      ),
                      16.sizedH,
                      Text(
                        'no_articles_found'.tr(),
                        style: AppTextStyles.s18w600.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: articles.length + (state.articlesStatus == ResponseStatusEnum.loading ? 1 : 0),
                separatorBuilder: (context, index) => 12.sizedH,
                itemBuilder: (context, index) {
                  if (index >= articles.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final article = articles[index];
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
                            : Container(
                                width: 80.w,
                                height: 80.h,
                                color: AppColors.textGrey.withOpacity(0.2),
                                child: Icon(
                                  Icons.article,
                                  size: 40.sp,
                                  color: AppColors.textGrey,
                                ),
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
                          8.sizedH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.h,
                                  horizontal: 12.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.orangeOverlay,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColors.stars,
                                      size: 16.sp,
                                    ),
                                    4.sizedW,
                                    Text(
                                      article.readingTime,
                                      style: AppTextStyles.s12w400.copyWith(
                                        color: AppColors.stars,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                _formatDate(article.createdAt),
                                style: AppTextStyles.s12w400.copyWith(
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

