class AttachmentModel {
  final int id;
  final String fileName;
  final String extension;
  final String fileSizeMb;
  final String? description;
  final String? tag;
  final String uploadedAt;
  final String encryptedDownloadUrl;

  AttachmentModel({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.fileSizeMb,
    required this.description,
    required this.tag,
    required this.uploadedAt,
    required this.encryptedDownloadUrl,
  });

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id'],
      fileName: map['file_name'],
      extension: map['extension'],
      fileSizeMb: map['file_size_mb'],
      description: map['description'],
      tag: map['tag'],
      uploadedAt: map['uploaded_at'],
      encryptedDownloadUrl: map['encrypted_download_url'],
    );
  }
}
