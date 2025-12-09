class ChannelModel {
  final int id;
  final String name;
  final String category;
  final String apiLink;
  final String? image;
  final bool isCommunication;

  ChannelModel({
    required this.id,
    required this.name,
    required this.category,
    required this.apiLink,
    this.image,
    required this.isCommunication,
  });

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    final category = map['category'] ?? '';

    return ChannelModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      category: category,
      apiLink: map['api_link'] ?? '',
      image: map['image'],
      isCommunication: category.toLowerCase() == 'communication',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "api_link": apiLink,
      "image": image,
      "isCommunication": isCommunication,
    };
  }
}
