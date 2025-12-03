import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/Video/presentation/widgets/bubble_arrow_painter_widget.dart';
import 'package:e_learning/core/utils/time_formatter.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentBubbleWidget extends StatelessWidget {
  final String comment;
  final String time; // This will now be a relative time string
  final String authorName;
  final bool isMine;

  const CommentBubbleWidget({
    super.key,
    required this.comment,
    required this.authorName,
    required this.time,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMine ? AppColors.primary : AppColors.secondary;
    final textColor = isMine ? AppColors.textWhite : AppColors.textPrimary;

    return Row(
      mainAxisAlignment: isMine
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isMine
          ? _buildBubble(bubbleColor, textColor, Alignment.bottomLeft)
          : _buildBubble(bubbleColor, textColor, Alignment.bottomRight),
    );
  }

  List<Widget> _buildBubble(
    Color bubbleColor,
    Color textColor,
    Alignment arrowAlignment,
  ) {
    final bubble = Container(
      constraints: BoxConstraints(maxWidth: 250.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment,
            style: TextStyle(color: textColor, fontSize: 13.sp),
          ),
          SizedBox(height: 3.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  authorName,
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 9.sp,
                  ),
                ),
                Text(
                  time, // This is now a relative time string
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 9.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final arrow = SizedBox(
      width: 7.w,
      child: Align(
        alignment: arrowAlignment,
        child: CustomPaint(
          size: Size(7, 20),
          painter: BubbleArrowPainterWidget(
            isMine: arrowAlignment == Alignment.bottomLeft,
            color: bubbleColor,
          ),
        ),
      ),
    );

    return arrowAlignment == Alignment.bottomLeft
        ? [arrow, SizedBox(width: 3.w), bubble]
        : [bubble, SizedBox(width: 3.w), arrow];
  }
}