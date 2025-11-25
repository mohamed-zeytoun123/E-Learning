// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementModel _$AdvertisementModelFromJson(Map json) => AdvertisementModel(
      id: const IntConverter().fromJson(json['id']),
      imageUrl: const StringConverter().fromJson(json['image_url']),
      isCurrentlyActive:
          const BoolConverter().fromJson(json['is_currently_active']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
    );

Map<String, dynamic> _$AdvertisementModelToJson(AdvertisementModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'image_url': const StringConverter().toJson(instance.imageUrl),
      'is_currently_active':
          const BoolConverter().toJson(instance.isCurrentlyActive),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
