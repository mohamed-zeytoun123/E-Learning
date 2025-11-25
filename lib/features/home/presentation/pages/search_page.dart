import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/asset/app_images_svg.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/home/presentation/pages/custom_search_appbar.dart';
import 'package:e_learning/features/home/presentation/pages/search_tab_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(
        repository: di<CourceseRepository>(),
      ),
      child: Builder(
        builder: (context) {
          final searchCubit = context.read<SearchCubit>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomSearchAppbar(searchCubit: searchCubit),
            body: BlocBuilder<SearchCubit, SearchState>(
              bloc: searchCubit,
              builder: (context, state) {
                // Show tabbar when searching (has searched and not showing history)
                if (state.hasSearched &&
                    !state.showHistory &&
                    state.searchQuery != null &&
                    state.searchQuery!.isNotEmpty) {
                  return SearchTabBarWidget(searchCubit: searchCubit);
                }

                // Show search history when not searching
                return Padding(
                  padding: AppPadding.defaultScreen,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 36),
                        Text(
                          'recent_search'.tr(),
                          style: AppTextStyles.s18w600.copyWith(
                            color: AppColors.blackText,
                          ),
                        ),
                        SizedBox(height: 16),
                        state.searchHistory.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: AppColors.textGrey,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'no_search_history'.tr(),
                                        style: AppTextStyles.s16w400.copyWith(
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final historyItem =
                                      state.searchHistory[index];
                                  return InkWell(
                                    onTap: () {
                                      searchCubit.setQueryInInput(historyItem);
                                      searchCubit.onSearchChanged(historyItem);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImagesSvg.searchAd,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            historyItem,
                                            style: AppTextStyles.s14w400,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            searchCubit
                                                .removeFromSearchHistory(index);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: AppColors.blackText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  color: AppColors.ligthGray,
                                ),
                                itemCount: state.searchHistory.length,
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
