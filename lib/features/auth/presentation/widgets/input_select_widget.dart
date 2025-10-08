import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputSelectWidget extends StatefulWidget {
  final String hint;
  final String hintKey;
  final List<String> options;

  const InputSelectWidget({
    super.key,
    required this.hint,
    required this.hintKey,
    required this.options,
  });

  @override
  State<InputSelectWidget> createState() => _InputSelectWidgetState();
}

class _InputSelectWidgetState extends State<InputSelectWidget> {
  String? selectedValue;
  bool isSelected = false;

  void _showBottomSheet({required String title}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        String? tempSelected = selectedValue;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60.w,
                    height: 5.h,
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5.r),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        title,
                        style: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                  ),
                  ...widget.options.map((option) {
                    return RadioListTile<String>(
                      title: Text(
                        option,
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                      value: option,
                      groupValue: tempSelected,
                      activeColor: AppColors.borderPrimary,
                      fillColor: MaterialStateProperty.resolveWith<Color?>((
                        states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return AppColors.borderPrimary;
                        }
                        return Colors.grey;
                      }),
                      onChanged: (value) {
                        setModalState(() {
                          tempSelected = value;
                        });
                      },
                    );
                  }).toList(),

                  SizedBox(height: 10.h),

                  CustomButton(
                    onTap: () {
                      setState(() {
                        selectedValue = tempSelected;
                        isSelected = true;
                      });
                      Navigator.pop(context);
                    },
                    title:
                        AppLocalizations.of(context)?.translate("Done") ??
                        "Done",
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      fontFamily: AppTextStyles.fontGeist,
                      color: AppColors.titlePrimary,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(title: widget.hint),
      child: Container(
        width: 361.w,
        height: 49.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.borderPrimary
                : AppColors.borderSecondary,
            width: 1.5,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          selectedValue ?? widget.hint,
          style: AppTextStyles.s14w400.copyWith(
            color: isSelected ? AppColors.textBlack : AppColors.textGrey,
          ),
        ),
      ),
    );
  }
}
