import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_settings_item_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/language_bottom_sheet_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_guest_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_user_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/theme_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Profile Page', showBack: true),
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
              //TODO: Pass user data to ProfileUserHeader and UserInfoRow
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
              CustomSettingsItemWidget(
                icon: Icons.bookmark_outline,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("Saved_Courses") ??
                    "Saved Courses",
                onTap: () {
                  context.push(RouteNames.savedCourses);
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.download_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("Downloads") ??
                    "Downloads",
                onTap: () {
                  context.push(RouteNames.downloads);
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.language_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("Languages") ??
                    "Languages",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: LanguageBottomSheetWidget(),
                    ),
                  );
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.light_mode_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("Colors_Mode") ??
                    "Colors Mode",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ThemeBottomSheetWidget(),
                    ),
                  );
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.shield_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("Privacy_Policy") ??
                    "Privacy Policy",
                onTap: () {},
              ),
              CustomSettingsItemWidget(
                icon: Icons.newspaper_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(
                      context,
                    )?.translate("Terms_&_Conditions") ??
                    "Terms & Conditions",
                onTap: () {},
              ),
              CustomSettingsItemWidget(
                icon: Icons.article_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title:
                    AppLocalizations.of(context)?.translate("About_Us") ??
                    "About Us",
                onTap: () {},
              ),
              CustomSettingsItemWidget(
                icon: Icons.logout_outlined,
                iconColor: context.colors.iconRed,
                title:
                    AppLocalizations.of(context)?.translate("Log_Out") ??
                    "Log Out",
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
