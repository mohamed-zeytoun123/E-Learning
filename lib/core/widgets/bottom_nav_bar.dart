import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final ValueChanged<int> onTap;
  final int currentIndex;

  // Helper to build icon with bottom spacing
  Widget _buildIcon(String asset, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          asset,
          colorFilter: ColorFilter.mode(
            isActive ? AppColors.primary : AppColors.titleGrey,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 7.h), // Space between icon and label
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavItems = [
      BottomNavigationBarItem(
        activeIcon:
            _buildIcon(Assets.resourceImagesVectorsHome, isActive: true),
        label: 'home'.tr(),
        icon: _buildIcon(Assets.resourceImagesVectorsHome),
      ),
      BottomNavigationBarItem(
        activeIcon:
            _buildIcon(Assets.resourceImagesVectorsSearch1, isActive: true),
        label: 'search'.tr(),
        icon: _buildIcon(Assets.resourceImagesVectorsSearch1),
      ),
      BottomNavigationBarItem(
        activeIcon: _buildIcon(Assets.resourceImagesVectorsClipboardList,
            isActive: true),
        label: 'courses'.tr(),
        icon: _buildIcon(Assets.resourceImagesVectorsClipboardList),
      ),
      BottomNavigationBarItem(
        activeIcon: _buildIcon(Assets.resourceImagesVectorsClipboardList,
            isActive: true),
        label: 'enrolls'.tr(),
        icon: _buildIcon(Assets.resourceImagesVectorsClipboardList),
      ),
      BottomNavigationBarItem(
        activeIcon:
            _buildIcon(Assets.resourceImagesVectorsUserRound, isActive: true),
        label: 'profile'.tr(),
        icon: _buildIcon(Assets.resourceImagesVectorsUserRound),
      ),
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundPage,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.titleGrey,
          backgroundColor: Colors.transparent,
          showUnselectedLabels: true,
          elevation: 0,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          onTap: onTap,
          items: [...bottomNavItems],
        ),
      ),
    );
  }
}
