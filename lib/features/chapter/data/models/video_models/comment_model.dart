class CommentModel {
  final int id;
  final int video;
  final int author;
  final String authorName;
  final String authorType;
  final String content;
  final bool isPublic;
  final String createdAt;
  final String updatedAt;
  final int? parent;
  final List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.video,
    required this.author,
    required this.authorName,
    required this.authorType,
    required this.content,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.parent,
    required this.replies,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? 0,
      video: map['video'] ?? 0,
      author: map['author'] ?? 0,
      authorName: map['author_name'] ?? '',
      authorType: map['author_type'] ?? '',
      content: map['content'] ?? '',
      isPublic: map['is_public'] ?? true,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      parent: map['parent'] != null ? map['parent'] as int : null,
      replies:
          (map['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromMap(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'video': video,
      'author': author,
      'author_name': authorName,
      'author_type': authorType,
      'content': content,
      'is_public': isPublic,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'parent': parent,
      'replies': replies.map((e) => e.toMap()).toList(),
    };
  }
}
