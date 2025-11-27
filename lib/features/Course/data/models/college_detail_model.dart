import 'package:e_learning/features/course/data/models/university_detail_model.dart';

class CollegeDetailModel {
  final int id;
  final String name;
  final UniversityDetailModel university;

  CollegeDetailModel({
    required this.id,
    required this.name,
    required this.university,
  });

  //* CopyWith
  CollegeDetailModel copyWith({
    int? id,
    String? name,
    UniversityDetailModel? university,
  }) =>
      CollegeDetailModel(
        id: id ?? this.id,
        name: name ?? this.name,
        university: university ?? this.university,
      );

  //* From Map
  factory CollegeDetailModel.fromMap(Map<String, dynamic> map) {
    return CollegeDetailModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      university: map['university'] != null
          ? UniversityDetailModel.fromMap(map['university'])
          : UniversityDetailModel(id: 0, name: ''),
    );
  }

  //* To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'university': university.toMap(),
    };
  }
}
