// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadItem _$DownloadItemFromJson(Map json) => DownloadItem(
      videoId: const StringConverter().fromJson(json['video_id']),
      fileName: const StringConverter().fromJson(json['file_name']),
      progress: json['progress'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['progress']),
      isDownloading: json['is_downloading'] == null
          ? false
          : const BoolConverter().fromJson(json['is_downloading']),
      isCompleted: json['is_completed'] == null
          ? false
          : const BoolConverter().fromJson(json['is_completed']),
      hasError: json['has_error'] == null
          ? false
          : const BoolConverter().fromJson(json['has_error']),
    );

Map<String, dynamic> _$DownloadItemToJson(DownloadItem instance) =>
    <String, dynamic>{
      'video_id': const StringConverter().toJson(instance.videoId),
      'file_name': const StringConverter().toJson(instance.fileName),
      'progress': const DoubleConverter().toJson(instance.progress),
      'is_downloading': const BoolConverter().toJson(instance.isDownloading),
      'is_completed': const BoolConverter().toJson(instance.isCompleted),
      'has_error': const BoolConverter().toJson(instance.hasError),
    };
