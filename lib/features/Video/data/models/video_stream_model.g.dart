// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoStreamModel _$VideoStreamModelFromJson(Map json) => VideoStreamModel(
      secureStreamingUrl:
          const StringConverter().fromJson(json['secure_streaming_url']),
    );

Map<String, dynamic> _$VideoStreamModelToJson(VideoStreamModel instance) =>
    <String, dynamic>{
      'secure_streaming_url':
          const StringConverter().toJson(instance.secureStreamingUrl),
    };
