import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactIconWidget extends StatefulWidget {
  final String iconPath;
  final String nameApp;
  final VoidCallback onTap;

  const ContactIconWidget({
    super.key,
    required this.iconPath,
    required this.nameApp,
    required this.onTap,
  });

  @override
  State<ContactIconWidget> createState() => _ContactIconWidgetState();
}

class _ContactIconWidgetState extends State<ContactIconWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9; // تصغير الأيقونة عند الضغط
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // إعادة الأيقونة لحجمها الطبيعي
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // إعادة الأيقونة إذا تم إلغاء الضغط
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCachedImageWidget(
              appImage: widget.iconPath,
              height: 48,
              width: 48,
            ),
            SizedBox(height: 10.h),
            Text(
              widget.nameApp,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textBlack),
            ),
          ],
        ),
      ),
    );
  }
}
