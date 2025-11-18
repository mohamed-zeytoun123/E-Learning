import 'package:e_learning/features/chapter/data/models/quize/choice_model.dart';

class QuestionModel {
  final int id;
  final String questionType;
  final String questionText;
  final int points;
  final int order;
  final String? image;
  final List<ChoiceModel> choices;

  QuestionModel({
    required this.id,
    required this.questionType,
    required this.questionText,
    required this.points,
    required this.order,
    required this.image,
    required this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      questionType: json['question_type'] ?? "",
      questionText: json['question_text'] ?? "",
      points: json['points'] ?? 0,
      order: json['order'] ?? 0,
      image: json['image'],
      choices: json['choices'] != null
          ? List<ChoiceModel>.from(
              json['choices'].map((e) => ChoiceModel.fromJson(e)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_type": questionType,
    "question_text": questionText,
    "points": points,
    "order": order,
    "image": image,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
  };
}
