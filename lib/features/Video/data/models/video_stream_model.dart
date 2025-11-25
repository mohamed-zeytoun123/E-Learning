import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_stream_model.g.dart';

@JsonSerializable()
class VideoStreamModel {
  @JsonKey(name: 'secure_streaming_url')
  @StringConverter()
  final String secureStreamingUrl;

  VideoStreamModel({required this.secureStreamingUrl});

  factory VideoStreamModel.fromJson(Map<String, dynamic> json) =>
      _$VideoStreamModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoStreamModelToJson(this);
}
