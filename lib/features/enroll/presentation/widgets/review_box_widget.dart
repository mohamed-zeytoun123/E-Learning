import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewBoxWidget extends StatelessWidget {
  final String reviewText;
  const ReviewBoxWidget({super.key, required this.reviewText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311.w,
      // height: 105.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                /*reviewText */ 'The Written Review From The User, About The Course And The Instructor',
                style: AppTextStyles.s14w400.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* Rating Container
                  Container(
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    // TODO: Pass real review value here
                    child: RatingWidget(
                      showIcon: false,
                      rating: 3,
                      iconColor: AppColors.iconWhite,
                      textColor: AppColors.textWhite,
                    ),
                  ),
                  // TODO: Pass real elapsed time here
                  Text(
                    '2 Weeks Ago',
                    style: AppTextStyles.s12w400.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
