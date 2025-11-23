import 'dart:io';
import 'dart:convert';

import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
import 'package:path_provider/path_provider.dart';

class ChapterLocalDataSourceImpl implements ChapterLocalDataSource {
  final HiveService hive;

  ChapterLocalDataSourceImpl({required this.hive});
  //?--------------------------------------------------------

  @override
  Future<bool> isVideoCached(String videoId) async {
    final file = File(await getVideoPath(videoId));
    return file.exists();
  }

  @override
  Future<void> cacheEncryptedVideo({
    required String videoId,
    required List<int> encryptedBytes,
  }) async {
    final path = await getVideoPath(videoId);
    final file = File(path);
    await file.writeAsBytes(encryptedBytes, flush: true);
  }

  @override
  Future<List<int>> getEncryptedVideo(String videoId) async {
    final path = await getVideoPath(videoId);
    final file = File(path);
    return file.readAsBytes();
  }

  @override
  Future<String> getVideoPath(String videoId) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/video_$videoId.enc";
  }

  Future<File> _getMetaFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/cached_videos_index.json");
  }

  @override
  Future<void> saveCachedVideoMeta({
    required String videoId,
    required String fileName,
  }) async {
    final metaFile = await _getMetaFile();
    List<dynamic> items = [];
    if (await metaFile.exists()) {
      try {
        final content = await metaFile.readAsString();
        items = (json.decode(content) as List<dynamic>);
      } catch (_) {
        items = [];
      }
    }
    // remove duplicates
    items = items.where((e) => e is Map && e['videoId'] != videoId).toList();
    items.add({'videoId': videoId, 'fileName': fileName});
    await metaFile.writeAsString(json.encode(items), flush: true);
  }

  @override
  Future<List<Map<String, String>>> getAllCachedVideosMeta() async {
    final metaFile = await _getMetaFile();
    if (!await metaFile.exists()) return [];
    try {
      final content = await metaFile.readAsString();
      final data = json.decode(content) as List<dynamic>;
      return data
          .whereType<Map>()
          .map((e) => {
                'videoId': e['videoId']?.toString() ?? '',
                'fileName': e['fileName']?.toString() ?? '',
              })
          .toList();
    } catch (_) {
      return [];
    }
  }

  //?--------------------------------------------------------
}
