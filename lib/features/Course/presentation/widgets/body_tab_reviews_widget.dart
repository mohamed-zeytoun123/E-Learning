import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/cource_review_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabReviewsWidget extends StatefulWidget {
  const BodyTabReviewsWidget({super.key});

  @override
  State<BodyTabReviewsWidget> createState() => _BodyTabReviewsWidgetState();
}

class _BodyTabReviewsWidgetState extends State<BodyTabReviewsWidget> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 130.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    "Ratings & Reviews",
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CourceReviewCardWidget(
                        teacherImageUrl: "https://picsum.photos/361/180",
                        username: "John Doe",
                        reviewText:
                            "The Written Review From The User, About The Course And The Instructor",
                        rating: 4.5,
                        timeAgo: "2 Weeks Ago",
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.dividerGrey,
                      thickness: 1,
                      height: 16.h,
                    ),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                color: AppColors.backgroundPage,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                spacing: 7.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What About Your Opinion ?",
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                  Text(
                    "Write a Review And Let Us Know How Are You Feeling About This Course !",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  CustomButtonWidget(
                    title: "Write Review",
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textWhite,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                    icon: Icon(
                      Icons.arrow_outward_outlined,
                      color: AppColors.iconWhite,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: ReviewBottomSheetWidget(
                                reviewController: reviewController,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
