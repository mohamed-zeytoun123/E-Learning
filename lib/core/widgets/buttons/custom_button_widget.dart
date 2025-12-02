import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatefulWidget {
  final String title;
  final TextStyle titleStyle;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final Widget? icon;
  final double iconSpacing;

  const CustomButtonWidget({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.buttonColor,
    required this.borderColor,
    this.onTap,
    this.icon,
    this.iconSpacing = 8.0,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          width: 361.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: widget.borderColor),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title, style: widget.titleStyle),
              if (widget.icon != null) ...[
                SizedBox(width: widget.iconSpacing.w),
                widget.icon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
