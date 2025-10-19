import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_profile_list_tile.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_guest_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
          right: 16.w,
          left: 16.w,
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
                iconColor: context.colors.iconBlack,
                title: 'Saved Courses',
                onTap: () {
                  context.push(RouteNames.savedCourses);
                },
              ),
              CustomProfileListTile(
                icon: Icons.download_outlined,
                iconColor: context.colors.iconBlack,
                title: 'DownLoads',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.language_outlined,
                iconColor: context.colors.iconBlack,
                title: 'Languages',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.light_mode_outlined,
                iconColor: context.colors.iconBlack,
                title: 'Colors Mode',
                onTap: () => context.read<AppManagerCubit>().toggleTheme(),
              ),
              CustomProfileListTile(
                icon: Icons.shield_outlined,
                iconColor: context.colors.iconBlack,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.newspaper_outlined,
                iconColor: context.colors.iconBlack,
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.article_outlined,
                iconColor: context.colors.iconBlack,
                title: 'About Us',
                onTap: () {},
              ),
              CustomProfileListTile(
                icon: Icons.logout_outlined,
                iconColor: context.colors.iconRed,
                title: 'Log Out',
                titleColor: context.colors.textRed,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
