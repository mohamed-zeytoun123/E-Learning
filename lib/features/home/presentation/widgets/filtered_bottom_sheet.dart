import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/home/presentation/widgets/filter_wrap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  final colors =context.colors;
  showModalBottomSheet(
    backgroundColor:colors.background ,
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'filters'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildFilterSection('category'.tr(), [
                      'all_category'.tr(),
                      'programming'.tr(),
                      'design'.tr(),
                      'business'.tr()
                    ]),
                    SizedBox(height: 16),
                    _buildFilterSection('level'.tr(), [
                      'beginner'.tr(),
                      'intermediate'.tr(),
                      'advanced'.tr()
                    ]),
                    SizedBox(height: 16),
                    // Add more sections here
                  ],
                ),
              ),
            ),

            // Fixed buttons
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.dividerGrey),
                  ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('reset'.tr()),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: colors.textBlue,
                  ),
                  
                    onPressed: () => Navigator.pop(context),
                    child: Text('apply'.tr(), style: TextStyle(
                      color: colors.background,
                    ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildFilterSection(String title, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 8),
      FilterWrap(
        labels: options,
        onSelected: (index, label) {
          print('Selected $title: $label');
        },
      ),
    ],
  );
}
