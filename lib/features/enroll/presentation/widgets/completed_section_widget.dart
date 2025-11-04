import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/review_bottom_sheet_widget.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';
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
  late TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check rating status on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EnrollCubit>().getCourseRatings(
        GetCourseRatingsParams(courseSlug: widget.courseSlug),
      );
    });
    return BlocBuilder<EnrollCubit, EnrollState>(
      buildWhen: (previous, current) {
        return previous.getCourseRatingsState !=
                current.getCourseRatingsState ||
            previous.courseRatingsMap[widget.courseSlug] !=
                current.courseRatingsMap[widget.courseSlug];
      },
      builder: (context, state) {
        final isLoading =
            state.getCourseRatingsState == ResponseStatusEnum.loading;

        // Get rating response specific to this course
        final courseRatingResponse = state.courseRatingsMap[widget.courseSlug];
        final isRated =
            state.getCourseRatingsState == ResponseStatusEnum.success &&
            courseRatingResponse != null &&
            (courseRatingResponse.count > 0);
        return Column(
          children: [
            CustomButtonWidget(
              title: isLoading
                  ? AppLocalizations.of(context)?.translate("Loading") ??
                        "Loading..."
                  : isRated
                  ? AppLocalizations.of(context)?.translate("View_Ratings") ??
                        "View Rating"
                  : AppLocalizations.of(context)?.translate("Rate") ?? "Rate",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.textWhite,
              ),
              buttonColor: Theme.of(context).colorScheme.primary,
              borderColor: Theme.of(context).colorScheme.primary,
              onTap: isLoading
                  ? null
                  : () {
                      final state = context.read<EnrollCubit>().state;
                      final courseRatingResponse =
                          state.courseRatingsMap[widget.courseSlug];
                      final ratingData =
                          courseRatingResponse?.results.isNotEmpty == true
                          ? courseRatingResponse!.results.first
                          : null;
                      isRated
                          ? showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: YourReviewBottomSheetWidget(
                                      reviewText:
                                          ratingData?.comment ??
                                          'No review available',
                                      rating: ratingData?.rating ?? 1,
                                      timeAgo:
                                          ratingData?.createdAt ?? "Unknown",
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
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: BlocProvider.value(
                                      value: EnrollCubit(
                                        repository:
                                            appLocator<EnrollRepository>(),
                                      ),
                                      child: ReviewBottomSheetWidget(
                                        reviewController: reviewController,
                                        courseSlug: widget.courseSlug,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    },
            ),
          ],
        );
      },
    );
  }
}
