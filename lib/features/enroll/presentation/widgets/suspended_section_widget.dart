import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/contact_us_bottom_sheet_widget.dart';
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
          AppLocalizations.of(
                context,
              )?.translate('Contact_Us_To_Activate_Your_Course') ??
              'Contact Us To Activate Your Course',
          style: AppTextStyles.s14w400.copyWith(color: context.colors.textGrey),
        ),
        CustomButtonWidget(
          title:
              AppLocalizations.of(context)?.translate('Contact_Us') ??
              'Contact Us',
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.textWhite,
          ),
          buttonColor: context.colors.textBlue,
          borderColor: context.colors.textBlue,
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
