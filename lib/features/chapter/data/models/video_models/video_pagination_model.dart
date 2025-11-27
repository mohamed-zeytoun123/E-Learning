import 'package:e_learning/features/chapter/data/models/video_models/video_model.dart';

class VideoPaginationModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final List<VideoModel> results;

  VideoPaginationModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.results,
  });

  factory VideoPaginationModel.fromMap(Map<String, dynamic> map) {
    final rawResults = map['results'] as List<dynamic>;
    final videos = rawResults
        .map((x) => VideoModel.fromJson(x as Map<String, dynamic>))
        .toList();

    return VideoPaginationModel(
      count: map['count'] ?? 0,
      next: map['next'],
      previous: map['previous'],
      totalPages: map['total_pages'] ?? 0,
      currentPage: map['current_page'] ?? 1,
      results: videos,
    );
  }
}
