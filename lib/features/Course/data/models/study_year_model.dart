class StudyYearModel {
  final int id;
  final String name;

  StudyYearModel({required this.id, required this.name});

  StudyYearModel copyWith({int? id, String? name}) =>
      StudyYearModel(id: id ?? this.id, name: name ?? this.name);

  factory StudyYearModel.fromMap(Map<String, dynamic> map) {
    return StudyYearModel(id: map['id'] ?? 0, name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}

