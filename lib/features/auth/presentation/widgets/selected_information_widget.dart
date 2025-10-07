import 'package:e_learning/features/auth/presentation/widgets/input_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedInformationWidget extends StatelessWidget {
  const SelectedInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      children: [
        InputSelectWidget(
          hint: "Choose University",
          hintKey: "Choose_University",
          options: [
            "Damascus University",
            "Aleppo University",
            "Tishreen University",
          ],
        ),
        InputSelectWidget(
          hint: "Choose College",
          hintKey: "Choose_college",
          options: ["First Year", "Second Year", "Third Year", "Fourth Year"],
        ),
        InputSelectWidget(
          hint: "Choose Study Year",
          hintKey: "Choose_study_year",
          options: ["Math", "Physics", "IT", "Chemistry"],
        ),
      ],
    );
  }
}
