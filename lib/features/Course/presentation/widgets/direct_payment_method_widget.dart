import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectPaymentMethodWidget extends StatefulWidget {
  final String name;
  final String? image;
  final VoidCallback onTap;

  const DirectPaymentMethodWidget({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  State<DirectPaymentMethodWidget> createState() =>
      _DirectPaymentMethodWidgetState();
}

class _DirectPaymentMethodWidgetState extends State<DirectPaymentMethodWidget> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95; // تصغير طفيف عند الضغط
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // إعادة الحجم الطبيعي بعد رفع الإصبع
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // إعادة الحجم إذا تم إلغاء الضغط
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
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 20.h),
          child: Row(
            children: [
              CustomCachedImageWidget(
                appImage: widget.image ?? "",
                height: 48,
                width: 42,
              ),
              SizedBox(width: 4.w),
              Text(
                widget.name,
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
