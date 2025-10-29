import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.buttonTapNotSelected,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colors.textPrimary,
            size: 20,
          ),
          onPressed: (){

          }
        ),
        title:  Text(
          'Privacy Policy',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.h),
        color: colors.buttonTapNotSelected,
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 1.r, 24, 0),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.r),
              topRight: Radius.circular(36.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  'Privacy Policy for Deyram',
                  style: TextStyle(
                         fontWeight: FontWeight.w600,
            fontSize: 16,
                   ),
                ),
                SizedBox(height: 10),
                Text(lorem(paragraphs: 2, words: 110),
                  // 'Privacy Policy for Deyram At Deyram.com, accessible from makemeup.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Deyram.com and how we use it.\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\nThis Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Deyram.com. This policy is not applicable to any information collected offline or via channels other than this website.\nConsent\nBy using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: colors.textGrey),
                ),
                SizedBox(height: 18.h),
                Text(
                  'Information we collect',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(lorem(paragraphs: 2, words: 110),
                  // 'Privacy Policy for Deyram At Deyram.com, accessible from makemeup.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Deyram.com and how we use it.\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\nThis Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Deyram.com. This policy is not applicable to any information collected offline or via channels other than this website.\nConsent\nBy using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color:  colors.textGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
