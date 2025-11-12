import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class FilterGroupWidget extends StatelessWidget {
  final String title;
  final List<FilterItem> items;
  final int? selectedId;
  final void Function(int?) onSelect;

  const FilterGroupWidget({
    super.key,
    required this.title,
    required this.items,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: items.map((item) {
              final selected = item.id == selectedId;

              return GestureDetector(
                onTap: () => onSelect(selected ? null : item.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.buttonTapSelected
                        : AppColors.buttonTapNotSelected,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        opacity: selected ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.check,
                          size: 18.sp,
                          color: AppColors.textWhite,
                        ),
                      ),
                      if (selected) SizedBox(width: 6.w),
                      Text(
                        item.name,
                        style: AppTextStyles.s14w500.copyWith(
                          color: selected
                              ? AppColors.textWhite
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class FilterItem {
  final int id;
  final String name;

  FilterItem({required this.id, required this.name});
}
