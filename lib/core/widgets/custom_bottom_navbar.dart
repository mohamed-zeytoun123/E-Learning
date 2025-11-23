import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
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
              'Home',
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
              'Home',
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
              'Search',
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
              'Search',
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
              'Courses',
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
              'Courses',
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
              'Enrolls',
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
              'Enrolls',
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
              'Profile',
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
              'Profile',
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
