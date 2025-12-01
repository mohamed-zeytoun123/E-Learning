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
    double parseDurationInMinutes(dynamic value) {
      if (value == null) return 0.0;
      double seconds = 0.0;
      if (value is int) {
        seconds = value.toDouble();
      } else if (value is double) {
        seconds = value;
      } else {
        seconds = double.tryParse(value.toString()) ?? 0.0;
      }
      // تحويل الثواني إلى دقائق مع تقريب لرقمين بعد الفاصلة
      return double.parse((seconds / 60).toStringAsFixed(2));
    }

    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
      duration: parseDurationInMinutes(
        json['duration'],
      ).toInt(), // إذا تريد int بالدقائق
      chapter: json['chapter'] ?? 0,
      chapterName: json['chapter_name'] ?? '',
      progressPercentage: json['progress_percentage'] != null
          ? double.tryParse(json['progress_percentage'].toString())
          : null,
      uploadedAt: json['uploaded_at'] ?? '',
    );
  }
}
