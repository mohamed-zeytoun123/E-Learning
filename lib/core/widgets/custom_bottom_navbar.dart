import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
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
    final bottomNavItems = [
      // Home
      BottomNavigationBarItem(
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsHome3,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            Text(
              'home'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsHome3),
            Text(
              'home'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
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
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            Text(
              'Search'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsSearch1),
            Text(
              'Search'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
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
              Assets.resourceImagesVectorsClipboardList,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            Text(
              'courses'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsClipboardList),
            Text(
              'courses'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
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
              Assets.resourceImagesVectorsBookCheck,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            Text(
              'enrolls'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.resourceImagesVectorsBookCheck),
            Text(
              'enrolls'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
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
              Assets.resourceImagesVectorsPerson,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            Text(
              'profile'.tr(),
              style:
                  AppTextStyles.s12w400.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.resourceImagesVectorsPerson,
            ),
            Text(
              'profile'.tr(),
              style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
        label: '',
      ),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
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
