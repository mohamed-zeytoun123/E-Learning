class ChoiceModel {
  final int id;
  final String choiceText;
  final int order;

  ChoiceModel({
    required this.id,
    required this.choiceText,
    required this.order,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      id: json['id'] ?? 0,
      choiceText: json['choice_text'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "choice_text": choiceText,
    "order": order,
  };
}
