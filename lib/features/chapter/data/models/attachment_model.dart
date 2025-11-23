class AttachmentModel {
  final int id;
  final String fileName;
  final String extension;
  final String fileSizeMb;
  final String? description;
  final String? tag;
  final String uploadedAt;
  final String fileUrl;

  AttachmentModel({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.fileSizeMb,
    required this.description,
    required this.tag,
    required this.uploadedAt,
    required this.fileUrl,
  });

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id'] ?? 0,
      fileName: map['file_name'] ?? '',
      extension: map['extension'] ?? '',
      fileSizeMb: map['file_size_mb'] ?? '',
      description: map['description'],
      tag: map['tag'],
      uploadedAt: map['uploaded_at'] ?? '',
      fileUrl: map['file_url'] ?? '',
    );
  }
}
