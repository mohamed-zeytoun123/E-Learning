class RatingModel {
  final int id;
  final String studentName;
  final String? studentImage;
  final int rating;
  final String comment;
  final bool isFeatured;
  final DateTime createdAt;

  RatingModel({
    required this.id,
    required this.studentName,
    this.studentImage,
    required this.rating,
    required this.comment,
    required this.isFeatured,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'] ?? 0,
      studentName: json['student_name'] ?? '',
      studentImage: json['student_image'],
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_name': studentName,
      'student_image': studentImage,
      'rating': rating,
      'comment': comment,
      'is_featured': isFeatured,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
