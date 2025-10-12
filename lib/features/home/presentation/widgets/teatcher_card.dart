import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TeatcherCard extends StatelessWidget {
  const TeatcherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return    Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    Assets.resourceImagesPngHomeeBg,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Full Name',
                  style: AppTextStyles.s14w400,
                ),
                const SizedBox(height: 4),
                Text(
                  '4 ${'courses'.tr()}',
                  style:
                      AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
                ),
              ],
            );
  }
}