import 'package:e_learning/features/Course/data/models/rating_result/rating_model.dart';

class RatingsResultModel {
  final List<RatingModel>? ratings;
  final bool hasNextPage;

  RatingsResultModel({this.ratings, this.hasNextPage = false});

  RatingsResultModel copyWith({List<RatingModel>? ratings, bool? hasNextPage}) {
    return RatingsResultModel(
      ratings: ratings ?? this.ratings,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  static RatingsResultModel empty() => RatingsResultModel(ratings: [], hasNextPage: false);
}
