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
    // Handle name field - it might be a String or a Map (translations)
    String name = '';
    if (map['name'] != null) {
      if (map['name'] is String) {
        name = map['name'] as String;
      } else if (map['name'] is Map<String, dynamic>) {
        // If it's a Map, try to get the current locale or use the first value
        final nameMap = map['name'] as Map<String, dynamic>;
        name = nameMap.values.first.toString();
      }
    }
    
    // Handle slug field - it might be a String or a Map (translations)
    String slug = '';
    if (map['slug'] != null) {
      if (map['slug'] is String) {
        slug = map['slug'] as String;
      } else if (map['slug'] is Map<String, dynamic>) {
        final slugMap = map['slug'] as Map<String, dynamic>;
        slug = slugMap.values.first.toString();
      }
    }
    
    return CategorieModel(
      id: map['id'] is int ? map['id'] as int : (map['id'] is String ? int.tryParse(map['id'] as String) ?? 0 : 0),
      name: name,
      slug: slug,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'slug': slug};
  }

  factory CategorieModel.fromJson(String source) =>
      CategorieModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
