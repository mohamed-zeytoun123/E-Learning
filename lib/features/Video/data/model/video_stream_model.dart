class VideoStreamModel {
  final String secureStreamingUrl;

  VideoStreamModel({required this.secureStreamingUrl});

  factory VideoStreamModel.fromJson(Map<String, dynamic> json) {
    return VideoStreamModel(
      secureStreamingUrl: json['secure_streaming_url'] ?? "",
    );
  }
}
