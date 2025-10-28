class UniversityDetailModel {
  final int id;
  final String name;

  UniversityDetailModel({required this.id, required this.name});

  //* CopyWith
  UniversityDetailModel copyWith({int? id, String? name}) =>
      UniversityDetailModel(id: id ?? this.id, name: name ?? this.name);

  //* From Map
  factory UniversityDetailModel.fromMap(Map<String, dynamic> map) {
    return UniversityDetailModel(id: map['id'] ?? 0, name: map['name'] ?? '');
  }

  //* To Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
