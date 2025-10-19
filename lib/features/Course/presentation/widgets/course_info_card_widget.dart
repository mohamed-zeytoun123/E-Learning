import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/course/presentation/widgets/course_title_subtitle_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String price;
  final VoidCallback? onSave;

  const CourseInfoCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.price,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 297.5.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                child: CustomCachedImageWidget(
                  appImage: imageUrl,
                  width: double.infinity,
                  height: 180.5,
                  fit: BoxFit.cover,
                  placeholder: Container(
                    color: Colors.grey.shade300,
                    child: Center(child: AppLoading.circular()),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onSave,
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderSecondary),
                    ),
                    child: const Icon(
                      Icons.bookmark_border,
                      color: AppColors.iconBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          CourseTitleSubtitle(
            title: 'Flutter Development',
            subtitle: 'Learn to build apps with Flutter',
          ),

          const Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //* Rating Container
                Container(
                  width: 55.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: AppColors.formWhite,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: RatingWidget(rating: rating),
                ),
                //* Price
                PriceTextWidget(price: price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
