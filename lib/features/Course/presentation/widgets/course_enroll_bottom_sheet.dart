import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/data/functions/open_link.dart';

import 'package:e_learning/features/Course/presentation/widgets/contact_icon_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/direct_payment_method_widget.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseEnrollBottomSheet extends StatefulWidget {
  const CourseEnrollBottomSheet({super.key, required this.cubit});

  final CourseCubit cubit;
  @override
  State<CourseEnrollBottomSheet> createState() =>
      _CourseEnrollBottomSheetState();
}

class _CourseEnrollBottomSheetState extends State<CourseEnrollBottomSheet> {
  @override
  void initState() {
    context.read<CourseCubit>().getChannels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state.channelsStatus == ResponseStatusEnum.loading) {
          return SizedBox(
            height: 200.h,

            child: Center(child: AppLoading.circular()),
          );
        } else if (state.channelsStatus == ResponseStatusEnum.failure) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Column(
                spacing: 5.h,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.h,
                    color: AppColors.textError,
                  ),
                  Text(
                    state.channelsError ?? "Something went wrong",
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButtonWidget(
                    onTap: () {
                      context.read<CourseCubit>().getChannels();
                    },
                    title: "Retry",
                    titleStyle: AppTextStyles.s14w500.copyWith(
                      color: AppColors.titlePrimary,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                  ),
                ],
              ),
            ),
          );
        } else if ((state.channelsStatus == ResponseStatusEnum.failure &&
                state.channelsError!.contains("No Data")) ||
            state.channels!.isEmpty) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Column(
                spacing: 10.w,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.h,
                    color: AppColors.textError,
                  ),
                  Text(
                    "No Channels Available",
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.channelsStatus == ResponseStatusEnum.success) {
          final channels = state.channels ?? [];

          final communications = channels
              .where((c) => c.isCommunication == true)
              .toList();
          final payments = channels
              .where((c) => c.isCommunication == false)
              .toList();
          return Container(
            height: 450.h,
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 15.h,
              top: 3.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 80.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: AppColors.dividerWhite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  "Get Your Enrollment Code !",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Contact Us To Receive Payment Information & Enroll In This Course",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 5.w),
                      itemCount: communications.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ContactIconWidget(
                          iconPath: communications.elementAt(index).image ?? "",
                          onTap: () {
                            openLink(communications.elementAt(index).apiLink);
                          },

                          nameApp: communications.elementAt(index).name,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.w),
                    ),
                  ),
                ),
                Divider(
                  height: 10.h,
                  thickness: 1,
                  color: AppColors.dividerGrey,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Or Pay Directly Via",
                        style: AppTextStyles.s16w600.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),

                      SizedBox(
                        height: 60.h,
                        child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                          itemCount: payments.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return DirectPaymentMethodWidget(
                              name: payments.elementAt(index).name,
                              image: payments.elementAt(index).image ?? "",
                              onTap: () {
                                openLink(payments.elementAt(index).apiLink);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 15.w),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),

                Center(
                  child: CustomButtonWidget(
                    onTap: () {
                      context.pop();
                    },
                    title: "Cancel",
                    titleStyle: AppTextStyles.s16w400.copyWith(
                      color: AppColors.titlePrimary,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
