import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/home/presentation/widgets/filter_wrap.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: AppColors.background,
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
                  'Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                    _buildFilterSection('Category',
                        ['All', 'Programming', 'Design', 'Business']),
                    SizedBox(height: 16),
                    _buildFilterSection(
                        'Level', ['Beginner', 'Intermediate', 'Advanced']),
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
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Reset'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Apply'),
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
