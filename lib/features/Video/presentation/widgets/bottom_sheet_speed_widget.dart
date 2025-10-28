import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class BottomSheetSpeedWidget extends StatefulWidget {
  final double initialSpeed;
  final Function(double) onSpeedSelected;

  const BottomSheetSpeedWidget({
    super.key,
    required this.onSpeedSelected,
    this.initialSpeed = 1.0,
  });

  @override
  State<BottomSheetSpeedWidget> createState() => _BottomSheetSpeedWidgetState();
}

class _BottomSheetSpeedWidgetState extends State<BottomSheetSpeedWidget> {
  late double _selectedSpeed;

  final List<double> speeds = [2.0, 1.5, 1.25, 1.0];

  @override
  void initState() {
    super.initState();
    _selectedSpeed = widget.initialSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الخط العلوي
          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: AppColors.dividerWhite,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // العنوان + زر الإغلاق
          Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                "Playback Speed",
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // خيارات السرعة (Radio buttons)
          Column(
            spacing: 10.h,
            children: speeds.map((speed) {
              bool isSelected = _selectedSpeed == speed;

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedSpeed = speed;
                  });
                },
                child: Row(
                  spacing: 10.w,
                  children: [
                    // الدائرة
                    Container(
                      width: 20.w, // حجم الدائرة
                      height: 30.h,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Color(0xFFF1F1F1),
                          width: 2.w,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 12.w, // حجم النقطة الداخلية
                                height: 12.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.iconBlue,
                                ),
                              ),
                            )
                          : null,
                    ),
                    Text(
                      "${speed}x",
                      style: AppTextStyles.s14w500.copyWith(
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: CustomButtonWidget(
              title: "Apply",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              onTap: () {
                widget.onSpeedSelected(_selectedSpeed);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
