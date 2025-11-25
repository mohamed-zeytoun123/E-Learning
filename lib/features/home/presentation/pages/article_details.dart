import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticleDetailsPage extends StatefulWidget {
  final int? articleId;

  const ArticleDetailsPage({super.key, this.articleId});

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.background,
        title: Text(
          "news".tr(),
          style: TextStyle(color: context.colors.textPrimary),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<ArticleCubit, ArticleState>(
        listenWhen: (previous, current) =>
            previous.articleDetailsStatus != current.articleDetailsStatus,
        listener: (context, state) {
          // Fetch related articles when article details are successfully loaded
          if (state.articleDetailsStatus == ResponseStatusEnum.success &&
              widget.articleId != null &&
              state.articleDetails != null) {
            context.read<ArticleCubit>().getRelatedArticles(
                  articleId: widget.articleId!,
                );
          }
        },
        child: BlocBuilder<ArticleCubit, ArticleState>(
          buildWhen: (previous, current) =>
              previous.articleDetailsStatus != current.articleDetailsStatus ||
              previous.relatedArticlesStatus != current.relatedArticlesStatus,
          builder: (context, state) {
            // Handle error state
            if (state.articleDetailsStatus == ResponseStatusEnum.failure) {
              return const CustomErrorWidget();
            }

            // Handle loading state
            if (state.articleDetailsStatus == ResponseStatusEnum.loading) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: AppPadding.defaultScreen,
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        38.sizedH,
                        Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            width: double.infinity,
                            height: 240.h,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        32.sizedH,
                        Skeletonizer(
                          enabled: true,
                          child: Text(
                            'Loading article title...',
                            style: AppTextStyles.s18w600
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        24.sizedH,
                        Skeletonizer(
                          enabled: true,
                          child: Text(
                            'Loading article content...',
                            style: AppTextStyles.s14w500
                                .copyWith(color: AppColors.blackText),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            }

            // Handle empty state
            if (state.articleDetails == null) {
              return Center(
                child: Text(
                  'article_not_found'.tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              );
            }

            final article = state.articleDetails!;
            final displayDate = article.publishedAt ?? article.createdAt;

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppPadding.defaultScreen,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      38.sizedH,
                      if (article.image != null && article.image!.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: 240.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CustomCachedImageWidget(
                              appImage: article.image!,
                              width: double.infinity,
                              height: 240.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (article.content != null &&
                          article.content!.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: 240.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      32.sizedH,
                      Text(
                        article.title,
                        style: AppTextStyles.s18w600.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary),
                      ),
                      24.sizedH,
                      if (article.content != null &&
                          article.content!.isNotEmpty)
                        Text(
                          article.content!,
                          style: AppTextStyles.s14w500
                              .copyWith(color: context.colors.textGrey),
                          textAlign: TextAlign.justify,
                        )
                      else if (article.summary != null &&
                          article.summary!.isNotEmpty)
                        Text(
                          article.summary!,
                          style: AppTextStyles.s14w500
                              .copyWith(color: AppColors.blackText),
                          textAlign: TextAlign.justify,
                        ),
                      32.sizedH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (article.categoryName.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  color: context.colors.buttonTapNotSelected,
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Text(
                                article.categoryName,
                                style: AppTextStyles.s14w500
                                    .copyWith(color: context.colors.textBlue),
                              ),
                            ),
                          Text(
                            _formatDate(displayDate),
                            style: AppTextStyles.s14w500
                                .copyWith(color: context.colors.textBlue),
                          ),
                        ],
                      ),
                      64.sizedH,
                      Text(
                        'related_news'.tr(),
                        style: AppTextStyles.s16w600.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary),
                      ),
                      24.sizedH,
                    ]),
                  ),
                ),
                _RelatedArticlesSection(articleId: widget.articleId),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RelatedArticlesSection extends StatelessWidget {
  final int? articleId;

  const _RelatedArticlesSection({this.articleId});

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
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        // Handle loading state
        if (state.relatedArticlesStatus == ResponseStatusEnum.loading) {
          return SliverList.separated(
            separatorBuilder: (context, index) => 12.sizedH,
            itemCount: 3,
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
                      color: Colors.black,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loading article title...',
                        style: AppTextStyles.s16w500,
                      ),
                      8.sizedH,
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
                              4.sizedW,
                              Text(
                                '1 min',
                                style: AppTextStyles.s12w400
                                    .copyWith(color: AppColors.stars),
                              )
                            ],
                          ),
                          Text(
                            '15 Oct, 2025',
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
          );
        }

        // Handle error state
        if (state.relatedArticlesStatus == ResponseStatusEnum.failure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.defaultScreen,
              child: Center(
                child: Text(
                  'failed_to_load_related_articles'.tr(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          );
        }

        // Handle empty state
        final relatedArticles = state.relatedArticles ?? [];
        if (relatedArticles.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.defaultScreen,
              child: Center(
                child: Text(
                  'no_related_articles_available'.tr(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          );
        }

        // Display related articles
        return SliverList.separated(
          separatorBuilder: (context, index) => 12.sizedH,
          itemCount: relatedArticles.length,
          itemBuilder: (context, index) {
            final article = relatedArticles[index];
            return InkWell(
              onTap: () {
                context.push(
                  RouteNames.aticleDetails,
                  extra: {'articleId': article.id},
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            color: Colors.black,
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: AppColors.stars,
                                size: 16.sp,
                              ),
                              4.sizedW,
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
              ),
            );
          },
        );
      },
    );
  }
}
