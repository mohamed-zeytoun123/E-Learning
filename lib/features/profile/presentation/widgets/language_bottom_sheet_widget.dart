import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';

import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_radio_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLanguageNotifier = ValueNotifier<AppLanguageEnum>(
      context.read<AppManagerCubit>().state.appLocale.languageCode == 'ar'
          ? AppLanguageEnum.arabic
          : AppLanguageEnum.english,
    );
    return ModalSheetCustomContainerWidget(
      height: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'language'.tr(),
            style: AppTextStyles.s16w600
                .copyWith(color: context.colors.textPrimary),
          ),
          24.sizedH,
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
                  24.sizedH,
                  CustomButton(
                    title: "apply".tr(),
                    buttonColor: context.colors.textBlue,
                    onTap: () {
                      if (selectedLanguageNotifier.value ==
                          AppLanguageEnum.arabic) {
                        context.read<AppManagerCubit>().toArabic();
                      } else {
                        context.read<AppManagerCubit>().toEnglish();
                      }
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
