class BannerModel {
  final int id;
  final String imageUrl;
  final bool isCurrentlyActive;
  final String createdAt;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.isCurrentlyActive,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      isCurrentlyActive: json['is_currently_active'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'is_currently_active': isCurrentlyActive,
      'created_at': createdAt,
    };
  }
}

