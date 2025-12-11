import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchAppbar extends StatefulWidget implements PreferredSizeWidget {
  final SearchCubit searchCubit;

  const CustomSearchAppbar({
    super.key,
    required this.searchCubit,
  });

  @override
  State<CustomSearchAppbar> createState() => _CustomSearchAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(128.h);
}

class _CustomSearchAppbarState extends State<CustomSearchAppbar> {
  late TextEditingController _searchController;
  String? _lastQueryToSet;
  String? _lastSearchQuery;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: widget.searchCubit,
      builder: (context, state) {
        // Update controller text when queryToSet changes (from history tap)
        if (state.queryToSet != null && state.queryToSet != _lastQueryToSet) {
          _lastQueryToSet = state.queryToSet;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _searchController.text = state.queryToSet!;
              _searchController.selection = TextSelection.fromPosition(
                TextPosition(offset: _searchController.text.length),
              );
              widget.searchCubit.clearQueryToSet();
            }
          });
        }

        // Update controller when search is cleared
        if (state.searchQuery == null && _lastSearchQuery != null) {
          _lastSearchQuery = null;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _searchController.clear();
            }
          });
        } else if (state.searchQuery != null &&
            state.searchQuery != _lastSearchQuery) {
          // Only update if the query changed externally (not from user typing)
          if (_searchController.text != state.searchQuery) {
            _lastSearchQuery = state.searchQuery;
          }
        }

        return AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.r),
            ),
          ),
          title: Text('search'.tr()),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SearchBar(
                controller: _searchController,
                constraints: BoxConstraints(
                  minHeight: 44.h,
                  maxHeight: 44.h,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                leading: SvgPicture.asset(
                  Assets.resourceImagesVectorsSearch1,
                  color: AppColors.primary,
                ),
                hintText: 'search_for_courses'.tr(),
                onChanged: (query) {
                  widget.searchCubit.onSearchChanged(query);
                },
                onSubmitted: (query) {
                  if (query.trim().isNotEmpty) {
                    widget.searchCubit.addToSearchHistory(query.trim());
                    widget.searchCubit.onSearchChanged(query);
                  }
                },
                trailing: [
                  // Filter button only
                  IconButton(
                    icon: Icon(Icons.tune, color: AppColors.primaryColor),
                    onPressed: () {
                      // Create a CourseCubit for the filter bottom sheet
                      final courseCubit = CourseCubit(
                        repo: appLocator<CourceseRepository>(),
                      )
                        ..getUniversities()
                        ..getColleges()
                        ..getStudyYears();
                      
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => BlocProvider<CourseCubit>.value(
                          value: courseCubit,
                          child: FiltersBottomSheetWidget(
                            onFiltersApplied: (filters) {
                              // Update SearchCubit with the applied filters
                              widget.searchCubit.updateFilters(filters);
                              
                              // Re-search if there's an active query
                              final searchQuery = widget.searchCubit.state.searchQuery;
                              if (searchQuery != null && searchQuery.trim().isNotEmpty) {
                                widget.searchCubit.searchAll(
                                  searchQuery: searchQuery,
                                  filters: filters,
                                  ordering: '-price',
                                  page: 1,
                                  pageSize: 5,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
