import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff1f1f1),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.h),
        color: Color(0xfff1f1f1),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 1.r, 24, 0),
          decoration: BoxDecoration(
            color: Color(0xfffdfdfd),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 160, 159, 159)),
                ),
                SizedBox(height: 18.h),
                Text(
                  'Information we collect',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(lorem(paragraphs: 2, words: 110),
                  // 'Privacy Policy for Deyram At Deyram.com, accessible from makemeup.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Deyram.com and how we use it.\nIf you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.\nThis Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Deyram.com. This policy is not applicable to any information collected offline or via channels other than this website.\nConsent\nBy using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 160, 159, 159)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
            size: 20,
          ),
          onPressed: () {
            // => Navigator.pop(context)
          },
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
            color: const Color.fromARGB(218, 0, 33, 199),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          lorem(paragraphs: counter, words: 50),
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 24.h,)
      ],
    );
  }
}
