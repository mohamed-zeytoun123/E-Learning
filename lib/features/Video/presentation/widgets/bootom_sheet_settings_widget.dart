import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_quality_widget.dart';
import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_speed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BootomSheetSettingsWidget extends StatelessWidget {
  final double currentSpeed;
  final Function(double) onSpeedSelected;

  const BootomSheetSettingsWidget({
    super.key,
    required this.currentSpeed,
    required this.onSpeedSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 225.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),
              //* Quality
              ListTile(
                leading: Icon(Icons.tune, color: AppColors.iconBlue),
                title: Text(
                  "Quality",
                  style: AppTextStyles.s14w500.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  log("Open Quality BottomSheet");
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return BottomSheetQualityWidget(
                        onQualitySelected: (String p1) {
                          log("Selected Quality: $p1");
                        },
                      );
                    },
                  );
                },
              ),
              //* Playback Speed
              ListTile(
                leading: Icon(
                  Icons.play_circle_outline,
                  color: AppColors.iconBlue,
                ),
                title: Text(
                  "Playback Speed",
                  style: AppTextStyles.s14w500.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close Settings

                  // Open Speed BottomSheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return BottomSheetSpeedWidget(
                        initialSpeed: currentSpeed, // ✅ آخر قيمة
                        onSpeedSelected:
                            onSpeedSelected, // ✅ تمرير التعديل للصفحة الأساسية
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
