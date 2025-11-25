import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/input_comment_widget.dart';
import 'package:e_learning/features/Video/presentation/widgets/comment_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

class BottomSheetCommentsWidget extends StatelessWidget {
  const BottomSheetCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
                width: 80.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppColors.dividerWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Text(
              "Comments",
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
            Text(
              "Write Your Questions In A Comment & The Teacher Will Respond As Soon As Possible",
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
            ),
            10.sizedH,
            Divider(height: 1.h, color: AppColors.dividerGrey),
            SizedBox(
              height: 350.h,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CommentBubbleWidget(
                    comment:
                        "This is a sample comment to demonstrate the comment bubble widget in the bottom sheet.",
                    time: "2 hours ago",
                    isMine: index % 2 == 0,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return 10.sizedH;
                },
              ),
            ),
            Divider(height: 1.h, color: AppColors.dividerGrey),
            10.sizedH,
            Column(
              spacing: 10.h,
              children: [
                InputCommentWidget(
                  controller: TextEditingController(),
                  hint: "Write Comment",
                ),
                CustomButton(
                  title: "Send Comment",
                  buttonColor: AppColors.buttonPrimary,
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
