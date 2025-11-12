import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/college_detail_model.dart';
import 'package:e_learning/features/Course/data/models/university_detail_model.dart';

class CourseDetailsModel {
  final int id;
  final String title;
  final String slug;
  final String description;
  final dynamic image;
  final int teacher;
  final String teacherName;
  final int category;
  final CategorieModel categoryDetail;
  final int college;
  final CollegeDetailModel collegeDetail;
  final int studyYear;
  final String price;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseDetailsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.image,
    required this.teacher,
    required this.teacherName,
    required this.category,
    required this.categoryDetail,
    required this.college,
    required this.collegeDetail,
    required this.studyYear,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  //* CopyWith
  CourseDetailsModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? description,
    dynamic image,
    int? teacher,
    String? teacherName,
    int? category,
    CategorieModel? categoryDetail,
    int? college,
    CollegeDetailModel? collegeDetail,
    int? studyYear,
    String? price,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CourseDetailsModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        image: image ?? this.image,
        teacher: teacher ?? this.teacher,
        teacherName: teacherName ?? this.teacherName,
        category: category ?? this.category,
        categoryDetail: categoryDetail ?? this.categoryDetail,
        college: college ?? this.college,
        collegeDetail: collegeDetail ?? this.collegeDetail,
        studyYear: studyYear ?? this.studyYear,
        price: price ?? this.price,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  //* From Map
  factory CourseDetailsModel.fromMap(Map<String, dynamic> map) {
    return CourseDetailsModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      image: map['image'],
      teacher: map['teacher'] ?? 0,
      teacherName: map['teacher_name'] ?? '',
      category: map['category'] ?? 0,
      categoryDetail: map['category_detail'] != null
          ? CategorieModel.fromMap(map['category_detail'])
          : CategorieModel(id: 0, name: '', slug: ''),
      college: map['college'] ?? 0,
      collegeDetail: map['college_detail'] != null
          ? CollegeDetailModel.fromMap(map['college_detail'])
          : CollegeDetailModel(
              id: 0,
              name: '',
              university: UniversityDetailModel(id: 0, name: ''),
            ),
      studyYear: map['study_year'] ?? 0,
      price: map['price'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }

  //* To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'image': image,
      'teacher': teacher,
      'teacher_name': teacherName,
      'category': category,
      'category_detail': categoryDetail.toMap(),
      'college': college,
      'college_detail': collegeDetail.toMap(),
      'study_year': studyYear,
      'price': price,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
