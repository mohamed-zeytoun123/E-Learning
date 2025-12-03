import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_comment_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Video/presentation/widgets/comment_bubble_widget.dart';
import 'package:e_learning/features/Video/presentation/widgets/reply_bubble_widget.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/time_formatter.dart';
import 'package:flutter/services.dart';

class _KeyboardVisibilityObserver extends WidgetsBindingObserver {
  final _BottomSheetCommentsWidgetState _state;

  _KeyboardVisibilityObserver(this._state);

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0;

    if (_state._isKeyboardVisible != newValue && _state.mounted) {
      _state.setState(() {
        _state._isKeyboardVisible = newValue;
      });
    }
  }
}

class BottomSheetCommentsWidget extends StatefulWidget {
  const BottomSheetCommentsWidget({
    super.key,
    required this.videoId,
    this.onClose,
  });
  final int videoId;
  final VoidCallback? onClose;
  @override
  State<BottomSheetCommentsWidget> createState() =>
      _BottomSheetCommentsWidgetState();
}

class _BottomSheetCommentsWidgetState extends State<BottomSheetCommentsWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  int page = 1;
  bool _isExpanded = false;
  int? _replyingToCommentId;
  final Map<int, TextEditingController> _replyControllers = {};
  final Map<int, FocusNode> _replyFocusNodes = {};
  bool _isKeyboardVisible = false;
  late _KeyboardVisibilityObserver _keyboardObserver;

  void _handleFetchMore() {
    final cubit = context.read<ChapterCubit>();
    final state = cubit.state;

    if (state.commentsMoreStatus == ResponseStatusEnum.loading) return;
    if ((state.comments?.comments?.isEmpty ?? true)) return;
    if (state.comments?.hasNextPage == false) return;

    if (page <= 0) {
      return;
    }

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

    _keyboardObserver = _KeyboardVisibilityObserver(this);
    WidgetsBinding.instance.addObserver(_keyboardObserver);

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
    WidgetsBinding.instance.removeObserver(_keyboardObserver);
    _scrollController.dispose();
    _commentController.dispose();

    for (var controller in _replyControllers.values) {
      controller.dispose();
    }

    // Dispose focus nodes
    for (var focusNode in _replyFocusNodes.values) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < -5 && !_isExpanded) {
                  setState(() {
                    _isExpanded = true;
                  });
                } else if (details.delta.dy > 5 &&
                    _isExpanded &&
                    _scrollController.hasClients &&
                    _scrollController.position.pixels <= 0) {
                  setState(() {
                    _isExpanded = false;
                  });
                }
              },
              onDoubleTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Center(
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: _isExpanded
                  ? MediaQuery.of(context).size.height * 0.7
                  : (_isKeyboardVisible
                        ? MediaQuery.of(context).size.height * 0.5
                        : 350.h),
              child: BlocBuilder<ChapterCubit, ChapterState>(
                buildWhen: (prev, curr) =>
                    prev.comments != curr.comments ||
                    prev.commentsMoreStatus != curr.commentsMoreStatus ||
                    prev.commentsStatus != curr.commentsStatus,
                builder: (context, state) {
                  final comments = state.comments?.comments;

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
                  } else if (comments!.isEmpty) {
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
                        return _buildCommentWithReplies(comment, depth: 0);
                      } else {
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
                      previous.commentStatus != current.commentStatus ||
                      previous.addCommentStatus != current.addCommentStatus,
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
                      AppMessage.showFlushbar(
                        context: context,
                        message: "Comment sent successfully",
                        iconData: Icons.check_circle_outline,
                        backgroundColor: AppColors.messageSuccess,
                        isShowProgress: true,
                        title: "Success",
                        iconColor: AppColors.iconWhite,
                      );

                      Future.delayed(const Duration(seconds: 1), () {
                        if (widget.onClose != null) {
                          widget.onClose!();
                        } else if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      });

                      _commentController.clear();

                      // Don't fetch comments again, just add the new comment to the list locally
                      // setState(() {
                      //   page = 1;
                      // });
                    }

                    if (state.addCommentStatus == ResponseStatusEnum.failure) {
                      AppMessage.showFlushbar(
                        context: context,
                        message:
                            state.addCommentError ?? "Failed to send reply",
                        iconData: Icons.error_outline,
                        isShowProgress: true,
                        title: "Error",
                        backgroundColor: AppColors.messageError,
                        iconColor: AppColors.iconWhite,
                      );
                    } else if (state.addCommentStatus ==
                        ResponseStatusEnum.success) {
                      AppMessage.showFlushbar(
                        context: context,
                        message: "Reply sent successfully",
                        iconData: Icons.check_circle_outline,
                        backgroundColor: AppColors.messageSuccess,
                        isShowProgress: true,
                        title: "Success",
                        iconColor: AppColors.iconWhite,
                      );

                      for (var controller in _replyControllers.values) {
                        controller.clear();
                      }
                      setState(() {
                        _replyingToCommentId = null;
                        // Don't reset page or fetch comments again
                        // page = 1;
                      });

                      // Don't fetch all comments again after replying
                      // context.read<ChapterCubit>().getComments(
                      //   videoId: widget.videoId,
                      //   reset: true,
                      //   page: 1,
                      // );
                    }
                  },
                  builder: (context, state) {
                    // Check if we're specifically loading for adding a comment (not fetching comments)
                    final isAddingComment =
                        state.commentStatus == ResponseStatusEnum.loading;
                    return Column(
                      children: [
                        SizedBox(height: 10.h),
                        isAddingComment
                            ? Center(
                                child: SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: AppLoading.circular(),
                                ),
                              )
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

  Widget _buildCommentWithReplies(
    CommentModel comment, {
    int depth = 0,
    Color? parentColor,
  }) {
    final createdAt = DateTime.tryParse(comment.createdAt);

    final isMaxDepth = depth >= 3;

    final baseColor =
        parentColor ??
        (comment.authorType == "Student"
            ? AppColors.primary
            : AppColors.secondary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (depth > 0) SizedBox(width: (depth * 20.0).w),
            Expanded(
              child: depth == 0
                  ? CommentBubbleWidget(
                      comment: comment.content,
                      time: createdAt != null
                          ? TimeFormatter.formatRelativeTime(createdAt)
                          : "just now",
                      isMine: comment.authorType == "Student",
                      authorName: comment.authorName,
                    )
                  : ReplyBubbleWidget(
                      comment: comment.content,
                      time: createdAt != null
                          ? TimeFormatter.formatRelativeTime(createdAt)
                          : "just now",
                      isMine: comment.authorType == "Student",
                      authorName: comment.authorName,
                      parentColor: baseColor,
                    ),
            ),

            if (!isMaxDepth)
              IconButton(
                onPressed: () {
                  _toggleReplyInput(comment.id);
                },
                icon: Icon(Icons.reply, size: 16.sp, color: AppColors.iconGrey),
              ),
          ],
        ),

        if (comment.replies.isNotEmpty) ...[
          SizedBox(height: 5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...comment.replies.map((reply) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: _buildCommentWithReplies(
                    reply,
                    depth: depth + 1,
                    parentColor: baseColor,
                  ),
                );
              }).toList(),
            ],
          ),
        ],

        if (_replyingToCommentId == comment.id)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeOutQuart,
            switchOutCurve: Curves.easeInQuart,
            child: Padding(
              key: ValueKey<int>(comment.id),
              padding: EdgeInsets.only(top: 6.h, left: (depth * 20.0).w),
              child: Row(
                children: [
                  Expanded(
                    child: InputCommentWidget(
                      controller:
                          _replyControllers[comment.id] ??
                          TextEditingController(),
                      hint: "Write a reply...",
                      autofocus: false,
                      focusNode: _replyFocusNodes[comment.id], // Pass the focus node
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _sendReply(comment.id);
                    },
                    icon: Icon(
                      Icons.send,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _toggleReplyInput(int commentId) {
    setState(() {
      if (_replyingToCommentId == commentId) {
        _replyingToCommentId = null;
        _replyControllers.remove(commentId);
        // Remove focus node when not needed
        final focusNode = _replyFocusNodes.remove(commentId);
        focusNode?.dispose();
      } else {
        _replyingToCommentId = commentId;
        _replyControllers.putIfAbsent(commentId, () => TextEditingController());
        // Create focus node for this reply input
        _replyFocusNodes.putIfAbsent(commentId, () => FocusNode());
      }
    });

    // Focus the input field when showing it
    if (_replyingToCommentId == commentId) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          final focusNode = _replyFocusNodes[commentId];
          if (focusNode != null) {
            FocusScope.of(context).requestFocus(focusNode);
          }
        }
      });
    }
  }

  void _sendReply(int parentCommentId) {
    final replyController = _replyControllers[parentCommentId];
    if (replyController != null) {
      final replyContent = replyController.text.trim();
      if (replyContent.isNotEmpty) {
        context.read<ChapterCubit>().replyToComment(
          commentId: parentCommentId,
          content: replyContent,
        );
      } else {}
    } else {}
  }
}
