class AttachmentDownloadState {
  final int attachmentId;
  final bool isDownloading;
  final double progress; // 0.0 to 1.0
  final bool isDownloaded;
  final String? localPath;

  AttachmentDownloadState({
    required this.attachmentId,
    this.isDownloading = false,
    this.progress = 0.0,
    this.isDownloaded = false,
    this.localPath,
  });

  AttachmentDownloadState copyWith({
    int? attachmentId,
    bool? isDownloading,
    double? progress,
    bool? isDownloaded,
    String? localPath,
  }) {
    return AttachmentDownloadState(
      attachmentId: attachmentId ?? this.attachmentId,
      isDownloading: isDownloading ?? this.isDownloading,
      progress: progress ?? this.progress,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      localPath: localPath ?? this.localPath,
    );
  }
}
