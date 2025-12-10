// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
// import 'package:e_learning/core/widgets/loading/app_loading.dart';
// import 'package:e_learning/features/course/presentation/widgets/course_title_sub_title_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/price_text_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CourseInfoCardWidget extends StatelessWidget {
//   final String? imageUrl;
//   final String title;
//   final String subtitle;
//   final double rating;
//   final String price;
//   final bool isLoading;
//   final VoidCallback? onSave;
//   final VoidCallback? onTap;

//   const CourseInfoCardWidget({
//     super.key,
//     this.imageUrl,
//     required this.title,
//     required this.subtitle,
//     required this.rating,
//     required this.price,
//     this.isLoading = false,
//     this.onTap,
//     this.onSave,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 361.w,
//         height: 297.5.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4.r,
//               offset: Offset(0, 2.h),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //? Image Section
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.r),
//                     topRight: Radius.circular(20.r),
//                   ),
//                   child: isLoading || imageUrl == null
//                       ? AppLoading.skeleton(height: 180.5)
//                       : CustomCachedImageWidget(
//                           appImage: imageUrl!,
//                           width: double.infinity,
//                           height: 180.5,
//                           fit: BoxFit.cover,
//                           placeholder: Container(
//                             color: Colors.grey.shade300,
//                             child: Center(child: AppLoading.circular()),
//                           ),
//                         ),
//                 ),
//                 Positioned(
//                   top: 8.h,
//                   right:14.w,
//                   child: GestureDetector(
//                     onTap: onSave,
//                     child: Container(
//                       width: 44.w,
//                       height: 44.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.borderSecondary),
//                       ),
//                       child: Icon(
//                         Icons.bookmark_border,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 8.h),

//             //? Title & Subtitle
//             isLoading
//                 ? AppLoading.skeleton(height: 40)
//                 : CourseTitleSubTitleWidget(title: title, subtitle: subtitle),

//             const Spacer(),

//             //? Rating & Price
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   isLoading
//                       ? AppLoading.skeleton(width: 55, height: 25)
//                       : Container(
//                           width: 55.w,
//                           height: 25.h,
//                           decoration: BoxDecoration(
//                             color: AppColors.formSomeWhite,
//                             borderRadius: BorderRadius.circular(12.r),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 6.w),
//                           child: RatingWidget(rating: rating),
//                         ),
//                   isLoading
//                       ? AppLoading.skeleton(width: 60, height: 25)
//                       : PriceTextWidget(price: price),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_title_sub_title_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String price;
  final bool isLoading;
  final bool isFavorite;
  final VoidCallback? onSave;
  final VoidCallback? onTap;

  const CourseInfoCardWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.price,
    this.isLoading = false,
    this.onTap,
    this.isFavorite = false,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            //? Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: isLoading || imageUrl == null
                      ? AppLoading.skeleton(height: 180.5)
                      : CustomCachedImageWidget(
                          appImage: imageUrl!,
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
                  right: 14.w,
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
                      child: Icon(
                        isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: isFavorite
                            ? AppColors.iconBlue
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            //? Title & Subtitle
            isLoading
                ? AppLoading.skeleton(height: 40)
                : CourseTitleSubTitleWidget(title: title, subtitle: subtitle),

            const Spacer(),

            //? Rating & Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? AppLoading.skeleton(width: 55, height: 25)
                      : Container(
                          width: 55.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: AppColors.formSomeWhite,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: RatingWidget(rating: rating),
                        ),
                  isLoading
                      ? AppLoading.skeleton(width: 60, height: 25)
                      : PriceTextWidget(price: price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
