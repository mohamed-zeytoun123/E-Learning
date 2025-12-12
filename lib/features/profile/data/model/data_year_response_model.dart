// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataResonseYearStudent {
    final int count;
    final dynamic next;
    final dynamic previous;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<yearDataModel> results;

    DataResonseYearStudent({
        required this.count,
        required this.next,
        required this.previous,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    DataResonseYearStudent copyWith({
        int? count,
        dynamic next,
        dynamic previous,
        int? totalPages,
        int? currentPage,
        int? pageSize,
        List<yearDataModel>? results,
    }) => 
        DataResonseYearStudent(
            count: count ?? this.count,
            next: next ?? this.next,
            previous: previous ?? this.previous,
            totalPages: totalPages ?? this.totalPages,
            currentPage: currentPage ?? this.currentPage,
            pageSize: pageSize ?? this.pageSize,
            results: results ?? this.results,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'page_size': pageSize,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory DataResonseYearStudent.fromMap(Map<String, dynamic> map) {
    return DataResonseYearStudent(
      count: map['count'] as int,
      next: map['next'] as dynamic,
      previous: map['previous'] as dynamic,
      totalPages: map['total_pages'] as int,
      currentPage: map['current_page'] as int,
      pageSize: map['page_size'] as int,
      results: List<yearDataModel>.from((map['results'] as List<dynamic>).map<yearDataModel>((x) => yearDataModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResonseYearStudent.fromJson(String source) => DataResonseYearStudent.fromMap(json.decode(source) as Map<String, dynamic>);
}

class yearDataModel {
    final int id;
    final int yearNumber;
    final String name;
    final String description;
    final bool isActive;

    yearDataModel({
        required this.id,
        required this.yearNumber,
        required this.name,
        required this.description,
        required this.isActive,
    });

    yearDataModel copyWith({
        int? id,
        int? yearNumber,
        String? name,
        String? description,
        bool? isActive,
    }) => 
        yearDataModel(
            id: id ?? this.id,
            yearNumber: yearNumber ?? this.yearNumber,
            name: name ?? this.name,
            description: description ?? this.description,
            isActive: isActive ?? this.isActive,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year_number': yearNumber,
      'name': name,
      'description': description,
      'is_active': isActive,
    };
  }

  factory yearDataModel.fromMap(Map<String, dynamic> map) {
    return yearDataModel(
      id: map['id'] as int,
      yearNumber: map['year_number'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isActive: map['is_active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory yearDataModel.fromJson(String source) => yearDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
