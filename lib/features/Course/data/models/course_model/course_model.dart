import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 2)
class CourseModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String slug;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final int college;

  @HiveField(5)
  final String collegeName;

  @HiveField(6)
  final String price;

  @HiveField(7)
  final double? averageRating;

  CourseModel({
    required this.id,
    required this.title,
    required this.slug,
    this.image,
    required this.college,
    required this.collegeName,
    required this.price,
    this.averageRating,
  });

  CourseModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? image,
    int? college,
    String? collegeName,
    String? price,
    double? averageRating,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      college: college ?? this.college,
      collegeName: collegeName ?? this.collegeName,
      price: price ?? this.price,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
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
    );
  }

  // لتحويل الموديل لـ JSON
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
    };
  }
}
