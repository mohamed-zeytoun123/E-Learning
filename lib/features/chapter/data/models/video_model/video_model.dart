class VideoModel {
  final int id;
  final String title;
  final int duration;
  final String format;
  final String uploadedAt;
  final int chapter;
  final String storageType;
  final String? videoFile;
  final String videoGuid;
  final String bunnyVideoUrl;
  final String description;
  final int order;
  final double? progress;

  VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.format,
    required this.uploadedAt,
    required this.chapter,
    required this.storageType,
    this.videoFile,
    required this.videoGuid,
    required this.bunnyVideoUrl,
    required this.description,
    required this.order,
    this.progress,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      duration: json['duration'] ?? 0,
      format: json['format'] ?? '',
      uploadedAt: json['uploaded_at'] ?? '',
      chapter: json['chapter'] ?? 0,
      storageType: json['storage_type'] ?? '',
      videoFile: json['video_file'],
      videoGuid: json['video_guid'] ?? '',
      bunnyVideoUrl: json['bunny_video_url'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
      progress: json['progress'] != null
          ? double.tryParse(json['progress'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'format': format,
      'uploaded_at': uploadedAt,
      'chapter': chapter,
      'storage_type': storageType,
      'video_file': videoFile,
      'video_guid': videoGuid,
      'bunny_video_url': bunnyVideoUrl,
      'description': description,
      'order': order,
      'progress': progress,
    };
  }
}
