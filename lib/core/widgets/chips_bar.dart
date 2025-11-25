import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class ChipsBar extends StatefulWidget {
  const ChipsBar({
    super.key,
    required this.labels,
    required this.onChipSelected,
    this.withFilter = false,
    this.onFilterTap,
  });

  final List<String> labels;
  final ValueChanged<String> onChipSelected; // Callback for chip selection
  final bool withFilter;
  final VoidCallback? onFilterTap; // Nullable filter button callback

  @override
  State<ChipsBar> createState() => _ChipsBarState();
}

class _ChipsBarState extends State<ChipsBar> {
  int? _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Filter button if withFilter is true
          if (widget.withFilter)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: context.colors.textBlue,
                ),
                onPressed: widget.onFilterTap,
              ),
            ),
          // Chips
          ...List.generate(widget.labels.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0),
              child: ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                side: const BorderSide(color: Colors.transparent),
                showCheckmark: false,
                backgroundColor: context.colors.buttonTapNotSelected,
                selectedColor: context.colors.textBlue,
                label: Text(
                  widget.labels[index],
                  style: AppTextStyles.s14w500.copyWith(
                    color: getChipTextColor(index, _selectedIndex),
                  ),
                ),
                selected: _selectedIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedIndex = selected ? index : null;
                    widget.onChipSelected(
                        widget.labels[index]); // Notify selection
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Color getChipTextColor(int index, int? selectedIndex) {
    return selectedIndex == index ? Colors.white : context.colors.textBlue;
  }
}
