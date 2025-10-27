import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_cubit.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllTeachers extends StatelessWidget {
  const ViewAllTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("teachers".tr()),
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
        body: GridView.builder(
          padding: AppPadding.appPadding.copyWith(top: 32),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 28),
          itemBuilder: (context, index) {
            return FittedBox(child: TeatcherCard());
          },
        ));
  }
}
