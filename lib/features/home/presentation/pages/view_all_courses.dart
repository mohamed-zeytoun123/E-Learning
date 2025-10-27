import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllCourses extends StatelessWidget {
  const ViewAllCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("courses".tr()),
        leading: IconButton(
          onPressed: () {
            context.read<HomeCubit>().resetHomeView();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: AppPadding.appPadding.copyWith(end: 0),
            child: ChipsBar(
              labels: [
                "all".tr(),
                "programming".tr(),
                "design".tr(),
                "business".tr()
              ],
              onChipSelected: (value) {},
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: Center(
              child: Text(
                "All Courses View\n(Replace with actual courses list)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
