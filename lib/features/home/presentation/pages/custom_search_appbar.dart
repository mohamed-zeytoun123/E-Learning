import 'package:e_learning/core/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r), // You can adjust this value
        ),
      ),
      title: Text('search'.tr()),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                leading: Icon(Icons.search, color: AppColors.primaryColor),
                hintText: 'search_for_courses'.tr(),
                onTap: () {
                  controller.openView();
                },
                onChanged: (query) {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              // TODO: Implement your search suggestions logic here
              return <Widget>[];
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(128.h);
}
