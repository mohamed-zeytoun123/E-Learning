import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/home/presentation/widgets/course_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeatcherPage extends StatelessWidget {
  const TeatcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("teachers".tr()),
      ),
      body: Padding(
        padding: AppPadding.appPadding.copyWith(top: 56),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Full Name",
                    style: AppTextStyles.s18w600,
                  ),
                  SizedBox(height: 12),
                  Text(
                    '''
Bio About Teacher’s Experience And Specialization or Subjects Bio About Teacher’s Experience . 
''',
                    style: AppTextStyles.s14w400
                        .copyWith(color: AppColors.textGrey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '12',
                            style: AppTextStyles.s16w600
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          Text(
                            'courses'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: AppColors.textGrey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '30',
                            style: AppTextStyles.s16w600
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                          Text(
                            'students'.tr(),
                            style: AppTextStyles.s14w400
                                .copyWith(color: AppColors.textGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 64),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'courses'.tr(),
                      style: AppTextStyles.s18w600.copyWith(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return FittedBox(child: CourseCard());
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            )
          ],
        ),
      ),
    );
  }
}
