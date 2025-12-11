class EnrollmentModel {
  final int id;
  final int student;
  final String studentName;
  final int course;
  final String courseTitle;
  final String? courseImage;
  final String teacherName;
  final String enrolledAt;
  final String status;
  final String statusDisplay;
  final String paymentStatus;
  final String paymentStatusDisplay;
  final bool isPaid;
  final int progressPercentage;
  final bool isCompleted;
  final String? completedAt;
  final String? originalPrice;
  final bool isFavorite;
  final int totalVideos;
  final int completedVideos;

  EnrollmentModel({
    required this.id,
    required this.student,
    required this.studentName,
    required this.course,
    required this.courseTitle,
    this.courseImage,
    required this.teacherName,
    required this.enrolledAt,
    required this.status,
    required this.statusDisplay,
    required this.paymentStatus,
    required this.paymentStatusDisplay,
    required this.isPaid,
    required this.progressPercentage,
    required this.isCompleted,
    this.completedAt,
    this.originalPrice,
    this.isFavorite = false,
    this.totalVideos = 0,
    this.completedVideos = 0,
  });

  //----------------------------
  //* From JSON
  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id'] as int,
      student: json['student'] as int? ?? 0,
      studentName: json['student_name'] as String? ?? '',
      course: json['course'] as int,
      courseTitle: json['course_title'] as String,
      courseImage: json['course_image'] as String?,
      teacherName: json['teacher_name'] as String,
      enrolledAt: json['enrolled_at'] as String,
      status: json['status'] as String,
      statusDisplay: json['status_display'] as String,
      paymentStatus: json['payment_status'] as String,
      paymentStatusDisplay: json['payment_status_display'] as String,
      isPaid: json['is_paid'] as bool? ?? false,
      progressPercentage: json['progress_percentage'] as int? ?? 0,
      isCompleted: json['is_completed'] as bool? ?? false,
      completedAt: json['completed_at'] as String?,
      originalPrice: json['original_price'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      totalVideos: json['total_videos'] as int? ?? 0,
      completedVideos: json['completed_videos'] as int? ?? 0,
    );
  }

  //----------------------------
  //* To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student': student,
      'student_name': studentName,
      'course': course,
      'course_title': courseTitle,
      'course_image': courseImage,
      'teacher_name': teacherName,
      'enrolled_at': enrolledAt,
      'status': status,
      'status_display': statusDisplay,
      'payment_status': paymentStatus,
      'payment_status_display': paymentStatusDisplay,
      'is_paid': isPaid,
      'progress_percentage': progressPercentage,
      'is_completed': isCompleted,
      'completed_at': completedAt,
      'original_price': originalPrice,
      'is_favorite': isFavorite,
      'total_videos': totalVideos,
      'completed_videos': completedVideos,
    };
  }
}
