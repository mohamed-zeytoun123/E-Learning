// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UniversityModelAdapter extends TypeAdapter<UniversityModel> {
  @override
  final int typeId = 4;

  @override
  UniversityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UniversityModel(
      id: fields[0] as int,
      name: fields[1] as String,
      slug: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UniversityModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniversityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityModel _$UniversityModelFromJson(Map json) => UniversityModel(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
      slug: const StringConverter().fromJson(json['slug']),
    );

Map<String, dynamic> _$UniversityModelToJson(UniversityModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
      'slug': const StringConverter().toJson(instance.slug),
    };
