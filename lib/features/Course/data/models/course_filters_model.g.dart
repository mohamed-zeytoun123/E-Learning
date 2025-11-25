// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_filters_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseFiltersModelAdapter extends TypeAdapter<CourseFiltersModel> {
  @override
  final int typeId = 6;

  @override
  CourseFiltersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseFiltersModel(
      collegeId: fields[0] as int?,
      studyYear: fields[1] as int?,
      categoryId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CourseFiltersModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.collegeId)
      ..writeByte(1)
      ..write(obj.studyYear)
      ..writeByte(2)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseFiltersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseFiltersModel _$CourseFiltersModelFromJson(Map json) => CourseFiltersModel(
      collegeId: const IntConverter().fromJson(json['college_id']),
      studyYear: const IntConverter().fromJson(json['study_year']),
      categoryId: const IntConverter().fromJson(json['category_id']),
    );

Map<String, dynamic> _$CourseFiltersModelToJson(CourseFiltersModel instance) =>
    <String, dynamic>{
      'college_id': _$JsonConverterToJson<dynamic, int>(
          instance.collegeId, const IntConverter().toJson),
      'study_year': _$JsonConverterToJson<dynamic, int>(
          instance.studyYear, const IntConverter().toJson),
      'category_id': _$JsonConverterToJson<dynamic, int>(
          instance.categoryId, const IntConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
