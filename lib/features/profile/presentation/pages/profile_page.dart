import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_profile_list_tile.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_guest_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile Page', showBack: true),
      body: Padding(
        padding: EdgeInsets.only(
          top: 42.h,
          bottom: 32.h,
          right: 24.w,
          left: 24.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TODO: Pass user data to ProfileUserHeader and UserInfoRow
              BlocBuilder<AppManagerCubit, AppManagerState>(
                builder: (context, state) {
                  if (state.appState == AppStateEnum.user) {
                    return ProfileUserHeader();
                  } else {
                    return ProfileGuestHeader();
                  }
                },
              ),
              SizedBox(height: 32.h),
              CustomProfileListTile(
                icon: Icons.bookmark_outline,
                title: 'Saved Courses',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.download_outlined,
                title: 'DownLoads',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.language_outlined,
                title: 'Languages',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.light_mode_outlined,
                title: 'Colors Mode',
                onTap: () => context.read<AppManagerCubit>().toggleTheme(),
              ),
              CustomProfileListTile(
                icon: Icons.shield_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.article_outlined,
                title: 'About Us',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.logout_outlined,
                iconColor: AppColors.iconRed,
                title: 'Log Out',
                titleColor: AppColors.textRed,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
