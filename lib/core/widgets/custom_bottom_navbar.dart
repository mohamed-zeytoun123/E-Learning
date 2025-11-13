import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final ValueChanged<int> onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    final bottomNavItems = [
      // Home
      BottomNavigationBarItem(backgroundColor: colors.buttonTapNotSelected,
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsHome3,
              colorFilter:
                  ColorFilter.mode(colors.textBlue, BlendMode.srcIn),
            ),
            Text(
              'home'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: colors.textBlue),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsHome3,color:colors.textGrey),
            Text(
              'home'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
      // Search
      BottomNavigationBarItem(
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsSearch1,
              colorFilter:
                  ColorFilter.mode(colors.textBlue, BlendMode.srcIn),
            ),
            Text(
              'Search'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: colors.textBlue),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsSearch1,color:colors.textGrey),
            Text(
              'Search'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
      // Courses
      BottomNavigationBarItem(
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsClipboardList,color:colors.textGrey,
              colorFilter:
                  ColorFilter.mode(colors.textBlue, BlendMode.srcIn),
            ),
            Text(
              'courses'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: colors.textBlue),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsClipboardList,color:colors.textGrey),
            Text(
              'courses'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
      // Enrolls
      BottomNavigationBarItem(
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsBookCheck,color:colors.textGrey,
              colorFilter:
                  ColorFilter.mode(colors.textBlue, BlendMode.srcIn),
            ),
            Text(
              'enrolls'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: colors.textBlue),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsBookCheck,color:colors.textGrey),
            Text(
              'enrolls'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
      // Profile
      BottomNavigationBarItem(
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsPerson,color:colors.textGrey,
              colorFilter:
                  ColorFilter.mode(colors.textBlue, BlendMode.srcIn),
            ),
            Text(
              'profile'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: colors.textBlue),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsPerson,color:colors.textGrey
            ),
            Text(
              'profile'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.buttonTapNotSelected,
      elevation: 0,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.iconGrey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onTap,
      items: bottomNavItems,
    );
  }
}
