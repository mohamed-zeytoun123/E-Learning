import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class BottomSheetQualityWidget extends StatefulWidget {
  final String initialQuality; // مثال: "AUTO" أو "854x480"
  final Function(String) onQualitySelected; // ترجع الرابط المختار
  final Map<String, String> qualities; // { "AUTO": "...", "854x480": "...", "1280x720": "..." }

  const BottomSheetQualityWidget({
    super.key,
    required this.onQualitySelected,
    required this.qualities,
    this.initialQuality = "AUTO",
  });

  @override
  State<BottomSheetQualityWidget> createState() =>
      _BottomSheetQualityWidgetState();
}

class _BottomSheetQualityWidgetState extends State<BottomSheetQualityWidget> {

  
  late String _selectedQuality;

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
          /// الخط العلوي
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

          SizedBox(height: 10.h),

          /// قائمة الدقات ديناميكي
          Column(
            children: widget.qualities.keys.map((quality) {
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

          /// زر Apply
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomButtonWidget(
              title: "Apply",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              onTap: () {
                // ترجع الرابط الفعلي المختار
                if (widget.qualities.containsKey(_selectedQuality)) {
                  widget.onQualitySelected(widget.qualities[_selectedQuality]!);
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
