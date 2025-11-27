import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_bottom_sheet.dart';
import 'package:e_learning/features/course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/video_hours_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseInfoSummaryWidget extends StatefulWidget {
  final int videoCount;
  final double hoursCount;
  final String price;
  final int courseId;

  const CourseInfoSummaryWidget({
    super.key,
    required this.videoCount,
    required this.hoursCount,
    required this.price,
    required this.courseId,
  });

  @override
  State<CourseInfoSummaryWidget> createState() =>
      _CourseInfoSummaryWidgetState();
}

class _CourseInfoSummaryWidgetState extends State<CourseInfoSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VideoHoursWidget(
          videoCount: widget.videoCount,
          hoursCount: widget.hoursCount,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Divider(
            color: AppColors.dividerGrey,
            thickness: 1,
            height: 10.h,
          ),
        ),
        Row(
          children: [
            Text(
              "Price",
              style: AppTextStyles.s16w400.copyWith(color: AppColors.textGrey),
            ),
            SizedBox(width: 5.w),
            PriceTextWidget(price: widget.price),
          ],
        ),
        SizedBox(height: 10.h),
        BlocConsumer<CourseCubit, CourseState>(
          listenWhen: (prev, curr) => prev.enrollStatus != curr.enrollStatus,
          listener: (context, state) async {
            if (state.enrollStatus == ResponseStatusEnum.success ||
                state.enrollStatus == ResponseStatusEnum.failure) {
              // 1️⃣ عرض الرسالة المناسبة أولًا
              if (state.enrollStatus == ResponseStatusEnum.success) {
                AppMessage.showFlushbar(
                  context: context,
                  title: "Success",
                  message: "Enrolled successfully!",
                  backgroundColor: AppColors.messageSuccess,
                  isShowProgress: true,
                  iconData: Icons.check_circle_outline,
                  iconColor: AppColors.iconWhite,
                );
              } else {
                AppMessage.showFlushbar(
                  context: context,
                  title: "Warning",
                  message: state.enrollError ?? "Failed to enroll",
                  duration: Duration(seconds: 3),
                  mainButtonText: "OK",
                  mainButtonOnPressed: () => context.pop(),
                  backgroundColor: AppColors.messageWarning,
                  iconData: Icons.error_outline,
                  iconColor: AppColors.iconCircle,
                );
              }

              // 2️⃣ نضيف delay قصير قبل فتح البوتوم شيت
              await Future.delayed(Duration(milliseconds: 300));

              // 3️⃣ فتح البوتوم شيت بعد عرض الرسالة
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
                enableDrag: true,
                builder: (bottomSheetContext) {
                  return BlocProvider.value(
                    value: context.read<CourseCubit>(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(
                          bottomSheetContext,
                        ).viewInsets.bottom,
                      ),
                      child: CourseEnrollBottomSheet(),
                    ),
                  );
                },
              );
            }
          },
          buildWhen: (prev, curr) => prev.enrollStatus != curr.enrollStatus,
          builder: (context, state) {
            if (state.enrollStatus == ResponseStatusEnum.loading) {
              return Center(child: AppLoading.circular(size: 30));
            }
            return CustomButton(
              title: "Enroll Now",
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              // TODO: Add icon support to CustomButton if needed
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              onTap: () => context.read<CourseCubit>().enrollCourse(
                courseId: widget.courseId,
              ),
            );
          },
        ),
      ],
    );
  }
}
