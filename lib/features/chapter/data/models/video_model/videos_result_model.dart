import 'package:e_learning/features/chapter/data/models/video_model/video_model.dart';

class VideosResultModel {
  final List<VideoModel>? videos;
  final bool hasNextPage;

  VideosResultModel({this.videos, this.hasNextPage = false});

  VideosResultModel copyWith({List<VideoModel>? videos, bool? hasNextPage}) {
    return VideosResultModel(
      videos: videos ?? this.videos,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  static VideosResultModel empty() =>
      VideosResultModel(videos: [], hasNextPage: false);
}
