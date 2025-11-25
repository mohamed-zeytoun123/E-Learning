import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticlesTabContent extends StatefulWidget {
  const ArticlesTabContent({super.key});

  @override
  State<ArticlesTabContent> createState() => _ArticlesTabContentState();
}

class _ArticlesTabContentState extends State<ArticlesTabContent> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  int _currentPage = 1;

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
    final nextPage = _currentPage + 1;
    context.read<ArticleCubit>().getArticles(
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
              hintText: 'search_articles'.tr(),
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
        // Articles List
        Expanded(
          child: BlocBuilder<ArticleCubit, ArticleState>(
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
          ),
        ),
      ],
    );
  }
}







