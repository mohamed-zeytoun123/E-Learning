import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_bottom_sheet.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseEnrollWidget extends StatelessWidget {
  const CourseEnrollWidget({
    super.key,
    required this.courseId,
    required this.price,
  });
  final int courseId;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 20.h, thickness: 1, color: AppColors.dividerGrey),
        Text(
          "Enroll Now !",
          style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          textAlign: TextAlign.center,
        ),
        Text(
          "Unlock Full Course For $price S.P",
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        BlocConsumer<CourseCubit, CourseState>(
          listenWhen: (previous, current) =>
              previous.enrollStatusB != current.enrollStatusB,
          listener: (context, state) async {
            if (state.enrollStatusB == ResponseStatusEnum.success) {
              // عرض فلاش رسالة نجاح
              AppMessage.showFlushbar(
                context: context,
                title: "Success",
                message: "Enrolled successfully!",
                backgroundColor: Colors.green,
                isShowProgress: true,
                iconData: Icons.check_circle_outline,
                iconColor: AppColors.iconWhite,
              );

              final cubit = context.read<CourseCubit>();
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white, // خلفية طبيعية للبوتوم شيت
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
                enableDrag: true, // تقدر تسحب البوتوم شيت لأسفل لإغلاقه
                builder: (bottomSheetContext) {
                  return BlocProvider.value(
                    value: cubit,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(
                          bottomSheetContext,
                        ).viewInsets.bottom,
                      ),
                      child: CourseEnrollBottomSheet(), // المحتوى اللي عندك
                    ),
                  );
                },
              );
            } else if (state.enrollStatusB == ResponseStatusEnum.failure) {
              AppMessage.showFlushbar(
                context: context,
                title: "Warning",
                duration: Duration(seconds: 3),
                mainButtonText: "OK",
                isShowProgress: true,
                mainButtonOnPressed: () => context.pop(),
                message: state.enrollError ?? "Failed to enroll",
                backgroundColor: AppColors.messageWarning,
                iconData: Icons.error_outline,
                iconColor: AppColors.iconCircle,
              );

              final cubit = context.read<CourseCubit>();

              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white, // خلفية طبيعية للبوتوم شيت
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true, // إذا محتاج ارتفاع متغير حسب المحتوى
                enableDrag: true, // تقدر تسحب البوتوم شيت لأسفل لإغلاقه
                builder: (bottomSheetContext) {
                  return BlocProvider.value(
                    value: cubit,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(
                          bottomSheetContext,
                        ).viewInsets.bottom,
                      ),
                      child: CourseEnrollBottomSheet(), // المحتوى اللي عندك
                    ),
                  );
                },
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.enrollStatusB != current.enrollStatusB,
          builder: (context, state) {
            final isLoading = state.enrollStatusB == ResponseStatusEnum.loading;

            if (isLoading) {
              return Center(child: AppLoading.circular(size: 30));
            } else {
              return CustomButtonWidget(
                title: "Enroll Now",
                buttonColor: AppColors.buttonPrimary,
                borderColor: AppColors.borderPrimary,
                icon: Icon(
                  Icons.arrow_outward_sharp,
                  color: AppColors.iconWhite,
                ),
                titleStyle: AppTextStyles.s16w500.copyWith(
                  color: AppColors.titlePrimary,
                ),
                onTap: () {
                  context.read<CourseCubit>().enrollCourse(courseId: courseId);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
