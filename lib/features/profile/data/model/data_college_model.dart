// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataResonseCollege {
    final int count;
    final dynamic next;
    final dynamic previous;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<college> results;

    DataResonseCollege({
        required this.count,
        required this.next,
        required this.previous,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    DataResonseCollege copyWith({
        int? count,
        dynamic next,
        dynamic previous,
        int? totalPages,
        int? currentPage,
        int? pageSize,
        List<college>? results,
    }) => 
        DataResonseCollege(
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

  factory DataResonseCollege.fromMap(Map<String, dynamic> map) {
    return DataResonseCollege(
      count: map['count'] as int,
      next: map['next'] as dynamic,
      previous: map['previous'] as dynamic,
      totalPages: map['total_pages'] as int,
      currentPage: map['current_page'] as int,
      pageSize: map['page_size'] as int,
      results: List<college>.from((map['results'] as List<dynamic>).map<college>((x) => college.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResonseCollege.fromJson(String source) => DataResonseCollege.fromMap(json.decode(source) as Map<String, dynamic>);
}

class college {
    final int id;
    final String name;
    final String slug;
    final int university;
    final String universityName;

    college({
        required this.id,
        required this.name,
        required this.slug,
        required this.university,
        required this.universityName,
    });

    college copyWith({
        int? id,
        String? name,
        String? slug,
        int? university,
        String? universityName,
    }) => 
        college(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            university: university ?? this.university,
            universityName: universityName ?? this.universityName,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'university': university,
      'university_name': universityName,
    };
  }

  factory college.fromMap(Map<String, dynamic> map) {
    return college(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      university: map['university'] as int,
      universityName: map['university_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory college.fromJson(String source) => college.fromMap(json.decode(source) as Map<String, dynamic>);
}



// {
//     "count": 2,
//     "next": null,
//     "previous": null,
//     "total_pages": 1,
//     "current_page": 1,
//     "page_size": 10,
//     "results": [
//         {
//             "id": 2,
//             "name": "first",
//             "slug": "first",
//             "university": 3,
//             "university_name": "IUST"
//         },
//         {
//             "id": 1,
//             "name": "ghassanaj",
//             "slug": "ghassanaj",
//             "university": 3,
//             "university_name": "IUST"
//         }
//     ]
// }