// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseInfoAppModel {
  final int id;
  final String title;
  final String content;

  ResponseInfoAppModel({
    required this.id,
    required this.title,
    required this.content,
  });

  ResponseInfoAppModel copyWith({
    int? id,
    String? title,
    String? content,

  }) => ResponseInfoAppModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'title': title, 'content': content};
  }

  factory ResponseInfoAppModel.fromMap(Map<String, dynamic> map) {
    return ResponseInfoAppModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseInfoAppModel.fromJson(String source) =>
      ResponseInfoAppModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
