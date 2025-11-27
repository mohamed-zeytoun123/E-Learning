import 'dart:convert';
import 'package:hive/hive.dart';
part 'categorie_model.g.dart';

@HiveType(typeId: 1)
class CategorieModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String slug;

  CategorieModel({required this.id, required this.name, required this.slug});

  CategorieModel copyWith({int? id, String? name, String? slug}) {
    return CategorieModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  factory CategorieModel.fromMap(Map<String, dynamic> map) {
    return CategorieModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'slug': slug};
  }

  factory CategorieModel.fromJson(String source) =>
      CategorieModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
