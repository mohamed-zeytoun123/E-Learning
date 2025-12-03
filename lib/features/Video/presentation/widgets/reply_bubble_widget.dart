import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/Video/presentation/widgets/bubble_arrow_painter_widget.dart';
import 'package:e_learning/core/utils/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplyBubbleWidget extends StatelessWidget {
  final String comment;
  final String time;
  final String authorName;
  final bool isMine;
  final Color? parentColor;

  const ReplyBubbleWidget({
    super.key,
    required this.comment,
    required this.authorName,
    required this.time,
    required this.isMine,
    this.parentColor,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor =
        parentColor ?? (isMine ? AppColors.primary : AppColors.secondary);

    final bubbleColor = _getLighterShade(baseColor);
    final textColor = isMine ? AppColors.textWhite : AppColors.textPrimary;

    final lightTextColor = textColor.withOpacity(0.95);
    final lighterTextColor = textColor.withOpacity(0.8);

    return Row(
      mainAxisAlignment: isMine
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isMine
          ? _buildBubble(
              bubbleColor,
              textColor,
              lightTextColor,
              lighterTextColor,
              Alignment.bottomLeft,
            )
          : _buildBubble(
              bubbleColor,
              textColor,
              lightTextColor,
              lighterTextColor,
              Alignment.bottomRight,
            ),
    );
  }

  Color _getLighterShade(Color color) {
    final hsv = HSVColor.fromColor(color);

    final lighterHsv = hsv
        .withValue((hsv.value + 0.2).clamp(0.0, 1.0))
        .withSaturation((hsv.saturation * 0.7).clamp(0.0, 1.0));
    return lighterHsv.toColor();
  }

  List<Widget> _buildBubble(
    Color bubbleColor,
    Color textColor,
    Color lightTextColor,
    Color lighterTextColor,
    Alignment arrowAlignment,
  ) {
    final bubble = Container(
      constraints: BoxConstraints(maxWidth: 200.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment,
            style: TextStyle(color: lightTextColor, fontSize: 12.sp),
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  authorName,
                  style: TextStyle(color: lighterTextColor, fontSize: 8.sp),
                ),
                Text(
                  time,
                  style: TextStyle(color: lighterTextColor, fontSize: 8.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final arrow = SizedBox(
      width: 5.w,
      child: Align(
        alignment: arrowAlignment,
        child: CustomPaint(
          size: Size(5, 15),
          painter: BubbleArrowPainterWidget(
            isMine: arrowAlignment == Alignment.bottomLeft,
            color: bubbleColor,
          ),
        ),
      ),
    );

    return arrowAlignment == Alignment.bottomLeft
        ? [arrow, SizedBox(width: 2.w), bubble]
        : [bubble, SizedBox(width: 2.w), arrow];
  }
}
