// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataResonseunivarsity {
    final int count;
    final dynamic next;
    final dynamic previous;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<uniData> results;

    DataResonseunivarsity({
        required this.count,
        required this.next,
        required this.previous,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    DataResonseunivarsity copyWith({
        int? count,
        dynamic next,
        dynamic previous,
        int? totalPages,
        int? currentPage,
        int? pageSize,
        List<uniData>? results,
    }) => 
        DataResonseunivarsity(
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
      'pageSize': pageSize,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory DataResonseunivarsity.fromMap(Map<String, dynamic> map) {
    return DataResonseunivarsity(
      count: map['count'] as int,
      next: map['next'] as dynamic,
      previous: map['previous'] as dynamic,
      totalPages: map['total_pages'] as int,
      currentPage: map['current_page'] as int,
      pageSize: map['page_size'] as int,
      results: List<uniData>.from((map['results'] as List<dynamic>).map<uniData>((x) => uniData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResonseunivarsity.fromJson(String source) => DataResonseunivarsity.fromMap(json.decode(source) as Map<String, dynamic>);
}

class uniData {
    final int id;
    final String name;
    final String slug;

    uniData({
        required this.id,
        required this.name,
        required this.slug,
    });

    uniData copyWith({
        int? id,
        String? name,
        String? slug,
    }) => 
        uniData(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory uniData.fromMap(Map<String, dynamic> map) {
    return uniData(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory uniData.fromJson(String source) => uniData.fromMap(json.decode(source) as Map<String, dynamic>);
}


