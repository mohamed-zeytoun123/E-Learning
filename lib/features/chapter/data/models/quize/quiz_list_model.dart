import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';

class QuizListModel {
  final List<QuizDetailsModel> quizzes;
  final int count;

  QuizListModel({
    required this.quizzes,
    required this.count,
  });

  factory QuizListModel.fromJson(Map<String, dynamic> json) {
    final List<QuizDetailsModel> quizzesList = [];
    
    if (json['quizzes'] is List) {
      for (var item in json['quizzes']) {
        if (item is Map<String, dynamic>) {
          quizzesList.add(QuizDetailsModel.fromJson(item));
        }
      }
    }

    return QuizListModel(
      quizzes: quizzesList,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizzes': quizzes.map((quiz) => quiz.toJson()).toList(),
      'count': count,
    };
  }
}