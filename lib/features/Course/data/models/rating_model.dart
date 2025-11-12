class RatingModel {
  final int id;
  final int rating;
  final String comment;
  final String userName;
  final String createdAt;

  RatingModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.userName,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      userName: json['user']?['name'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
