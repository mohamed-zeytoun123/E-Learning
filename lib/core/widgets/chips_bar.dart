import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChipsBar extends StatefulWidget {
  const ChipsBar(
      {super.key, required this.labels, required this.onChipSelected});

  final List<String> labels;
  final ValueChanged<String> onChipSelected; // Callback for chip selection

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
        children: List.generate(widget.labels.length, (index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              side: const BorderSide(color: Colors.transparent),
              showCheckmark: false,
              backgroundColor: AppColors.ligthGray,
              selectedColor: AppColors.primaryColor,
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
                  widget
                      .onChipSelected(widget.labels[index]); // Notify selection
                });
              },
            ),
          );
        }),
      ),
    );
  }

  Color getChipTextColor(int index, int? selectedIndex) {
    return selectedIndex == index ? Colors.white : AppColors.primaryTextColor;
  }
}
