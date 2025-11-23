import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/home/presentation/widgets/filtered_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        } else if (state.searchQuery != null && state.searchQuery != _lastSearchQuery) {
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
                leading: Icon(Icons.search, color: AppColors.primaryColor),
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
                      showFilterBottomSheet(context, searchCubit: widget.searchCubit);
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
