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
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

// Observer class to track keyboard visibility
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
  bool _isExpanded = false;
  int? _replyingToCommentId;
  final Map<int, TextEditingController> _replyControllers = {};
  bool _isKeyboardVisible = false; // Track keyboard visibility
  late _KeyboardVisibilityObserver _keyboardObserver;

  void _handleFetchMore() {
    final cubit = context.read<ChapterCubit>();
    final state = cubit.state;

    // Check if already loading or if there are no more pages
    if (state.commentsMoreStatus == ResponseStatusEnum.loading) return;
    if ((state.comments?.comments?.isEmpty ?? true)) return;
    if (state.comments?.hasNextPage == false) return;

    final nextPage = page + 1;
    print("Attempting to fetch page $nextPage");

    cubit
        .getComments(videoId: widget.videoId, reset: false, page: nextPage)
        .then((_) {
          // Only increment page counter if the request was successful
          if (cubit.state.commentsMoreStatus != ResponseStatusEnum.failure) {
            page = nextPage;
            print("Successfully fetched page $nextPage, new page counter: $page");
          } else {
            print("Failed to fetch page $nextPage: ${cubit.state.commentsMoreError}");
          }
        });
  }

  @override
  void initState() {
    super.initState();
    
    // Listen for keyboard visibility changes
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
    // Dispose all reply controllers
    for (var controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: SingleChildScrollView(
        // Add reverse padding to accommodate keyboard
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onVerticalDragUpdate: (details) {
                // Detect upward drag to expand
                if (details.delta.dy < -5 && !_isExpanded) {
                  setState(() {
                    _isExpanded = true;
                  });
                }
                // Detect downward drag to collapse (when at top of scroll)
                else if (details.delta.dy > 5 && 
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
            SizedBox(
              // Adjust height based on keyboard visibility
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
                  //     ?.where((comment) => comment.isPublic)
                  //     .toList() ??
                  // [];

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
                      previous.addCommentStatus != current.addCommentStatus, // Added listener for reply status
                  listener: (context, state) {
                    // Handle original comment status
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

                      AppMessage.showFlushbar(
                        context: context,
                        message: "Comment sent successfully",
                        iconData: Icons.check_circle_outline,
                        backgroundColor: AppColors.messageSuccess,
                        isShowProgress: true,
                        title: "Success",
                        iconColor: AppColors.iconWhite,
                      );

                      _commentController.clear();
                    }
                    
                    // Handle reply status
                    if (state.addCommentStatus == ResponseStatusEnum.failure) {
                      AppMessage.showFlushbar(
                        context: context,
                        message: state.addCommentError ?? "Failed to send reply",
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
                      
                      // Clear all reply controllers
                      _replyControllers.values.forEach((controller) => controller.clear());
                      setState(() {
                        _replyingToCommentId = null;
                      });
                      
                      // Refresh comments to show the new reply
                      context.read<ChapterCubit>().getComments(
                        videoId: widget.videoId,
                        reset: true,
                        page: 1,
                      );
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

  Widget _buildCommentWithReplies(CommentModel comment, {int depth = 0}) {
    final createdAt = DateTime.tryParse(comment.createdAt);
    // Limit the depth to prevent UI issues
    final isMaxDepth = depth >= 3;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main comment
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (depth > 0) 
              // Add indentation for replies
              SizedBox(width: (depth * 15.0).w),
            Expanded(
              child: CommentBubbleWidget(
                comment: comment.content,
                time: createdAt != null
                    ? DateFormat(
                        'MMM d, yyyy hh:mm a',
                      ).format(createdAt)
                    : "Just now",
                isMine: comment.authorType == "Student",
                authorName: comment.authorName,
              ),
            ),
            // Always show reply button for teachers' comments and students' own comments
            // Only hide reply button when max depth is reached
            if (!isMaxDepth) 
              IconButton(
                onPressed: () {
                  _toggleReplyInput(comment.id);
                },
                icon: Icon(
                  Icons.reply,
                  size: 16.sp, // Further reduced from 18.sp
                  color: AppColors.iconGrey,
                ),
              ),
          ],
        ),
        // Replies
        if (comment.replies.isNotEmpty) ...[
          SizedBox(height: 3.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...comment.replies.map((reply) {
                return _buildCommentWithReplies(reply, depth: depth + 1);
              }),
            ],
          ),
        ],
        // Reply input field (shown when user taps reply)
        if (_replyingToCommentId == comment.id)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200), // Faster animation
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: Padding(
              key: ValueKey<int>(comment.id), // Key for animation
              padding: EdgeInsets.only(top: 6.h, left: (depth * 15.0).w),
              child: Row(
                children: [
                  Expanded(
                    child: InputCommentWidget(
                      controller: _replyControllers[comment.id] ?? TextEditingController(),
                      hint: "Write a reply...",
                      autofocus: true, // Enable autofocus for immediate keyboard appearance
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _sendReply(comment.id);
                    },
                    icon: Icon(
                      Icons.send,
                      size: 16.sp, // Reduced from 18.sp
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
        // If already replying to this comment, hide the input
        _replyingToCommentId = null;
        // Dispose of the controller if needed
        _replyControllers.remove(commentId);
      } else {
        // Show input for this comment
        _replyingToCommentId = commentId;
        // Initialize controller if not exists
        _replyControllers.putIfAbsent(commentId, () => TextEditingController());
      }
    });
    
    // Request focus after the widget is built
    if (_replyingToCommentId == commentId) {
      // Use a slightly longer delay to ensure the widget is fully rendered
      Future.microtask(() {
        // Find the controller and request focus
        final controller = _replyControllers[commentId];
        if (controller != null) {
          // Move cursor to end of text
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      });
    }
  }

  void _sendReply(int parentCommentId) {
    final replyController = _replyControllers[parentCommentId];
    if (replyController != null) {
      final replyContent = replyController.text.trim();
      if (replyContent.isNotEmpty) {
        print("Sending reply to comment ID: $parentCommentId with content: $replyContent");
        context
            .read<ChapterCubit>()
            .replyToComment(commentId: parentCommentId, content: replyContent);
            // Removed manual refresh since we're now listening for status changes
      } else {
        print("Reply content is empty for comment ID: $parentCommentId");
      }
    } else {
      print("No reply controller found for comment ID: $parentCommentId");
    }
  }
}
