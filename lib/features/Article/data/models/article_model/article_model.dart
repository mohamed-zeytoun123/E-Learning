class ArticleModel {
  final int id;
  final String title;
  final String slug;
  final String? content;
  final String summary;
  final String status;
  final int author;
  final String authorName;
  final int category;
  final String categoryName;
  final String readingTime;
  final String? metaDescription;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.slug,
    this.content,
    required this.summary,
    required this.status,
    required this.author,
    required this.authorName,
    required this.category,
    required this.categoryName,
    required this.readingTime,
    this.metaDescription,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt,
  });

  ArticleModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? content,
    String? summary,
    String? status,
    int? author,
    String? authorName,
    int? category,
    String? categoryName,
    String? readingTime,
    String? metaDescription,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      category: category ?? this.category,
      categoryName: categoryName ?? this.categoryName,
      readingTime: readingTime ?? this.readingTime,
      metaDescription: metaDescription ?? this.metaDescription,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      content: map['content'] as String?,
      summary: map['summary'] ?? '',
      status: map['status'] ?? '',
      author: map['author'] ?? 0,
      authorName: map['author_name'] ?? '',
      category: map['category'] ?? 0,
      categoryName: map['category_name'] ?? '',
      readingTime: map['reading_time'] ?? '',
      metaDescription: map['meta_description'] as String?,
      image: map['image'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'content': content,
      'summary': summary,
      'status': status,
      'author': author,
      'author_name': authorName,
      'category': category,
      'category_name': categoryName,
      'reading_time': readingTime,
      'meta_description': metaDescription,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'published_at': publishedAt?.toIso8601String(),
    };
  }
}
