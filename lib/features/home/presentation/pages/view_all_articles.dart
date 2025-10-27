import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_cubit.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllArticles extends StatelessWidget {
  const ViewAllArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news".tr()),
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
                "tips_and_skills".tr(),
                "academic_guidance".tr(),
                "carrer_and_skils".tr()
              ],
              onChipSelected: (value) {},
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: CustomScrollView(
              slivers: [
                const ArticlesSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
