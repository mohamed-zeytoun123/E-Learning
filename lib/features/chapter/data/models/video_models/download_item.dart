class DownloadItem {
  final String videoId;
  final String fileName;
  final double progress;
  final bool isDownloading;
  final bool isCompleted;
  final bool hasError;
  final String? errorMessage; // <--- جديد
  final String? downloadDate; // <--- إضافة تاريخ التحميل

  DownloadItem({
    required this.videoId,
    required this.fileName,
    this.progress = 0.0,
    this.isDownloading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.errorMessage,
    this.downloadDate, // <--- إضافة تاريخ التحميل
  });

  DownloadItem copyWith({
    String? videoId,
    String? fileName,
    double? progress,
    bool? isDownloading,
    bool? isCompleted,
    bool? hasError,
    String? errorMessage, // <--- جديد
    String? downloadDate, // <--- إضافة تاريخ التحميل
  }) {
    return DownloadItem(
      videoId: videoId ?? this.videoId,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      isDownloading: isDownloading ?? this.isDownloading,
      isCompleted: isCompleted ?? this.isCompleted,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadDate: downloadDate ?? this.downloadDate, // <--- إضافة تاريخ التحميل
    );
  }
}