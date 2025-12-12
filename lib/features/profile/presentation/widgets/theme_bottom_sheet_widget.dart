import 'dart:developer';

import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_radio_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeBottomSheetWidget extends StatelessWidget {
  const ThemeBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final selectedThemeNotifier = ValueNotifier<ThemeMode>(
      context.read<AppManagerCubit>().state.themeMode,
    );
    return ModalSheetCustomContainerWidget(
      height: 368,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'themes'.tr(),
            style: AppTextStyles.s16w600.copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 24.h),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: selectedThemeNotifier,
            builder: (context, selectedTheme, child) {
              return Column(
                children: [
                  CustomRadioWidget<ThemeMode>(
                    title: 'system_default'.tr(),
                    value: ThemeMode.system,
                    groupValue: selectedTheme,
                    onChanged: (ThemeMode? value) {
                      if (value != null) {
                        selectedThemeNotifier.value = value;
                        log('Selected Theme: ${value.toString()}');
                      }
                    },
                  ),
                  CustomRadioWidget<ThemeMode>(
                    title: 'light'.tr(),
                    value: ThemeMode.light,
                    groupValue: selectedTheme,
                    onChanged: (ThemeMode? value) {
                      if (value != null) {
                        selectedThemeNotifier.value = value;
                        log('Selected Theme: ${value.toString()}');
                      }
                    },
                  ),
                  CustomRadioWidget<ThemeMode>(
                    title: 'dark'.tr(),
                    value: ThemeMode.dark,
                    groupValue: selectedTheme,
                    onChanged: (ThemeMode? value) {
                      if (value != null) {
                        selectedThemeNotifier.value = value;
                        log('Selected Theme: ${value.toString()}');
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomButtonWidget(
                    title: 'apply'.tr(),
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: colors.textWhite,
                    ),
                    buttonColor: colors.textBlue,
                    borderColor: colors.textBlue,
                    onTap: () {
                      context.read<AppManagerCubit>().setThemeMode(
                            selectedThemeNotifier.value,
                          );
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
