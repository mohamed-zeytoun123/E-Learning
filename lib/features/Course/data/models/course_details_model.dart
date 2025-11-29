import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/college_detail_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/course/data/models/university_detail_model.dart';

class CourseDetailsModel {
  final int id;
  final String title;
  final String description;
  final String? image;
  final int teacher;
  final String teacherName;
  final String? teacherAvatar;
  final int category;
  final CategorieModel categoryDetail;
  final int college;
  final CollegeDetailModel collegeDetail;
  final int studyYear;
  final StudyYearModel studyYearDetail;
  final String price;
  final String status;
  final double totalVideoDurationHours;
  final int totalQuizzesCount;
  final double? averageRating;
  final int totalRatings;
  final bool isFavorite;
  final bool isPaid;
  final int totalVideos;
  final int completedVideos;
  final int chaptersCount; // 👈 تمت الإضافة
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.teacher,
    required this.teacherName,
    this.teacherAvatar,
    required this.category,
    required this.categoryDetail,
    required this.college,
    required this.collegeDetail,
    required this.studyYear,
    required this.studyYearDetail,
    required this.price,
    required this.status,
    required this.totalVideoDurationHours,
    required this.totalQuizzesCount,
    this.averageRating,
    required this.totalRatings,
    required this.isFavorite,
    required this.isPaid,
    required this.totalVideos,
    required this.completedVideos,
    required this.chaptersCount,
    required this.createdAt,
    required this.updatedAt,
  });

  //* From Map
  factory CourseDetailsModel.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString()) ?? 0.0;
    }

    return CourseDetailsModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image']?.toString(),
      teacher: map['teacher'] ?? 0,
      teacherName: map['teacher_name'] ?? '',
      teacherAvatar: map['teacher_avatar']?.toString(),
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
      studyYearDetail: map['study_year_detail'] != null
          ? StudyYearModel.fromJson(map['study_year_detail'])
          : StudyYearModel(
              id: 0,
              yearNumber: 0,
              name: '',
              description: '',
              isActive: false,
            ),
      price: map['price']?.toString() ?? '0.00',
      status: map['status'] ?? '',
      totalVideoDurationHours: parseDouble(map['total_video_duration_hours']),
      totalQuizzesCount: map['total_quizzes_count'] ?? 0,
      averageRating: map['average_rating'] != null
          ? parseDouble(map['average_rating'])
          : null,
      totalRatings: map['total_ratings'] ?? 0,
      isFavorite: map['is_favorite'] ?? false,
      isPaid: map['is_paid'] ?? false,
      totalVideos: map['total_videos'] ?? 0,
      completedVideos: map['completed_videos'] ?? 0,
      chaptersCount: map['chapters_count'] ?? 0,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  //* To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'teacher': teacher,
      'teacher_name': teacherName,
      'teacher_avatar': teacherAvatar,
      'category': category,
      'category_detail': categoryDetail.toMap(),
      'college': college,
      'college_detail': collegeDetail.toMap(),
      'study_year': studyYear,
      'study_year_detail': studyYearDetail.toJson(),
      'price': price,
      'status': status,
      'total_video_duration_hours': totalVideoDurationHours,
      'total_quizzes_count': totalQuizzesCount,
      'average_rating': averageRating,
      'total_ratings': totalRatings,
      'is_favorite': isFavorite,
      'is_paid': isPaid,
      'total_videos': totalVideos,
      'completed_videos': completedVideos,
      'chapters_count': chaptersCount, // 👈 تمت الإضافة
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
