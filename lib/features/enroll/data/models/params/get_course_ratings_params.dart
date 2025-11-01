class GetCourseRatingsParams {
  final String courseSlug;
  final String? ordering;
  final int? page;
  final int? pageSize;

  const GetCourseRatingsParams({
    required this.courseSlug,
    this.ordering = '-created_at', // Default to newest first
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};

    if (ordering != null) {
      params['ordering'] = ordering;
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    if (pageSize != null) {
      params['page_size'] = pageSize.toString();
    }

    // Debug logging
    print('🔧 [GetCourseRatingsParams] courseSlug: $courseSlug');
    print('🔧 [GetCourseRatingsParams] toQueryParams: $params');

    return params;
  }

  GetCourseRatingsParams copyWith({
    String? courseSlug,
    String? ordering,
    int? page,
    int? pageSize,
  }) {
    return GetCourseRatingsParams(
      courseSlug: courseSlug ?? this.courseSlug,
      ordering: ordering ?? this.ordering,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
