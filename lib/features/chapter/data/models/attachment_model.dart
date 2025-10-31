class AttachmentModel {
  final int id;
  final String fileName;
  final String extension;
  final String fileSizeMb;
  final String? description;
  final String? tag;
  final DateTime uploadedAt;
  final String encryptedDownloadUrl;

  AttachmentModel({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.fileSizeMb,
    this.description,
    this.tag,
    required this.uploadedAt,
    required this.encryptedDownloadUrl,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'],
      fileName: json['file_name'],
      extension: json['extension'],
      fileSizeMb: json['file_size_mb'],
      description: json['description'],
      tag: json['tag'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
      encryptedDownloadUrl: json['encrypted_download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'extension': extension,
      'file_size_mb': fileSizeMb,
      'description': description,
      'tag': tag,
      'uploaded_at': uploadedAt.toIso8601String(),
      'encrypted_download_url': encryptedDownloadUrl,
    };
  }
}
