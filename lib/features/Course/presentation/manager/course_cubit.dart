import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({required this.repo}) : super(CourseState());
  final CourceseRepository repo;

  //?-------------------------------------------------
  //* Change Selected Index
  void changeSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  List<CourseModel> getCoursesBySelectedCollege() {
    final selectedIndex = state.selectedIndex;
    final allCourses = state.courses ?? [];
    final colleges = state.colleges ?? [];

    if (selectedIndex == 0) {
      return allCourses;
    }

    final selectedCollegeIndex = selectedIndex - 1;
    if (selectedCollegeIndex < 0 || selectedCollegeIndex >= colleges.length) {
      return [];
    }

    final selectedCollegeId = colleges[selectedCollegeIndex].id;

    return allCourses
        .where((course) => course.college == selectedCollegeId)
        .toList();
  }

  //?-----------------------------------------------------------------------------

  //* Get Filter Categories
  Future<void> getFilterCategories() async {
    emit(state.copyWith(categoriesStatus: ResponseStatusEnum.loading));

    final Either<Failure, List<CategorieModel>> result = await repo
        .getFilterCategoriesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesStatus: ResponseStatusEnum.failure,
            categoriesError: failure.message,
          ),
        );
      },
      (categories) {
        emit(
          state.copyWith(
            categoriesStatus: ResponseStatusEnum.success,
            categories: categories,
          ),
        );
      },
    );
  }

  //?-----------------------------------------------------------------------------

  //* Get Courses
  Future<void> getCourses() async {
    emit(state.copyWith(coursesStatus: ResponseStatusEnum.loading));

    final result = await repo.getCoursesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.failure,
            coursesError: failure.message,
          ),
        );
      },
      (courses) {
        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.success,
            courses: courses,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Get Colleges
  Future<void> getColleges() async {
    emit(state.copyWith(collegesStatus: ResponseStatusEnum.loading));

    final result = await repo.getCollegesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            collegesStatus: ResponseStatusEnum.failure,
            collegesError: failure.message,
          ),
        );
      },
      (colleges) {
        emit(
          state.copyWith(
            collegesStatus: ResponseStatusEnum.success,
            colleges: colleges,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Filter Courses by College
  List<CourseModel> filterCoursesByCollege(int collegeId) {
    final allCourses = state.courses ?? [];

    final filteredCourses = allCourses
        .where((course) => course.college == collegeId)
        .toList();

    return filteredCourses;
  }

  //?-------------------------------------------------
  //* Get Course Details by Slug
  Future<void> getCourseDetails({required String slug}) async {
    emit(state.copyWith(courseDetailsStatus: ResponseStatusEnum.loading));

    final result = await repo.getCourseDetailsRepo(courseSlug: slug);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            courseDetailsStatus: ResponseStatusEnum.failure,
            courseDetailsError: failure.message,
          ),
        );
      },
      (courseDetails) {
        emit(
          state.copyWith(
            courseDetailsStatus: ResponseStatusEnum.success,
            courseDetails: courseDetails,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Get Chapters by Course
  Future<void> getChapters({required int courseId}) async {
    emit(state.copyWith(chaptersStatus: ResponseStatusEnum.loading));

    final result = await repo.getChaptersRepo(courseId: courseId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            chaptersStatus: ResponseStatusEnum.failure,
            chaptersError: failure.message,
          ),
        );
      },
      (chapters) {
        emit(
          state.copyWith(
            chaptersStatus: ResponseStatusEnum.success,
            chapters: chapters,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------}
}
