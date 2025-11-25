import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetQualityWidget extends StatefulWidget {
  final String initialQuality;
  final Function(String) onQualitySelected;

  const BottomSheetQualityWidget({
    super.key,
    required this.onQualitySelected,
    this.initialQuality = "480P",
  });

  @override
  State<BottomSheetQualityWidget> createState() =>
      _BottomSheetQualityWidgetState();
}

class _BottomSheetQualityWidgetState extends State<BottomSheetQualityWidget> {
  late String _selectedQuality;

  final List<String> qualities = ["480P", "720P"];

  @override
  void initState() {
    super.initState();
    _selectedQuality = widget.initialQuality;
  }

  @override
  void didUpdateWidget(covariant BottomSheetQualityWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialQuality != widget.initialQuality) {
      _selectedQuality = widget.initialQuality;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: AppColors.dividerWhite,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                "Quality",
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          10.sizedH,
          Column(
            children: qualities.map((quality) {
              bool isSelected = _selectedQuality == quality;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedQuality = quality;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 30.w,
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
                                  width: 12.w,
                                  height: 12.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.iconBlue,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Text(
                        quality,
                        style: AppTextStyles.s14w500.copyWith(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomButton(
              title: "Apply",
              buttonColor: AppColors.buttonPrimary,
              onTap: () {
                widget.onQualitySelected(_selectedQuality);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
