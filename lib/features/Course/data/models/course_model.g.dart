// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseModelAdapter extends TypeAdapter<CourseModel> {
  @override
  final int typeId = 2;

  @override
  CourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseModel(
      id: fields[0] as int,
      title: fields[1] as String,
      slug: fields[2] as String,
      image: fields[3] as String?,
      college: fields[4] as int,
      collegeName: fields[5] as String,
      price: fields[6] as String,
      averageRating: fields[7] as double?,
      totalVideoDurationHours: fields[8] as double,
      isFavorite: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CourseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.college)
      ..writeByte(5)
      ..write(obj.collegeName)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.averageRating)
      ..writeByte(8)
      ..write(obj.totalVideoDurationHours)
      ..writeByte(9)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map json) => CourseModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      slug: const StringConverter().fromJson(json['slug']),
      image: const NullableStringConverter().fromJson(json['image']),
      college: const IntConverter().fromJson(json['college']),
      collegeName: const StringConverter().fromJson(json['college_name']),
      price: const StringConverter().fromJson(json['price']),
      averageRating:
          const NullableDoubleConverter().fromJson(json['average_rating']),
      totalVideoDurationHours:
          const DoubleConverter().fromJson(json['total_video_duration_hours']),
      isFavorite: const BoolConverter().fromJson(json['is_favorite']),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'slug': const StringConverter().toJson(instance.slug),
      'image': const NullableStringConverter().toJson(instance.image),
      'college': const IntConverter().toJson(instance.college),
      'college_name': const StringConverter().toJson(instance.collegeName),
      'price': const StringConverter().toJson(instance.price),
      'average_rating':
          const NullableDoubleConverter().toJson(instance.averageRating),
      'total_video_duration_hours':
          const DoubleConverter().toJson(instance.totalVideoDurationHours),
      'is_favorite': const BoolConverter().toJson(instance.isFavorite),
    };
