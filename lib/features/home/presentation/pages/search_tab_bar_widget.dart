import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTabBarWidget extends StatelessWidget {
  final SearchCubit searchCubit;

  const SearchTabBarWidget({super.key, required this.searchCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          initialIndex: state.selectedTabIndex,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  searchCubit.changeTabIndex(index);
                },
                tabs: [
                  Tab(
                    text: 'courses'.tr(),
                  ),
                  Tab(
                    text: 'articles'.tr(),
                  ),
                  Tab(
                    text: 'teachers'.tr(),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Courses Tab
                    _buildCoursesTab(state),
                    // Articles Tab
                    _buildArticlesTab(state),
                    // Teachers Tab
                    _buildTeachersTab(state),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoursesTab(SearchState state) {
    if (state.status == ResponseStatusEnum.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.courses.isEmpty) {
      return Center(
        child: Text('no_courses_found'.tr()),
      );
    }

    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          leading: course.image != null
              ? Image.network(
                  course.image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.book),
          title: Text(course.title),
          subtitle: Text(course.collegeName),
          trailing: Text(course.price),
        );
      },
    );
  }

  Widget _buildArticlesTab(SearchState state) {
    if (state.status == ResponseStatusEnum.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.articles.isEmpty) {
      return Center(
        child: Text('no_articles_found'.tr()),
      );
    }

    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (context, index) {
        final article = state.articles[index];
        return ListTile(
          leading: article.image != null
              ? Image.network(
                  article.image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.article),
          title: Text(article.title),
          subtitle: Text(article.summary),
          trailing: Text(article.readingTime),
        );
      },
    );
  }

  Widget _buildTeachersTab(SearchState state) {
    if (state.status == ResponseStatusEnum.loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.status == ResponseStatusEnum.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () {
                if (state.searchQuery != null) {
                  searchCubit.searchAll(searchQuery: state.searchQuery);
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.teachers.isEmpty) {
      return Center(
        child: Text('no_teachers_found'.tr()),
      );
    }

    return ListView.builder(
      itemCount: state.teachers.length,
      itemBuilder: (context, index) {
        final teacher = state.teachers[index];
        return ListTile(
          leading: teacher.avatar != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(teacher.avatar!),
                )
              : CircleAvatar(
                  child: Icon(Icons.person),
                ),
          title: Text(teacher.fullName),
          subtitle: Text(teacher.bio ?? ''),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${teacher.coursesNumber} courses'),
              Text('${teacher.students} students'),
            ],
          ),
        );
      },
    );
  }
}
