// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';
// import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
// import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';

// class ReplyCommentWidget extends StatefulWidget {
//   final CommentModel parentComment;
//   final VoidCallback onReplySent;
//   final int videoId; // Add videoId parameter

//   const ReplyCommentWidget({
//     super.key,
//     required this.parentComment,
//     required this.onReplySent,
//     required this.videoId, // Add videoId to constructor
//   });

//   @override
//   State<ReplyCommentWidget> createState() => _ReplyCommentWidgetState();
// }

// class _ReplyCommentWidgetState extends State<ReplyCommentWidget> {
//   final TextEditingController _replyController = TextEditingController();

//   @override
//   void dispose() {
//     _replyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundPage,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Reply to ${widget.parentComment.authorName}",
//                 style: AppTextStyles.s16w600.copyWith(
//                   color: AppColors.textBlack,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(
//                   Icons.close,
//                   size: 24.sp,
//                   color: AppColors.iconGrey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
          
//           // Parent comment preview
//           Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: AppColors.dividerGrey.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Text(
//               widget.parentComment.content,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: AppTextStyles.s14w400.copyWith(
//                 color: AppColors.textGrey,
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
          
//           // Reply input
//           TextField(
//             controller: _replyController,
//             maxLines: 3,
//             minLines: 1,
//             decoration: InputDecoration(
//               hintText: "Write your reply...",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//                 borderSide: BorderSide(color: AppColors.dividerGrey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//                 borderSide: BorderSide(color: AppColors.dividerGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//                 borderSide: BorderSide(color: AppColors.primary),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
          
//           // Send button
//           Align(
//             alignment: Alignment.centerRight,
//             child: ElevatedButton(
//               onPressed: _sendReply,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//               ),
//               child: Text(
//                 "Send Reply",
//                 style: AppTextStyles.s16w600.copyWith(
//                   color: AppColors.textWhite,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendReply() {
//     final replyContent = _replyController.text.trim();
//     if (replyContent.isEmpty) return;

//     context.read<ChapterCubit>().replyToComment(
//       commentId: widget.parentComment.id,
//       content: replyContent,
//       videoId: widget.videoId, // Pass the videoId to ensure comments refresh
//     ).then((_) {
//       // Close the reply sheet and notify parent
//       // Navigator.pop(context);
//       widget.onReplySent();
//     });
//   }
// }