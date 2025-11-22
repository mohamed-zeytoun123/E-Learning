abstract class ChapterLocalDataSource {
  //?--------------------------------------------------------
  Future<bool> isVideoCached(String videoId);

  Future<void> cacheEncryptedVideo({
    required String videoId,
    required List<int> encryptedBytes,
  });

  Future<List<int>> getEncryptedVideo(String videoId);

  Future<String> getVideoPath(String videoId);

  Future<void> saveCachedVideoMeta({
    required String videoId,
    required String fileName,
  });

  Future<List<Map<String, String>>> getAllCachedVideosMeta();
  //?--------------------------------------------------------
}
