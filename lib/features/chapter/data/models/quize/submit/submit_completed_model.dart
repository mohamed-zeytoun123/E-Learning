import 'package:e_learning/features/chapter/data/models/quize/submit/attempt_model.dart';

class SubmitCompletedModel {
  final String? message;
  final AttemptModel? attempt;

  SubmitCompletedModel({this.message, this.attempt});

  factory SubmitCompletedModel.fromJson(Map<String, dynamic> json) {
    return SubmitCompletedModel(
      message: json['message']?.toString(),
      attempt: json['attempt'] != null
          ? AttemptModel.fromJson(json['attempt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'attempt': attempt?.toJson()};
  }
}
