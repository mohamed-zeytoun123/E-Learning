// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_year_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyYearModelAdapter extends TypeAdapter<StudyYearModel> {
  @override
  final int typeId = 5;

  @override
  StudyYearModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyYearModel(
      id: fields[0] as int,
      yearNumber: fields[1] as int,
      name: fields[2] as String,
      description: fields[3] as String,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StudyYearModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.yearNumber)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyYearModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudyYearResponseAdapter extends TypeAdapter<StudyYearResponse> {
  @override
  final int typeId = 1;

  @override
  StudyYearResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyYearResponse(
      count: fields[0] as int,
      currentPage: fields[1] as int,
      pageSize: fields[2] as int,
      results: (fields[3] as List).cast<StudyYearModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudyYearResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.currentPage)
      ..writeByte(2)
      ..write(obj.pageSize)
      ..writeByte(3)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyYearResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyYearModel _$StudyYearModelFromJson(Map json) => StudyYearModel(
      id: const IntConverter().fromJson(json['id']),
      yearNumber: const IntConverter().fromJson(json['year_number']),
      name: const StringConverter().fromJson(json['name']),
      description: const StringConverter().fromJson(json['description']),
      isActive: const BoolConverter().fromJson(json['is_active']),
    );

Map<String, dynamic> _$StudyYearModelToJson(StudyYearModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'year_number': const IntConverter().toJson(instance.yearNumber),
      'name': const StringConverter().toJson(instance.name),
      'description': const StringConverter().toJson(instance.description),
      'is_active': const BoolConverter().toJson(instance.isActive),
    };

StudyYearResponse _$StudyYearResponseFromJson(Map json) => StudyYearResponse(
      count: const IntConverter().fromJson(json['count']),
      currentPage: const IntConverter().fromJson(json['current_page']),
      pageSize: const IntConverter().fromJson(json['page_size']),
      results: (json['results'] as List<dynamic>)
          .map((e) =>
              StudyYearModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$StudyYearResponseToJson(StudyYearResponse instance) =>
    <String, dynamic>{
      'count': const IntConverter().toJson(instance.count),
      'current_page': const IntConverter().toJson(instance.currentPage),
      'page_size': const IntConverter().toJson(instance.pageSize),
      'results': instance.results,
    };
