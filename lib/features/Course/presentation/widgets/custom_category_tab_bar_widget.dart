import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCategoryTabBarWidget extends StatelessWidget {
  const CustomCategoryTabBarWidget({super.key, this.withFilter = true});

  final bool withFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        final colleges = state.colleges ?? [];
        final labels = colleges.map((college) => college.name).toList();

        // Loading state
        if (state.collegesStatus == ResponseStatusEnum.loading) {
          return Column(
            children: [
              Padding(
                padding: AppPadding.appPadding.copyWith(end: 0),
                child: Skeletonizer(
                  enabled: true,
                  child: ChipsBar(
                    labels: List.generate(5, (index) => 'loading'.tr()),
                    onChipSelected: (value) {},
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
              Expanded(
                child: ListView.separated(
                  padding: AppPadding.appPadding,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: CourseInfoCardWidget(
                        title: 'loading_course_title'.tr(),
                        subtitle: 'loading_college_name'.tr(),
                        rating: 0,
                        price: '0',
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 15.h),
                ),
              ),
            ],
          );
        }

        // Error state
        if (state.collegesStatus == ResponseStatusEnum.failure) {
          print(state.collegesError);
          return const CustomErrorWidget();
        }

        // Main content - just show UI and courses list
        return Column(
          children: [
            Padding(
              padding: AppPadding.appPadding.copyWith(end: 0),
              child: Row(
                children: [
                  // Filter button UI only (no functionality)
                  if (withFilter)
                    IconButton(
                      icon: Icon(
                        Icons.tune,
                        color: AppColors.primaryTextColor,
                      ),
                      onPressed: () {
                        // No functionality - just UI
                      },
                    ),
                  // ChipsBar UI only (no functionality)
                  Expanded(
                    child: labels.isEmpty
                        ? const SizedBox.shrink()
                        : ChipsBar(
                            labels: labels,
                            onChipSelected: (value) {
                              // No functionality - just UI
                            },
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
            // Just show all courses - no filtering
            Expanded(
              child: const FilterWidget(),
            ),
          ],
        );
      },
    );
  }
}
