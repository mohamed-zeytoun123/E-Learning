import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_comment_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Video/presentation/widgets/comment_bubble_widget.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BottomSheetCommentsWidget extends StatefulWidget {
  const BottomSheetCommentsWidget({super.key, required this.videoId});
  final int videoId;
  @override
  State<BottomSheetCommentsWidget> createState() =>
      _BottomSheetCommentsWidgetState();
}

class _BottomSheetCommentsWidgetState extends State<BottomSheetCommentsWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  int page = 1;

  void _handleFetchMore() {
    final cubit = context.read<ChapterCubit>();
    final state = cubit.state;

    if (state.commentsMoreStatus == ResponseStatusEnum.loading) return;
    if ((state.comments?.comments?.isEmpty ?? true)) return;
    if (state.comments?.hasNextPage == false) return;

    final nextPage = page + 1;

    cubit
        .getComments(videoId: widget.videoId, reset: false, page: nextPage)
        .then((_) {
          if (cubit.state.commentsMoreStatus != ResponseStatusEnum.failure) {
            page = nextPage;
          }
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

    context.read<ChapterCubit>().getComments(
      videoId: widget.videoId,
      reset: true,
      page: 1,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
                width: 80.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppColors.dividerWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Text(
              "Comments",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
            Text(
              "Write Your Questions In A Comment & The Teacher Will Respond As Soon As Possible",
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: AppColors.dividerGrey),
            SizedBox(
              height: 350.h,
              child: BlocBuilder<ChapterCubit, ChapterState>(
                buildWhen: (prev, curr) =>
                    prev.comments != curr.comments ||
                    prev.commentsMoreStatus != curr.commentsMoreStatus ||
                    prev.commentsStatus != curr.commentsStatus,
                builder: (context, state) {
                  final comments =
                      state.comments?.comments
                          ?.where((comment) => comment.isPublic)
                          .toList() ??
                      [];

                  if (state.commentsStatus == ResponseStatusEnum.loading &&
                      page == 1) {
                    return Center(child: AppLoading.circular());
                  } else if (state.commentsStatus ==
                          ResponseStatusEnum.failure &&
                      page == 1) {
                    return Center(
                      child: Column(
                        spacing: 10.h,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 64.r,
                            color: AppColors.iconError,
                          ),
                          Text(
                            state.commentsError ?? "",
                            style: AppTextStyles.s16w400.copyWith(
                              color: AppColors.textError,
                            ),
                          ),
                          CustomButtonWidget(
                            title: "Retry",
                            titleStyle: AppTextStyles.s16w400.copyWith(
                              color: AppColors.titlePrimary,
                            ),
                            buttonColor: AppColors.buttonPrimary,
                            borderColor: AppColors.borderPrimary,
                            onTap: () {
                              context.read<ChapterCubit>().getComments(
                                videoId: widget.videoId,
                                reset: true,
                                page: 1,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (comments.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comments_disabled_outlined,
                            size: 64.r,
                            color: AppColors.iconGrey.withOpacity(0.5),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "No comments available for this video.",
                            style: AppTextStyles.s14w400.copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: comments.length + 1,
                    itemBuilder: (context, index) {
                      if (index < comments.length) {
                        final comment = comments[index];
                        return CommentBubbleWidget(
                          comment: comment.content,
                          time: DateFormat(
                            'MMM d, yyyy hh:mm a',
                          ).format(DateTime.parse(comment.createdAt)),
                          isMine: comment.authorType == "Student",
                        );
                      } else {
                        // Loader أو رسالة نهاية التعليقات
                        if (state.commentsMoreStatus ==
                            ResponseStatusEnum.loading) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(child: AppLoading.circular()),
                          );
                        } else if (state.commentsMoreStatus ==
                            ResponseStatusEnum.failure) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.textRed,
                                    size: 40.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    state.commentsMoreError ??
                                        "Failed to load more comments",
                                    style: AppTextStyles.s14w600.copyWith(
                                      color: AppColors.textError,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                          );
                        } else if (state.comments?.hasNextPage == true) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(child: AppLoading.circular()),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  );
                },
              ),
            ),
            Divider(height: 1.h, color: AppColors.dividerGrey),
            SizedBox(height: 10.h),
            Column(
              children: [
                InputCommentWidget(
                  controller: _commentController,
                  hint: "Write Comment",
                ),

                BlocConsumer<ChapterCubit, ChapterState>(
                  listenWhen: (previous, current) =>
                      previous.commentStatus != current.commentStatus,
                  listener: (context, state) {
                    if (state.commentStatus == ResponseStatusEnum.failure) {
                      AppMessage.showFlushbar(
                        context: context,
                        message: state.commentError ?? "Failed to send comment",
                        iconData: Icons.error_outline,
                        isShowProgress: true,
                        title: "Error",
                        backgroundColor: AppColors.messageError,
                        iconColor: AppColors.iconWhite,
                      );
                    } else if (state.commentStatus ==
                        ResponseStatusEnum.success) {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }

                      // بعد الغلق، نعرض رسالة النجاح
                      AppMessage.showFlushbar(
                        context: context,
                        message: "Comment sent successfully",
                        iconData: Icons.check_circle_outline,
                        backgroundColor: AppColors.messageSuccess,
                        isShowProgress: true,
                        title: "Success",
                        iconColor: AppColors.iconWhite,
                      );

                      // ننظف الـ text field
                      _commentController.clear();
                    }
                  },
                  builder: (context, state) {
                    final isLoading =
                        state.commentStatus == ResponseStatusEnum.loading;

                    return Column(
                      children: [
                        SizedBox(height: 10.h),
                        isLoading
                            ? Center(child: AppLoading.circular())
                            : CustomButtonWidget(
                                title: "Send Comment",
                                titleStyle: AppTextStyles.s16w600.copyWith(
                                  color: AppColors.titlePrimary,
                                ),
                                buttonColor: AppColors.buttonPrimary,
                                borderColor: AppColors.borderPrimary,
                                onTap: () {
                                  final comment = _commentController.text
                                      .trim();
                                  if (comment.isNotEmpty) {
                                    context.read<ChapterCubit>().addComment(
                                      videoId: widget.videoId,
                                      content: comment,
                                    );
                                  }
                                },
                              ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
