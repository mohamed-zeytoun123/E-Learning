import 'package:e_learning/features/chapter/data/models/quize/quiz_model/choice_model.dart';

class AnswerSubmitModel {
  final int? id;
  final int? question;
  final String? questionText;
  final String? questionType;
  final int? questionPoints;
  final int? selectedChoice;
  final String? selectedChoiceText;
  final bool? isCorrect;
  final String? pointsEarned;
  final ChoiceModel? correctChoice;
  final String? answeredAt;

  AnswerSubmitModel({
    this.id,
    this.question,
    this.questionText,
    this.questionType,
    this.questionPoints,
    this.selectedChoice,
    this.selectedChoiceText,
    this.isCorrect,
    this.pointsEarned,
    this.correctChoice,
    this.answeredAt,
  });

  factory AnswerSubmitModel.fromJson(Map<String, dynamic> json) {
    return AnswerSubmitModel(
      id: json['id'],
      question: json['question'],
      questionText: json['question_text']?.toString(),
      questionType: json['question_type']?.toString(),
      questionPoints: json['question_points'],
      selectedChoice: json['selected_choice'],
      selectedChoiceText: json['selected_choice_text']?.toString(),
      isCorrect: json['is_correct'] as bool?,
      pointsEarned: json['points_earned']?.toString(),
      correctChoice: json['correct_choice'] != null
          ? ChoiceModel.fromJson(json['correct_choice'])
          : null,

      answeredAt: json['answered_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'question_text': questionText,
      'question_type': questionType,
      'question_points': questionPoints,
      'selected_choice': selectedChoice,
      'selected_choice_text': selectedChoiceText,
      'is_correct': isCorrect,
      'points_earned': pointsEarned,
      'correct_choice': correctChoice?.toJson(),
      'answered_at': answeredAt,
    };
  }
}
