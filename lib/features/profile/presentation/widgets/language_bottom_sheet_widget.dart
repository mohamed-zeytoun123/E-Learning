import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/model/enums/app_language_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_radio_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Text('Language', style: AppTextStyles.s16w600),
          SizedBox(height: 24.h),
          ValueListenableBuilder<AppLanguageEnum>(
            valueListenable: selectedLanguageNotifier,
            builder: (context, selectedLanguage, child) {
              return Column(
                children: [
                  CustomRadioWidget<AppLanguageEnum>(
                    title: AppLocalizations.of(context)?.translate("English") ??
                        "English",
                    value: AppLanguageEnum.english,
                    groupValue: selectedLanguage,
                    onChanged: (AppLanguageEnum? value) {
                      if (value != null) {
                        selectedLanguageNotifier.value = value;
                      }
                    },
                  ),
                  CustomRadioWidget<AppLanguageEnum>(
                    title: AppLocalizations.of(context)?.translate("Arabic") ??
                        "Arabic",
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
                    title: AppLocalizations.of(context)?.translate("Apply") ??
                        "Apply",
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textWhite,
                    ),
                    buttonColor: Theme.of(context).colorScheme.primary,
                    borderColor: Theme.of(context).colorScheme.primary,
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
