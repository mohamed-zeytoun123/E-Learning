class EnrollmentModel {
  final int id;
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
  final double progressPercentage;
  final bool isCompleted;

  const EnrollmentModel({
    required this.id,
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
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id'] as int,
      course: json['course'] as int,
      courseTitle: json['course_title'] as String,
      courseImage: json['course_image'] as String?,
      teacherName: json['teacher_name'] as String,
      enrolledAt: json['enrolled_at'] as String,
      status: json['status'] as String,
      statusDisplay: json['status_display'] as String,
      paymentStatus: json['payment_status'] as String,
      paymentStatusDisplay: json['payment_status_display'] as String,
      isPaid: json['is_paid'] as bool,
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
      isCompleted: json['is_completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
    };
  }

  EnrollmentModel copyWith({
    int? id,
    int? course,
    String? courseTitle,
    String? courseImage,
    String? teacherName,
    String? enrolledAt,
    String? status,
    String? statusDisplay,
    String? paymentStatus,
    String? paymentStatusDisplay,
    bool? isPaid,
    double? progressPercentage,
    bool? isCompleted,
  }) {
    return EnrollmentModel(
      id: id ?? this.id,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      courseImage: courseImage ?? this.courseImage,
      teacherName: teacherName ?? this.teacherName,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      status: status ?? this.status,
      statusDisplay: statusDisplay ?? this.statusDisplay,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentStatusDisplay: paymentStatusDisplay ?? this.paymentStatusDisplay,
      isPaid: isPaid ?? this.isPaid,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
