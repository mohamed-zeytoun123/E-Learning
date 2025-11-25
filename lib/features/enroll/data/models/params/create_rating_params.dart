class CreateRatingParams {
  final String courseSlug;
  final int rating;
  final String comment;

  CreateRatingParams({
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
}


