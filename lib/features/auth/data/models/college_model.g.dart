// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollegeModelAdapter extends TypeAdapter<CollegeModel> {
  @override
  final int typeId = 3;

  @override
  CollegeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollegeModel(
      id: fields[0] as int,
      name: fields[1] as String,
      slug: fields[2] as String,
      university: fields[3] as int,
      universityName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CollegeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.university)
      ..writeByte(4)
      ..write(obj.universityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollegeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeModel _$CollegeModelFromJson(Map json) => CollegeModel(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
      slug: const StringConverter().fromJson(json['slug']),
      university: const IntConverter().fromJson(json['university']),
      universityName: const StringConverter().fromJson(json['university_name']),
    );

Map<String, dynamic> _$CollegeModelToJson(CollegeModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
      'slug': const StringConverter().toJson(instance.slug),
      'university': const IntConverter().toJson(instance.university),
      'university_name':
          const StringConverter().toJson(instance.universityName),
    };
