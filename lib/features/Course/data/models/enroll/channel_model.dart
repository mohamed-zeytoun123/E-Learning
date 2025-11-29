class ChannelModel {
  final int id;
  final String name;
  final String apiLink;
  final bool isCommunication;

  ChannelModel({
    required this.id,
    required this.name,
    required this.apiLink,
    required this.isCommunication,
  });

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    final category = map['category'] ?? '';
    return ChannelModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      apiLink: map['api_link'] ?? '',
      isCommunication: category.toLowerCase() == 'communication',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "api_link": apiLink,
      "isCommunication": isCommunication,
    };
  }
}
