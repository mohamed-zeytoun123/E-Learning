import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
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
          "contact_us_to_activate_course".tr(),
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
        ),
        CustomButtonWidget(
          title: "contact_us".tr(),
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.textWhite,
          ),
          buttonColor: Theme.of(context).colorScheme.primary,
          borderColor: Theme.of(context).colorScheme.primary,
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
