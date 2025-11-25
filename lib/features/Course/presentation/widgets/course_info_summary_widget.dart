import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_bottom_sheet.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_hours_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            5.sizedW,
            PriceTextWidget(price: widget.price),
          ],
        ),
        10.sizedH,
        BlocConsumer<CourseCubit, CourseState>(
          listenWhen: (prev, curr) => prev.enrollStatus != curr.enrollStatus,
          listener: (context, state) async {
            if (state.enrollStatus == ResponseStatusEnum.success ||
                state.enrollStatus == ResponseStatusEnum.failure) {
              // 1️⃣ عرض الرسالة المناسبة أولًا
              if (state.enrollStatus == ResponseStatusEnum.success) {
                AppMessage.showSuccess(context, "Enrolled successfully!");
              } else {
                AppMessage.showWarning(context, state.enrollError ?? "Failed to enroll");
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
                    value: context.read<CourseCubit>(), // استخدام نفس الـ cubit
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
