import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/Video/presentation/widgets/bubble_arrow_painter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentBubbleWidget extends StatelessWidget {
  final String comment;
  final String time;
  final bool isMine;

  const CommentBubbleWidget({
    super.key,
    required this.comment,
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
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment,
            style: TextStyle(color: textColor, fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );

    final arrow = SizedBox(
      width: 8.w,
      child: Align(
        alignment: arrowAlignment,
        child: CustomPaint(
          size: Size(8, 24),
          painter: BubbleArrowPainterWidget(
            isMine: arrowAlignment == Alignment.bottomLeft,
            color: bubbleColor,
          ),
        ),
      ),
    );

    return arrowAlignment == Alignment.bottomLeft
        ? [arrow, SizedBox(width: 4.w), bubble]
        : [bubble, SizedBox(width: 4.w), arrow];
  }
}
