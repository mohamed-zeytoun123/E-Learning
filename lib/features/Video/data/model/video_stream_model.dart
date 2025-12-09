class VideoStreamModel {
  final String secureStreamingUrl; // رابط الـ AUTO أو الافتراضي
  Map<String, String>? qualities; // غيرناها من final إلى mutable

  VideoStreamModel({required this.secureStreamingUrl, this.qualities});

  factory VideoStreamModel.fromJson(Map<String, dynamic> json) {
    final masterUrl = json['secure_streaming_url'] ?? "";

    Map<String, String>? qualities;
    if (json['qualities'] != null) {
      qualities = Map<String, String>.from(json['qualities']);
    }

    return VideoStreamModel(
      secureStreamingUrl: masterUrl,
      qualities: qualities,
    );
  }
}
