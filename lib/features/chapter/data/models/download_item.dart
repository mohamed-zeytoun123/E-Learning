import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_item.g.dart';

@JsonSerializable()
class DownloadItem {
  @JsonKey(name: 'video_id')
  @StringConverter()
  final String videoId;
  
  @JsonKey(name: 'file_name')
  @StringConverter()
  final String fileName;
  
  @DoubleConverter()
  final double progress; // من 0 إلى 1.0
  
  @JsonKey(name: 'is_downloading')
  @BoolConverter()
  final bool isDownloading;
  
  @JsonKey(name: 'is_completed')
  @BoolConverter()
  final bool isCompleted;
  
  @JsonKey(name: 'has_error')
  @BoolConverter()
  final bool hasError;

  DownloadItem({
    required this.videoId,
    required this.fileName,
    this.progress = 0.0,
    this.isDownloading = false,
    this.isCompleted = false,
    this.hasError = false,
  });

  factory DownloadItem.fromJson(Map<String, dynamic> json) =>
      _$DownloadItemFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadItemToJson(this);

  DownloadItem copyWith({
    String? videoId,
    String? fileName,
    double? progress,
    bool? isDownloading,
    bool? isCompleted,
    bool? hasError,
  }) {
    return DownloadItem(
      videoId: videoId ?? this.videoId,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      isDownloading: isDownloading ?? this.isDownloading,
      isCompleted: isCompleted ?? this.isCompleted,
      hasError: hasError ?? this.hasError,
    );
  }
}

