import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/enroll/presentation/widgets/contact_us_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SuspendedSectionWidget extends StatelessWidget {
  const SuspendedSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Contact_Us_To_Activate_Your_Course".tr(),
          style: AppTextStyles.s14w400.copyWith(color: context.colors.textGrey),
        ),
        CustomButton(
          title: "Contact_Us".tr(),
          buttonColor: context.colors.textBlue,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ContactUsBottomSheetWidget(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
