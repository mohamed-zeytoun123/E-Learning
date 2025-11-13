import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.resourceImagesVectorsHome,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        label: 'home'.tr(),
        icon: SvgPicture.asset(
          Assets.resourceImagesVectorsHome,
          colorFilter:
              const ColorFilter.mode(AppColors.titleGrey, BlendMode.srcIn),
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.resourceImagesVectorsSearch1,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        label: 'search'.tr(),
        icon: SvgPicture.asset(Assets.resourceImagesVectorsSearch1),
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.resourceImagesVectorsClipboardList,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        label: 'courses'.tr(),
        icon: SvgPicture.asset(
          Assets.resourceImagesVectorsClipboardList,
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.resourceImagesVectorsClipboardList,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        label: 'enrolls'.tr(),
        icon: SvgPicture.asset(
          Assets.resourceImagesVectorsClipboardList,
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.resourceImagesVectorsUserRound,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        label: 'profile'.tr(),
        icon: SvgPicture.asset(
          Assets.resourceImagesVectorsUserRound,
        ),
      ),
    ];

    // Calculate the width for each item

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: AppColors.titleGrey,
      backgroundColor: AppColors.backgroundPage,
      showUnselectedLabels: true,
      elevation: 0,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      onTap: onTap,
      items: [...bottomNavItems],
    );
  }
}
