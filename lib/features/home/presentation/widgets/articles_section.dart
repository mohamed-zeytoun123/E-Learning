import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key});

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
        // Handle error state
        if (state.articlesStatus == ResponseStatusEnum.failure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.appPadding,
              child: const CustomErrorWidget(),
            ),
          );
        }

        // Display all articles from API (already limited to 5 by pageSize)
        final articles = state.articles;
        final displayArticles = articles ?? [];

        if (displayArticles.isEmpty &&
            state.articlesStatus == ResponseStatusEnum.loading) {
          return SliverList.separated(
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Skeletonizer(
                enabled: true,
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
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
                        'Article Title',
                        style: AppTextStyles.s16w500,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.stars,
                              ),
                              SizedBox(width: 4.w),
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
                                .copyWith(color: context.colors.textGrey),
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

        if (displayArticles.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.appPadding,
              child: Center(
                child: Text(
                  'no_articles_available'.tr(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          );
        }

        return SliverList.separated(
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemCount: displayArticles.length,
          itemBuilder: (context, index) {
            final article = displayArticles[index];
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
                      style: AppTextStyles.s16w500.copyWith(color: context.colors.textPrimary),
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
                              .copyWith(color: context.colors.textGrey),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
