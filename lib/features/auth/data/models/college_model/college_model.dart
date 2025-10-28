import 'dart:convert';

import 'package:hive/hive.dart';
part 'college_model.g.dart';


@HiveType(typeId: 3)
class CollegeModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String slug;

  @HiveField(3)
  final int university;

  @HiveField(4)
  final String universityName;

  CollegeModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.university,
    required this.universityName,
  });

  CollegeModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? university,
    String? universityName,
  }) =>
      CollegeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        university: university ?? this.university,
        universityName: universityName ?? this.universityName,
      );

  factory CollegeModel.fromMap(Map<String, dynamic> map) {
    return CollegeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      university: map['university'] as int,
      universityName: map['university_name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'university': university,
      'university_name': universityName,
    };
  }

  factory CollegeModel.fromJson(String source) =>
      CollegeModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
