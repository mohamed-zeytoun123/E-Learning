// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataCourseSaved {
    final int id;
    final String title;
    final String slug;
    final dynamic image;
    final int college;
    final String collegeName;
    final String price;
    final dynamic averageRating;
    final double totalVideoDurationHours;
    final bool isFavorite;

    DataCourseSaved({
        required this.id,
        required this.title,
        required this.slug,
        required this.image,
        required this.college,
        required this.collegeName,
        required this.price,
        required this.averageRating,
        required this.totalVideoDurationHours,
        required this.isFavorite,
    });

    DataCourseSaved copyWith({
        int? id,
        String? title,
        String? slug,
        dynamic image,
        int? college,
        String? collegeName,
        String? price,
        dynamic averageRating,
        double? totalVideoDurationHours,
        bool? isFavorite,
    }) => 
        DataCourseSaved(
            id: id ?? this.id,
            title: title ?? this.title,
            slug: slug ?? this.slug,
            image: image ?? this.image,
            college: college ?? this.college,
            collegeName: collegeName ?? this.collegeName,
            price: price ?? this.price,
            averageRating: averageRating ?? this.averageRating,
            totalVideoDurationHours: totalVideoDurationHours ?? this.totalVideoDurationHours,
            isFavorite: isFavorite ?? this.isFavorite,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'slug': slug,
      'image': image,
      'college': college,
      'college_name': collegeName,
      'price': price,
      'average_rating': averageRating,
      'total_video_duration_hours': totalVideoDurationHours,
      'is_favorite': isFavorite,
    };
  }

  factory DataCourseSaved.fromMap(Map<String, dynamic> map) {
    return DataCourseSaved(
      id: map['id'] as int,
      title: map['title'] as String,
      slug: map['slug'] as String,
      image: map['image'] as dynamic,
      college: map['college'] as int,
      collegeName: map['college_name'] as String,
      price: map['price'] as String,
      averageRating: map['average_rating'] as dynamic,
      totalVideoDurationHours: map['total_video_duration_hours'] as double,
      isFavorite: map['is_favorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataCourseSaved.fromJson(String source) => DataCourseSaved.fromMap(json.decode(source) as Map<String, dynamic>);
}


class DataResponseSaveCoursesPagination {
    final int count;
    final dynamic next;
    final dynamic previous;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<DataCourseSaved> data;

    DataResponseSaveCoursesPagination({
        required this.count,
        required this.next,
        required this.previous,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.data,
    });

    DataResponseSaveCoursesPagination copyWith({
        int? count,
        dynamic next,
        dynamic previous,
        int? totalPages,
        int? currentPage,
        int? pageSize,
        List<DataCourseSaved>? data,
    }) => 
        DataResponseSaveCoursesPagination(
            count: count ?? this.count,
            next: next ?? this.next,
            previous: previous ?? this.previous,
            totalPages: totalPages ?? this.totalPages,
            currentPage: currentPage ?? this.currentPage,
            pageSize: pageSize ?? this.pageSize,
            data: data ?? this.data,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'pageSize': pageSize,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory DataResponseSaveCoursesPagination.fromMap(Map<String, dynamic> map) {
    return DataResponseSaveCoursesPagination(
      count: map['count'] as int,
      next: map['next'] as dynamic,
      previous: map['previous'] as dynamic,
      totalPages: map['total_pages'] as int,
      currentPage: map['current_page'] as int,
      pageSize: map['page_size'] as int,
      data: List<DataCourseSaved>.from((map['results'] as List<dynamic>).map<DataCourseSaved>((x) => DataCourseSaved.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResponseSaveCoursesPagination.fromJson(String source) => DataResponseSaveCoursesPagination.fromMap(json.decode(source) as Map<String, dynamic>);
}
