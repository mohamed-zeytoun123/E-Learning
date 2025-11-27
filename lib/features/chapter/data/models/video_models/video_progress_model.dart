class VideoProgressModel {
  final int id;
  final int watchedSeconds;
  final String progressPercentage;
  final bool isCompleted;
  final DateTime lastWatched;

  VideoProgressModel({
    required this.id,
    required this.watchedSeconds,
    required this.progressPercentage,
    required this.isCompleted,
    required this.lastWatched,
  });

  factory VideoProgressModel.fromJson(Map<String, dynamic> json) {
    return VideoProgressModel(
      id: json['id'] as int,
      watchedSeconds: json['watched_seconds'] as int,
      progressPercentage: json['progress_percentage'] as String,
      isCompleted: json['is_completed'] as bool,
      lastWatched: DateTime.parse(json['last_watched'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'watched_seconds': watchedSeconds,
      'progress_percentage': progressPercentage,
      'is_completed': isCompleted,
      'last_watched': lastWatched.toIso8601String(),
    };
  }
}
