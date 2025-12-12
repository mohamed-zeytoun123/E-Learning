import 'package:e_learning/core/model/enums/app_language_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_radio_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext ctx) {
    // Get current locale from EasyLocalization (actual current locale)
    final currentLocale = ctx.locale;
    final selectedLanguageNotifier = ValueNotifier<AppLanguageEnum>(
      currentLocale.languageCode == 'ar'
          ? AppLanguageEnum.arabic
          : AppLanguageEnum.english,
    );
    return ModalSheetCustomContainerWidget(
      height: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('language'.tr(), style: AppTextStyles.s16w600),
          SizedBox(height: 24.h),
          ValueListenableBuilder<AppLanguageEnum>(
            valueListenable: selectedLanguageNotifier,
            builder: (context, selectedLanguage, child) {
              return Column(
                children: [
                  CustomRadioWidget<AppLanguageEnum>(
                    title: "english".tr(),
                    value: AppLanguageEnum.english,
                    groupValue: selectedLanguage,
                    onChanged: (AppLanguageEnum? value) {
                      if (value != null) {
                        selectedLanguageNotifier.value = value;
                      }
                    },
                  ),
                  CustomRadioWidget<AppLanguageEnum>(
                    title: "arabic".tr(),
                    value: AppLanguageEnum.arabic,
                    groupValue: selectedLanguage,
                    onChanged: (AppLanguageEnum? value) {
                      if (value != null) {
                        selectedLanguageNotifier.value = value;
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomButtonWidget(
                    title: "apply".tr(),
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: context.colors.textWhite,
                    ),
                    buttonColor: context.colors.textBlue,
                    borderColor: context.colors.textBlue,
                    onTap: () {
                      final newLocale = selectedLanguageNotifier.value ==
                              AppLanguageEnum.arabic
                          ? const Locale('ar')
                          : const Locale('en');

                      // Update locale - EasyLocalization handles saving automatically (saveLocale: true)
                      ctx.setLocale(newLocale);

                      // Pop after locale is set
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
