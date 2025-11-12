import 'package:hive/hive.dart';
part 'university_model.g.dart';

@HiveType(typeId: 4) 
class UniversityModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String slug;

  UniversityModel({required this.id, required this.name, required this.slug});

  UniversityModel copyWith({int? id, String? name, String? slug}) =>
      UniversityModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory UniversityModel.fromMap(Map<String, dynamic> map) {
    return UniversityModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'slug': slug};
  }
}
