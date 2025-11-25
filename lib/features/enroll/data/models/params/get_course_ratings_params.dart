class GetCourseRatingsParams {
  final String courseSlug;
  final int? page;
  final int? pageSize;
  final String? ordering;

  GetCourseRatingsParams({
    required this.courseSlug,
    this.page,
    this.pageSize,
    this.ordering,
  });

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};
    if (page != null) params['page'] = page;
    if (pageSize != null) params['page_size'] = pageSize;
    if (ordering != null) params['ordering'] = ordering;
    return params;
  }
}


