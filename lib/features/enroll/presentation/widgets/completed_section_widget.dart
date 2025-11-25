import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/your_review_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CompletedSectionWidget extends StatefulWidget {
  final bool isRated;
  const CompletedSectionWidget({super.key, required this.isRated});

  @override
  State<CompletedSectionWidget> createState() => _CompletedSectionWidgetState();
}

class _CompletedSectionWidgetState extends State<CompletedSectionWidget> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          title: widget.isRated ? "View_Ratings".tr() : "Rate".tr(),
          buttonColor: context.colors.textBlue,
          onTap: () {
            widget.isRated
                ? showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: YourReviewBottomSheetWidget(
                            reviewText: reviewController.text.trim(),
                          ),
                        ),
                      );
                    },
                  )
                : showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ReviewBottomSheetWidget(
                            reviewController: reviewController,
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}
