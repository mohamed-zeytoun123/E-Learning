import 'package:e_learning/features/enroll/presentation/manager/enroll_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/colors/app_colors.dart';

class EnrollErrorStateWidget extends StatelessWidget {
  const EnrollErrorStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error occurred while enrolling',
          style: AppTextStyles.s16w500.copyWith(color: AppColors.textError),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<EnrollCubit>().getMyCourses();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            'Retry',
            style: AppTextStyles.s16w500.copyWith(color: AppColors.textWhite),
          ),
        ),
      ],
    );
  }
}
