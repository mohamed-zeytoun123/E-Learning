import 'dart:developer';

import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_radio_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeBottomSheetWidget extends StatelessWidget {
  const ThemeBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedThemeNotifier = ValueNotifier<ThemeMode>(
      context.read<AppManagerCubit>().state.themeMode,
    );
    return ModalSheetCustomContainerWidget(
      height: 368,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("Themes") ?? "Themes",
            style: AppTextStyles.s16w600,
          ),
          SizedBox(height: 24.h),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: selectedThemeNotifier,
            builder: (context, selectedTheme, child) {
              return RadioGroup(
                groupValue: selectedTheme,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    selectedThemeNotifier.value = value;
                    log('Selected Theme: ${value.toString()}');
                  }
                },
                child: Column(
                  children: [
                    CustomRadioWidget<ThemeMode>(
                      title:
                          AppLocalizations.of(
                            context,
                          )?.translate("System_Default") ??
                          "System Default",
                      value: ThemeMode.system,
                    ),
                    CustomRadioWidget<ThemeMode>(
                      title:
                          AppLocalizations.of(context)?.translate("Light") ??
                          "Light",
                      value: ThemeMode.light,
                    ),
                    CustomRadioWidget<ThemeMode>(
                      title:
                          AppLocalizations.of(context)?.translate("Dark") ??
                          "Dark",
                      value: ThemeMode.dark,
                    ),
                    SizedBox(height: 24.h),
                    CustomButtonWidget(
                      title:
                          AppLocalizations.of(context)?.translate("Apply") ??
                          "Apply",
                      titleStyle: AppTextStyles.s16w500.copyWith(
                        color: AppColors.textWhite,
                      ),
                      buttonColor: Theme.of(context).colorScheme.primary,
                      borderColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        context.read<AppManagerCubit>().setThemeMode(
                          selectedThemeNotifier.value,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
