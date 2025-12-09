import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';

class ChaptersResultModel {
  final List<ChapterModel> chapters;
  final bool hasNextPage;

  ChaptersResultModel({required this.chapters, required this.hasNextPage});

  ChaptersResultModel copyWith({
    List<ChapterModel>? chapters,
    bool? hasNextPage,
  }) {
    return ChaptersResultModel(
      chapters: chapters ?? this.chapters,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}
