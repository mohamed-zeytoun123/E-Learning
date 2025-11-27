import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';

class CommentsResultModel {
  final List<CommentModel>? comments;
  final bool hasNextPage;

  CommentsResultModel({this.comments, this.hasNextPage = false});

  CommentsResultModel copyWith({
    List<CommentModel>? comments,
    bool? hasNextPage,
  }) {
    return CommentsResultModel(
      comments: comments ?? this.comments,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  static CommentsResultModel empty() =>
      CommentsResultModel(comments: [], hasNextPage: false);
}
