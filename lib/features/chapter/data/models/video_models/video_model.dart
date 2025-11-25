class VideoModel {
  final int id;
  final String title;
  final String description;
  final int order;
  final int duration;
  final int chapter;
  final String chapterName;
  final double? progressPercentage;
  final String uploadedAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.duration,
    required this.chapter,
    required this.chapterName,
    required this.progressPercentage,
    required this.uploadedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
      duration: json['duration'] ?? 0,
      chapter: json['chapter'] ?? 0,
      chapterName: json['chapter_name'] ?? '',
      progressPercentage: json['progress_percentage'] != null
          ? double.tryParse(json['progress_percentage'].toString())
          : null,
      uploadedAt: json['uploaded_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'order': order,
      'duration': duration,
      'chapter': chapter,
      'chapter_name': chapterName,
      'progress_percentage': progressPercentage,
      'uploaded_at': uploadedAt,
    };
  }
}
