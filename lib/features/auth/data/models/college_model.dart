// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CollegeModel {
  final int id;
  final String name;
  final String slug;
  final int university;
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
  }) => CollegeModel(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    university: university ?? this.university,
    universityName: universityName ?? this.universityName,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'university': university,
      'university_name': universityName,
    };
  }

  factory CollegeModel.fromMap(Map<String, dynamic> map) {
    return CollegeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      university: map['university'] as int,
      universityName: map['university_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollegeModel.fromJson(String source) =>
      CollegeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
