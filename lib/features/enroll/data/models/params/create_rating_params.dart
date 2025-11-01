class CreateRatingParams {
  final String courseSlug;
  final int rating;
  final String comment;

  const CreateRatingParams({
    required this.courseSlug,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
    };
  }

  CreateRatingParams copyWith({
    String? courseSlug,
    int? rating,
    String? comment,
  }) {
    return CreateRatingParams(
      courseSlug: courseSlug ?? this.courseSlug,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }
}