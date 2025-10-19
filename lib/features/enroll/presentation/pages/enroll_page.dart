import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnrollPage extends StatelessWidget {
  const EnrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Enroll', showBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('Your_Enrolls') ??
                    "Your Enrolls",
                style: AppTextStyles.s18w600,
              ),
              SizedBox(height: 24.h),
              ListView.separated(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => EnrollInfoCardWidget(
                  imageUrl:
                      'https://cdn.shopaccino.com/igmguru/products/flutter-igmguru_1527424732_l.jpg?v=532',
                  courseTitle: 'Flutter Development',
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15.h);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
