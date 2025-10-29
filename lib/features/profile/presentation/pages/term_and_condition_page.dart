
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.colors.background,
      appBar: CustomAppBarWidget(title: 'Term & Conditions',showBack: true,),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color:context.colors.appBarWhite ,
        // gradient: LinearGradient(colors: [context.colors.appBarWhite])
      ),
        child: Container(
            padding: EdgeInsets.fromLTRB(24, 1.r, 24, 0),
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              // topRight: Radius.circular(36.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ...List.generate(3, (index) {
                    return privacyPolicySectionWidget(
                      title: ' Type of data collect ',
                      text: '',
                      counter: index+1,
                    );
                  }),
          
                  // privacyPolicySectionWidget(
                  //   title: ' Type of data collect ',
                  //   text: '',
                  //   counter: 1,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class privacyPolicySectionWidget extends StatelessWidget {
  const privacyPolicySectionWidget({
    super.key,
    required this.title,
    required this.text,
    required this.counter,
  });
  final String title;
  final String text;
  final int counter;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$counter. $title',
          style: TextStyle(
            color: context.colors.textBlue,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          lorem(paragraphs: counter, words: 50),
          style: TextStyle(
            color: context.colors.textGrey,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 24.h,)
      ],
    );
  }
}
