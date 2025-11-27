class DownloadItem {
  final String videoId;
  final String fileName;
  final double progress;
  final bool isDownloading;
  final bool isCompleted;
  final bool hasError;

  DownloadItem({
    required this.videoId,
    required this.fileName,
    this.progress = 0.0,
    this.isDownloading = false,
    this.isCompleted = false,
    this.hasError = false,
  });

  DownloadItem copyWith({
    String? videoId,
    String? fileName,
    double? progress,
    bool? isDownloading,
    bool? isCompleted,
    bool? hasError,
  }) {
    return DownloadItem(
      videoId: videoId ?? this.videoId,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      isDownloading: isDownloading ?? this.isDownloading,
      isCompleted: isCompleted ?? this.isCompleted,
      hasError: hasError ?? this.hasError,
    );
  }
}
