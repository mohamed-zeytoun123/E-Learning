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
      universityId: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CourseFiltersModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.collegeId)
      ..writeByte(1)
      ..write(obj.studyYear)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.universityId);
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
