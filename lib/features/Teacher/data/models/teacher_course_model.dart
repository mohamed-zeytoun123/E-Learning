class TeacherCourseModel {
  final int id;
  final String title;
  final String slug;
  final String? image;
  final int college;
  final String collegeName;
  final String price;
  final double? averageRating;
  final double totalVideoDurationHours;
  final bool isFavorite;

  TeacherCourseModel({
    required this.id,
    required this.title,
    required this.slug,
    this.image,
    required this.college,
    required this.collegeName,
    required this.price,
    this.averageRating,
    required this.totalVideoDurationHours,
    required this.isFavorite,
  });

  TeacherCourseModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? image,
    int? college,
    String? collegeName,
    String? price,
    double? averageRating,
    double? totalVideoDurationHours,
    bool? isFavorite,
  }) {
    return TeacherCourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      college: college ?? this.college,
      collegeName: collegeName ?? this.collegeName,
      price: price ?? this.price,
      averageRating: averageRating ?? this.averageRating,
      totalVideoDurationHours:
          totalVideoDurationHours ?? this.totalVideoDurationHours,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TeacherCourseModel.fromMap(Map<String, dynamic> map) {
    return TeacherCourseModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      image: map['image'] as String?,
      college: map['college'] ?? 0,
      collegeName: map['college_name'] ?? '',
      price: map['price'] ?? '',
      averageRating: map['average_rating'] != null
          ? double.tryParse(map['average_rating'].toString())
          : null,
      totalVideoDurationHours: map['total_video_duration_hours'] != null
          ? double.tryParse(map['total_video_duration_hours'].toString()) ?? 0.0
          : 0.0,
      isFavorite: map['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'image': image,
      'college': college,
      'college_name': collegeName,
      'price': price,
      'average_rating': averageRating,
      'total_video_duration_hours': totalVideoDurationHours,
      'is_favorite': isFavorite,
    };
  }
}
