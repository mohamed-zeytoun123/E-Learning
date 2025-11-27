// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:network/network/api/media_option.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? body;
  final MediaOption? media;

  final bool allowCancellation;

  ApiRequest({
    required this.url,
    this.body,
    this.media,
    this.params,
    this.headers,
    this.allowCancellation = true,
  });

  Future<Map<String, dynamic>> toMultiPart() async {
    if (media == null) {
      return {};
    }
    final Map<String, dynamic> requestedMap = {
      ...params ?? {},
    };
    for (int i = 0; i < media!.files.length; i++) {
      final file = await MultipartFile.fromFile(
        media!.files[i].path,
      );
      requestedMap.addAll({media!.keys[i]: file});
    }

    return requestedMap;
  }
}
