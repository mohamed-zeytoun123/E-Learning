import 'dart:developer';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/Course/presentation/widgets/cource_review_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabReviewsWidget extends StatefulWidget {
  const BodyTabReviewsWidget({
    super.key,
    required this.isActive,
    required this.courseId,
  });
  final int courseId;
  final bool isActive;

  @override
  State<BodyTabReviewsWidget> createState() => _BodyTabReviewsWidgetState();
}

class _BodyTabReviewsWidgetState extends State<BodyTabReviewsWidget> {
  final TextEditingController reviewController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  void _handleFetchMore() {
    final cubit = context.read<CourseCubit>();
    final state = cubit.state;

    if (state.loadratingsMoreStatus == ResponseStatusEnum.loading) return;
    if ((state.ratings?.ratings?.isEmpty ?? true) ||
        !(state.ratings?.hasNextPage ?? false)) {
      return;
    }

    final nextPage = page + 1;
    log("Fetching more reviews, page: $nextPage");

    cubit
        .getRatings(
          courseId: "${widget.courseId}",
          reset: false,
          page: nextPage,
        )
        .then((_) {
          if (cubit.state.loadratingsMoreStatus != ResponseStatusEnum.failure) {
            page = nextPage;
          }
        })
        .catchError((_) {
          log("Fetch reviews failed, keep current page: $page");
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels > position.maxScrollExtent * 0.85) {
        _handleFetchMore();
      }
    });

    // جلب الصفحة الأولى عند الدخول
    context.read<CourseCubit>().getRatings(
      courseId: "${widget.courseId}",
      page: 1,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CourseCubit, CourseState>(
              buildWhen: (prev, curr) =>
                  prev.ratings != curr.ratings ||
                  prev.loadratingsMoreStatus != curr.loadratingsMoreStatus,
              builder: (context, state) {
                final reviews = state.ratings?.ratings ?? [];

                // حالة جلب البيانات لأول مرة
                if (state.ratingsStatus == ResponseStatusEnum.loading &&
                    reviews.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // حالة فشل الجلب
                if (state.ratingsStatus == ResponseStatusEnum.failure) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.iconError,
                            size: 40.sp,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.ratingsError ?? "Failed to load reviews",
                            style: TextStyle(color: AppColors.textRed),
                          ),
                          SizedBox(height: 14.h),

                          CustomButton(
                            onTap: () {
                              context.read<CourseCubit>().getRatings(
                                courseId: "${widget.courseId}",
                                page: 1,
                              );
                            },
                            title: "Retry",
                            buttonColor: AppColors.buttonPrimary,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state.ratingsStatus == ResponseStatusEnum.success &&
                    reviews.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.rate_review_outlined,
                              size: 60.sp,
                              color: AppColors.iconGrey.withOpacity(0.6),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No reviews yet",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s16w600.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Be the first to write a review for this course!",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.textGrey.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              onTap: () {
                                context.read<CourseCubit>().getRatings(
                                  courseId: "${widget.courseId}",
                                  page: 1,
                                );
                              },
                              title: "Ratry",
                              buttonColor: AppColors.buttonPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // ListView للتقييمات الموجودة
                return ListView.separated(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  itemCount: reviews.length + 1,
                  itemBuilder: (context, index) {
                    if (index < reviews.length) {
                      final r = reviews[index];
                      return CourceReviewCardWidget(
                        teacherImageUrl: r.studentImage ?? "",
                        username: r.studentName,
                        reviewText: r.comment,
                        rating: r.rating.toDouble(),
                        timeAgo:
                            "${r.createdAt.year}-${r.createdAt.month.toString().padLeft(2, '0')}-${r.createdAt.day.toString().padLeft(2, '0')} "
                            "${(r.createdAt.hour % 12 == 0 ? 12 : r.createdAt.hour % 12).toString().padLeft(2, '0')}:"
                            "${r.createdAt.minute.toString().padLeft(2, '0')} "
                            "${r.createdAt.hour >= 12 ? 'PM' : 'AM'}",
                      );
                    }

                    // Loader أو Retry عند جلب المزيد
                    if (state.loadratingsMoreStatus ==
                        ResponseStatusEnum.loading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 25.h),
                        child: Center(child: AppLoading.circular()),
                      );
                    } else if (state.loadratingsMoreStatus ==
                        ResponseStatusEnum.failure) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error,
                                color: AppColors.iconError,
                                size: 40.sp,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                state.ratingsMoreError ??
                                    "Failed to load more reviews",
                                style: TextStyle(color: AppColors.textRed),
                              ),
                              CustomButton(
                                title: "Retry",
                                onTap: _handleFetchMore,
                                buttonColor: AppColors.buttonPrimary,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.dividerGrey,
                    thickness: 1,
                    height: 16.h,
                  ),
                );
              },
            ),
          ),

          // مربع كتابة المراجعة كما هو
          if (widget.isActive)
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                color: AppColors.backgroundPage,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What About Your Opinion ?",
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Write a Review And Let Us Know How Are You Feeling About This Course !",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  BlocConsumer<CourseCubit, CourseState>(
                    listenWhen: (previous, current) =>
                        previous.addRatingStatus != current.addRatingStatus &&
                        (current.addRatingStatus ==
                                ResponseStatusEnum.success ||
                            current.addRatingStatus ==
                                ResponseStatusEnum.failure),
                    listener: (context, state) {
                      if (state.addRatingStatus == ResponseStatusEnum.success) {
                        AppMessage.showFlushbar(
                          context: context,
                          title: "Success",
                          message: "Review added successfully ✅",
                          backgroundColor: AppColors.messageSuccess,
                          iconData: Icons.check_circle_outline,
                          iconColor: AppColors.iconWhite,
                        );
                      } else if (state.addRatingStatus ==
                          ResponseStatusEnum.failure) {
                        AppMessage.showFlushbar(
                          context: context,
                          title: "Message",
                          isShowProgress: true,
                          message:
                              state.addRatingError ?? "Failed to add review ❌",
                          backgroundColor: AppColors.messageError,
                          iconData: Icons.error_outline,
                          iconColor: AppColors.iconWhite,
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        previous.addRatingStatus != current.addRatingStatus,
                    builder: (context, state) {
                      final isLoading =
                          state.addRatingStatus == ResponseStatusEnum.loading;
                      return CustomButton(
                        title: isLoading ? "Sending..." : "Write Review",
                        buttonColor: AppColors.buttonPrimary,
                        onTap: isLoading
                            ? null
                            : () {
                                int selectedRating = 3;
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: ReviewBottomSheetWidget(
                                        reviewController: reviewController,
                                        onRatingChanged: (value) {
                                          selectedRating = value;
                                        },
                                      ),
                                    );
                                  },
                                ).then((result) {
                                  if (result != null) {
                                    final reviewText =
                                        result['review'] as String;
                                    final rating = result['rating'] as int;

                                    log(
                                      'Sending rating=$rating, review="$reviewText"',
                                    );
                                    context.read<CourseCubit>().addRating(
                                      rating: rating,
                                      courseId: "${widget.courseId}",
                                      comment: reviewText,
                                    );

                                    reviewController.clear();
                                  }
                                });
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
