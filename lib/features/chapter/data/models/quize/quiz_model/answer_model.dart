class AnswerModel {
  final String? message;
  final int? answerId;
  final int? questionId;
  final bool? created;

  AnswerModel({this.message, this.answerId, this.questionId, this.created});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      message: json['message']?.toString(),
      answerId: json['answer_id'] != null
          ? int.tryParse(json['answer_id'].toString())
          : null,
      questionId: json['question_id'] != null
          ? int.tryParse(json['question_id'].toString())
          : null,
      created: json['created'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'answer_id': answerId,
      'question_id': questionId,
      'created': created,
    };
  }
}
