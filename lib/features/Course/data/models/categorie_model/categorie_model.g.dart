// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorieModelAdapter extends TypeAdapter<CategorieModel> {
  @override
  final int typeId = 1;

  @override
  CategorieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategorieModel(
      id: fields[0] as int,
      name: fields[1] as String,
      slug: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategorieModel obj) {
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
      other is CategorieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
