import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';

class FilterWrap extends StatefulWidget {
  final List<String> labels;
  final double spacing;
  final double runSpacing;
  final int? selectedIndex;
  final Function(int? selectedIndex, String? selectedLabel)? onSelected;

  const FilterWrap({
    super.key,
    required this.labels,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.selectedIndex,
    this.onSelected,
  });

  @override
  State<FilterWrap> createState() => _FilterWrapState();
}

class _FilterWrapState extends State<FilterWrap> {
  int? selectedIndex;
  
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }
  
  @override
  void didUpdateWidget(FilterWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: widget.spacing, // Horizontal spacing between chips
      runSpacing: widget.runSpacing, // Vertical spacing between lines
      children: List.generate(widget.labels.length, (index) {
        bool isSelected = selectedIndex != null && selectedIndex! >= 0 && selectedIndex == index;
        return ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? context.colors.textBlue : Colors.transparent,
              width: 2,
            ),
          ),
          showCheckmark: false,
          backgroundColor: context.colors.buttonTapNotSelected,
          selectedColor: context.colors.buttonTapNotSelected,
          label: Text(
            widget.labels[index],
            style: AppTextStyles.s14w500.copyWith(
              color: context.colors.textBlue,
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              selectedIndex = selected ? index : null;
            });
            // Call the callback if provided
            if (widget.onSelected != null) {
              widget.onSelected!(
                selectedIndex,
                selectedIndex != null ? widget.labels[selectedIndex!] : null,
              );
            }
          },
        );
      }),
    );
  }
}
