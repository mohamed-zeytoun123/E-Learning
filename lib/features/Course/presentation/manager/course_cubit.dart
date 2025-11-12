import 'dart:developer';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
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

  // List<CourseModel> getCoursesBySelectedCollege() {
  //   final selectedIndex = state.selectedIndex;
  //   final allCourses = state.courses ?? [];
  //   final colleges = state.colleges ?? [];

  //   if (selectedIndex == 0) {
  //     return allCourses;
  //   }

  //   final selectedCollegeIndex = selectedIndex - 1;
  //   if (selectedCollegeIndex < 0 || selectedCollegeIndex >= colleges.length) {
  //     return [];
  //   }

  //   final selectedCollegeId = colleges[selectedCollegeIndex].id;

  //   return allCourses
  //       .where((course) => course.college == selectedCollegeId)
  //       .toList();
  // }

  //?-----------------------------------------------------------------------------

  //* Get Filter Categories
  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: ResponseStatusEnum.loading));

    final Either<Failure, List<CategorieModel>> result = await repo
        .getCategoriesRepo();

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
        log('Fetched categories: ${categories.map((c) => c.name).toList()}');
      },
    );
  }

  //?-----------------------------------------------------------------------------
  //* Get Courses with Pagination & optional reset
  Future<void> getCourses({
    CourseFiltersModel? filters,
    int? teacherId,
    String? search,
    String? ordering,
    bool reset = true,
    int page = 1,
    int pageSize = 10,
  }) async {
    if (reset) {
      // الحالة الأولى: تحميل أول مرة أو إعادة التحديث
      emit(
        state.copyWith(
          coursesStatus: ResponseStatusEnum.loading,
          loadCoursesMoreStatus: ResponseStatusEnum.initial,
          coursesError: null,
          coursesMoreError: null,
          courses: CoursesResultModel.empty(),
        ),
      );
    } else {
      // الحالة الثانية: تحميل المزيد (Load More)
      emit(
        state.copyWith(
          loadCoursesMoreStatus: ResponseStatusEnum.loading,
          coursesMoreError: null,
        ),
      );
    }

    final result = await repo.getCoursesRepo(
      filters: filters,
      teacherId: teacherId,
      search: search,
      ordering: ordering,
      page: page,
      pageSize: pageSize,
    );

    result.fold(
      (failure) {
        if (reset) {
          emit(
            state.copyWith(
              coursesStatus: ResponseStatusEnum.failure,
              coursesError: failure.message,
              loadCoursesMoreStatus: ResponseStatusEnum.initial,
            ),
          );
        } else {
          emit(
            state.copyWith(
              loadCoursesMoreStatus: ResponseStatusEnum.failure,
              coursesMoreError: failure.message,
            ),
          );
        }
      },
      (newCourses) {
        // ✅ تحقق من أن القائمة فارغة بعد reset
        if (reset && (newCourses.courses?.isEmpty ?? true)) {
          emit(
            state.copyWith(
              coursesStatus: ResponseStatusEnum.success,
              courses: CoursesResultModel.empty(),
              hasMoreCourses: false,
              currentPage: page,
              coursesError: null,
              loadCoursesMoreStatus: ResponseStatusEnum.initial,
              coursesMoreError: null,
            ),
          );
          return; // مهم لإيقاف باقي الكود
        }

        final updatedCourses = reset
            ? newCourses
            : (state.courses ?? CoursesResultModel.empty()).copyWith(
                courses: [
                  ...(state.courses?.courses ?? []),
                  ...?(newCourses.courses),
                ],
                hasNextPage: newCourses.hasNextPage,
              );

        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.success,
            loadCoursesMoreStatus: ResponseStatusEnum.success,
            courses: updatedCourses,
            hasMoreCourses: newCourses.hasNextPage,
            currentPage: page,
            coursesError: null,
            coursesMoreError: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Apply Filters with 3 optional parameters
  Future<void> applyFiltersByIds({
    int? collegeId,
    int? studyYear,
    int? categoryId,
  }) async {
    try {
      final filters = CourseFiltersModel(
        collegeId: collegeId,
        studyYear: studyYear,
        categoryId: categoryId,
      );

      emit(state.copyWith(coursefilters: filters));

      await getCourses(filters: filters, reset: true, page: 1);
    } catch (e) {
      log('Error in applyFiltersByIds: $e');
    }
  }

  //?-------------------------------------------------
  //* Toggle Favorite for a Course
  Future<void> toggleFavorite({required String courseSlug}) async {
    try {
      // إذا ما في بيانات حالياً، ما نعمل شي
      if (state.courses == null) return;

      final currentCoursesResult = state.courses!;
      final currentCourses = List<CourseModel>.from(
        currentCoursesResult.courses ?? [],
      );

      // تحديث محلي فوري (UI)
      final locallyUpdatedCourses = currentCourses.map((course) {
        if (course.slug == courseSlug) {
          return course.copyWith(isFavorite: !course.isFavorite);
        }
        return course;
      }).toList();

      // Emit سريع لتحديث UI فورًا
      emit(
        state.copyWith(
          courses: currentCoursesResult.copyWith(
            courses: locallyUpdatedCourses,
          ),
          isFavoriteError: null,
        ),
      );

      // استدعاء الريبو لتبديل الحالة على السيرفر
      final result = await repo.toggleFavoriteCourseRepo(
        courseSlug: courseSlug,
      );

      result.fold(
        (failure) {
          // رجّع الحالة الأصلية إذا فشل الطلب
          emit(
            state.copyWith(
              courses: currentCoursesResult,
              isFavoriteError: failure.message,
            ),
          );
          log('Error toggling favorite: ${failure.message}');
        },
        (isFavoriteFromServer) {
          // تأكيد التحديث من السيرفر
          final serverUpdatedCourses = currentCourses.map((course) {
            if (course.slug == courseSlug) {
              return course.copyWith(isFavorite: isFavoriteFromServer);
            }
            return course;
          }).toList();

          emit(
            state.copyWith(
              courses: currentCoursesResult.copyWith(
                courses: serverUpdatedCourses,
              ),
              isFavoriteError: null,
            ),
          );
        },
      );
    } catch (e) {
      log('Unexpected error in toggleFavorite: $e');
    }
  }

  //?-------------------------------------------------

  //* Apply Filters
  Future<void> applyFilters(CourseFiltersModel filters) async {
    try {
      // تحديث الفلاتر في الـ state
      emit(state.copyWith(coursefilters: filters));

      // استدعاء getCourses مع إعادة التعيين (reset=true)
      await getCourses(filters: filters, reset: true, page: 1);
    } catch (e) {
      log('Error in applyFilters: $e');
    }
  }

  //?-----------------------------------------------------------------------------

  // //* Get Courses
  // Future<void> getCourses({
  //   int? collegeId,
  //   int? studyYear,
  //   int? categoryId,
  //   int? teacherId,
  //   String? search,
  //   String? ordering,
  // }) async {
  //   emit(state.copyWith(coursesStatus: ResponseStatusEnum.loading));
  //   log('Applying filters Cubit : college=$categoryId, studyYear=$studyYear');
  //   final result = await repo.getCoursesRepo(
  //     collegeId: collegeId,
  //     studyYear: studyYear,
  //     categoryId: categoryId,
  //     teacherId: teacherId,
  //     search: search,
  //     ordering: ordering,
  //   );

  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           coursesStatus: ResponseStatusEnum.failure,
  //           coursesError: failure.message,
  //         ),
  //       );
  //     },
  //     (courses) {
  //       emit(
  //         state.copyWith(
  //           coursesStatus: ResponseStatusEnum.success,
  //           courses: courses,
  //           coursesError: null,
  //         ),
  //       );
  //     },
  //   );
  // }

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

  // Future<void> applyFilters(CourseFiltersModel filters) async {
  //   try {
  //     // تحديث الفلاتر في الـ state
  //     emit(state.copyWith(coursefilters: filters));

  //     // حفظ الفلاتر بالكاش (لو عندك طريقة للكاش)
  //     // await local.saveCourseFilters(filters);

  //     // استدعاء getCourses مع تحويل الفلاتر للباراميترات المناسبة
  //     await getCourses(
  //       collegeId: filters.collegeId,

  //       studyYear: filters.studyYear,
  //     );
  //   } catch (e) {
  //     log('Error in applyFilters: $e');
  //   }
  // }

  //?-------------------------------------------------

  //* Filter Courses by College
  // List<CourseModel> filterCoursesByCollege(int collegeId) {
  //   final allCourses = state.courses ?? [];

  //   final filteredCourses = allCourses
  //       .where((course) => course.college == collegeId)
  //       .toList();

  //   return filteredCourses;
  // }

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
  Future<void> getChapters({required String courseSlug}) async {
    emit(state.copyWith(chaptersStatus: ResponseStatusEnum.loading));

    final result = await repo.getChaptersRepo(courseSlug: courseSlug);

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

  //?--------------------------------------------------------

  //* Get Universities
  Future<void> getUniversities() async {
    emit(
      state.copyWith(
        universitiesState: ResponseStatusEnum.loading,
        universitiesError: null,
      ),
    );

    final result = await repo.getUniversitiesRepo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          universitiesState: ResponseStatusEnum.failure,
          universitiesError: failure.message,
        ),
      ),
      (universities) => emit(
        state.copyWith(
          universitiesState: ResponseStatusEnum.success,
          universities: universities,
        ),
      ),
    );
  }

  //?-------------------------------------------------
  //* Get Study Years
  Future<void> getStudyYears() async {
    emit(state.copyWith(studyYearsStatus: ResponseStatusEnum.loading));

    final result = await repo.getStudyYearsRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            studyYearsStatus: ResponseStatusEnum.failure,
            studyYearsError: failure.message,
          ),
        );
        log('Failed to fetch study years: ${failure.message}');
      },
      (years) {
        emit(
          state.copyWith(
            studyYearsStatus: ResponseStatusEnum.success,
            studyYears: years,
          ),
        );
        log('Fetched study years: ${years.map((y) => y.name).toList()}');
      },
    );
  }

  //?-------------------------------------------------
}
