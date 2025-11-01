import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_cubit.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_state.dart';
import 'package:e_learning/features/enroll/presentation/widgets/your_review_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedSectionWidget extends StatefulWidget {
  final String courseSlug;
  const CompletedSectionWidget({super.key, required this.courseSlug});

  @override
  State<CompletedSectionWidget> createState() => _CompletedSectionWidgetState();
}

class _CompletedSectionWidgetState extends State<CompletedSectionWidget> {
  final TextEditingController reviewController = TextEditingController();
  bool isLoading = false;
  bool isRated = false;
  
  @override
  void initState() {
    super.initState();
    _checkRatingStatus();
  }

  void _checkRatingStatus() {
    setState(() {
      isLoading = true;
    });
    
    context.read<EnrollCubit>().getCourseRatings(
      GetCourseRatingsParams(courseSlug: widget.courseSlug),
    );
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnrollCubit, EnrollState>(
      listener: (context, state) {
        if (state.getCourseRatingsState == ResponseStatusEnum.success) {
          setState(() {
            isLoading = false;
            isRated = (state.courseRatingsResponse?.count ?? 0) > 0;
          });
        } else if (state.getCourseRatingsState == ResponseStatusEnum.failure) {
          setState(() {
            isLoading = false;
            isRated = false; // Default to not rated on error
          });
        }
      },
      child: Column(
        children: [
          CustomButtonWidget(
            title: isLoading 
                ? AppLocalizations.of(context)?.translate("Loading") ?? "Loading..."
                : isRated
                    ? AppLocalizations.of(context)?.translate("View_Ratings") ?? "View Rating"
                    : AppLocalizations.of(context)?.translate("Rate") ?? "Rate",
            titleStyle: AppTextStyles.s16w500.copyWith(
              color: AppColors.textWhite,
            ),
            buttonColor: Theme.of(context).colorScheme.primary,
            borderColor: Theme.of(context).colorScheme.primary,
            onTap: isLoading ? null : () {
              isRated
                  ? _showViewRatingBottomSheet()
                  : _showCreateRatingBottomSheet();
            },
          ),
        ],
      ),
    );
  }

  void _showViewRatingBottomSheet() {
    final state = context.read<EnrollCubit>().state;
    final ratingData = state.courseRatingsResponse?.results.isNotEmpty == true 
        ? state.courseRatingsResponse!.results.first 
        : null;
        
    showModalBottomSheet(
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
              reviewText: ratingData?.comment ?? 'No review available',
            ),
          ),
        );
      },
    );
  }

  void _showCreateRatingBottomSheet() {
    showModalBottomSheet(
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
  }
}
