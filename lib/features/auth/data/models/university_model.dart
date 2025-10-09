import 'dart:convert';

class UniversityModel {
  final int id;
  final String name;
  final String slug;

  UniversityModel({required this.id, required this.name, required this.slug});

  UniversityModel copyWith({int? id, String? name, String? slug}) =>
      UniversityModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'slug': slug};
  }

  factory UniversityModel.fromMap(Map<String, dynamic> map) {
    return UniversityModel(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniversityModel.fromJson(String source) =>
      UniversityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
