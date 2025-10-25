import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedImageWidget extends StatelessWidget {
  final String appImage;
  final double height;
  final double width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomCachedImageWidget({
    super.key,
    required this.appImage,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: appImage,
      height: height == double.infinity ? double.infinity : height.h,
      width: width == double.infinity ? double.infinity : width.w,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            height: height == double.infinity ? double.infinity : height.h,
            width: width == double.infinity ? double.infinity : width.w,
            color: Colors.grey.shade300,
            child: Center(child: AppLoading.circular()),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            height: height == double.infinity ? double.infinity : height.h,
            width: width == double.infinity ? double.infinity : width.w,
            color: Colors.grey.shade300,
            child: Icon(
              Icons.broken_image,
              size: 20.sp,
              color: AppColors.iconError,
            ),
          ),
    );
  }
}
