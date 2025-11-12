import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';

class PaginatedChaptersModel {
  final int count;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<ChapterModel> results;

  PaginatedChaptersModel({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PaginatedChaptersModel.fromMap(Map<String, dynamic> map) {
    return PaginatedChaptersModel(
      count: map['count'] ?? 0,
      totalPages: map['total_pages'] ?? 1,
      currentPage: map['current_page'] ?? 1,
      pageSize: map['page_size'] ?? 10,
      results: map['results'] != null
          ? List<ChapterModel>.from(
              map['results'].map((x) => ChapterModel.fromMap(x)),
            )
          : [],
    );
  }
}
