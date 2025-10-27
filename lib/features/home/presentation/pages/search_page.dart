import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/home/presentation/pages/custom_search_appbar.dart';
import 'package:e_learning/features/home/presentation/widgets/filter_wrap.dart';
import 'package:e_learning/features/home/presentation/widgets/filtered_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomSearchAppbar(),
      body: Padding(
        padding: AppPadding.appPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 36,
              ),
              Text(
                'recent_search'.tr(),
                style:
                    AppTextStyles.s18w600.copyWith(color: AppColors.blackText),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SvgPicture.asset(Assets.resourceImagesVectorsSearchAd),
                        SizedBox(
                          width: 12,
                        ),
                        Text('last search', style: AppTextStyles.s14w400),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              showFilterBottomSheet(context);
                              // showModalBottomSheet(
                              //   showDragHandle: true,
                              //   backgroundColor: Colors.white,
                              //   context: context,
                              //   builder: (context) => Container(
                              //     height: 600,
                              //     width: double.infinity,
                              //     padding: EdgeInsets.all(20),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           'filter'.tr(),
                              //           style: AppTextStyles.s18w600.copyWith(
                              //             color: AppColors.primaryTextColor,
                              //           ),
                              //         ),
                              //         SizedBox(height: 40),
                              //         Text(
                              //           'university',
                              //           style: AppTextStyles.s16w400.copyWith(
                              //             color: AppColors.blackText,
                              //           ),
                              //         ),
                              //         SizedBox(height: 24),
                              //         Expanded(
                              //           child: FilterWrap(
                              //             labels: [
                              //               'Harvard',
                              //               'MIT',
                              //               'Stanford',
                              //               'Oxford',
                              //               'Cambridge',
                              //               'Yale',
                              //               'Princeton',
                              //               'Columbia',
                              //             ],
                              //             onSelected:
                              //                 (selectedIndex, selectedLabel) {
                              //               // You can use these values to filter your courses
                              //               // For example: filterCourses(selectedLabel);
                              //             },
                              //           ),
                              //         ),
                              //         Text(
                              //           'study_year'.tr(),
                              //           style: AppTextStyles.s16w400.copyWith(
                              //             color: AppColors.blackText,
                              //           ),
                              //         ),
                              //         SizedBox(height: 24),
                              //         Expanded(
                              //           child: FilterWrap(
                              //             labels: [
                              //               'Harvard',
                              //               'MIT',
                              //               'Stanford',
                              //               'Oxford',
                              //               'Cambridge',
                              //               'Yale',
                              //               'Princeton',
                              //               'Columbia',
                              //             ],
                              //             onSelected:
                              //                 (selectedIndex, selectedLabel) {
                              //               // You can use these values to filter your courses
                              //               // For example: filterCourses(selectedLabel);
                              //             },
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // );
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.blackText,
                            ))
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: AppColors.ligthGray,
                      ),
                  itemCount: 5)
            ],
          ),
        ),
      ),
    );
  }
}
