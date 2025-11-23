class AdvertisementModel {
  final int id;
  final String imageUrl;
  final bool isCurrentlyActive;
  final DateTime createdAt;

  AdvertisementModel({
    required this.id,
    required this.imageUrl,
    required this.isCurrentlyActive,
    required this.createdAt,
  });

  AdvertisementModel copyWith({
    int? id,
    String? imageUrl,
    bool? isCurrentlyActive,
    DateTime? createdAt,
  }) {
    return AdvertisementModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isCurrentlyActive: isCurrentlyActive ?? this.isCurrentlyActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AdvertisementModel.fromMap(Map<String, dynamic> map) {
    return AdvertisementModel(
      id: map['id'] ?? 0,
      imageUrl: map['image_url'] ?? '',
      isCurrentlyActive: map['is_currently_active'] ?? false,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_url': imageUrl,
      'is_currently_active': isCurrentlyActive,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

