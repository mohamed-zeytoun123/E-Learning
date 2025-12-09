class CourseFiltersModel {
  final int? collegeId;
  final int? categoryId;
  final int? studyYear;
  final int? universityId;

  CourseFiltersModel({
    this.collegeId,
    this.categoryId,
    this.studyYear,
    this.universityId,
  });

  CourseFiltersModel copyWith({
    int? collegeId,
    int? categoryId,
    int? studyYear,
    int? universityId,
  }) {
    return CourseFiltersModel(
      collegeId: collegeId ?? this.collegeId,
      categoryId: categoryId ?? this.categoryId,
      studyYear: studyYear ?? this.studyYear,
      universityId: universityId ?? this.universityId,
    );
  }
}

