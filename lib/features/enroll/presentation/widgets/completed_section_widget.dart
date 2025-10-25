import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/your_review_bottom_sheet_widget.dart';
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
        CustomButtonWidget(
          title: widget.isRated
              ? AppLocalizations.of(context)?.translate("View_Ratings") ??
                    "View Rating"
              : AppLocalizations.of(context)?.translate("Rate") ?? "Rate",
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.textWhite,
          ),
          buttonColor: Theme.of(context).colorScheme.primary,
          borderColor: Theme.of(context).colorScheme.primary,
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
