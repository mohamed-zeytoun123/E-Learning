import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/enroll/data/source/static/contact_methods.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsBottomSheetWidget extends StatelessWidget {
  const ContactUsBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalSheetCustomContainerWidget(
      height: 249.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(
                  context,
                )?.translate("Course_Has_Been_Suspended!") ??
                'Course Has Been Suspended!',
            style: AppTextStyles.s16w600,
          ),
          Text(
            AppLocalizations.of(
                  context,
                )?.translate('Contact_Us_To_Activate_Your_Course') ??
                'Contact Us To Activate Your Course',
            style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(contactMethods.length, (index) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48.r),
                    child: CustomCachedImageWidget(
                      appImage: contactMethods[index]['image']!,
                      height: 48.h,
                      width: 48.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    contactMethods[index]['name']!,
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
