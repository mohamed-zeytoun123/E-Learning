import 'package:equatable/equatable.dart';

class PaginatedList<T> extends Equatable {
  final List<T>? items;
  final PaginationMetaData meta;
  const PaginatedList({
    this.items,
    required this.meta,
  });

  @override
  List<Object?> get props => [items, meta];
}

class PaginationMetaData extends Equatable {
  final int currentPage;
  final int lastPage;
  final int total;
  const PaginationMetaData({
    this.currentPage=0,
    required this.lastPage,
    required this.total,
  });
  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        total,
      ];

      int get nextPage =>  currentPage+1;

  // factory PaginationMetaData.fromJson(String source) =>
  //     PaginationMetaData.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PaginationMetaData.fromJson(Map<dynamic, dynamic> json) {
    return PaginationMetaData(
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      total: json['total'] as int,
    );
  }
}
