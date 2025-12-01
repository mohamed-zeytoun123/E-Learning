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
    items.add({
      'videoId': videoId, 
      'fileName': fileName,
      'downloadDate': DateTime.now().toIso8601String(), // <-- Save download date
    });
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
                'downloadDate': e['downloadDate']?.toString() ?? '', // <-- Retrieve download date
              })
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> deleteCachedVideo(String videoId) async {
    // Delete the video file
    final videoFile = File(await getVideoPath(videoId));
    if (await videoFile.exists()) {
      await videoFile.delete();
    }

    // Remove the video metadata from the index
    final metaFile = await _getMetaFile();
    if (!await metaFile.exists()) return;
    
    try {
      final content = await metaFile.readAsString();
      final data = json.decode(content) as List<dynamic>;
      final updatedData = data
          .where((e) => e is Map && e['videoId'] != videoId)
          .toList();
      
      if (updatedData.isEmpty) {
        // If no videos left, delete the meta file
        await metaFile.delete();
      } else {
        // Otherwise, write the updated data back
        await metaFile.writeAsString(json.encode(updatedData), flush: true);
      }
    } catch (_) {
      // If there's an error reading/parsing, just delete the meta file
      if (await metaFile.exists()) {
        await metaFile.delete();
      }
    }
  }

  //?--------------------------------------------------------
}
