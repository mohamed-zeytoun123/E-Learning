class SignUpRequestParams {
  final String fullName;
  final int? universityId;
  final int? collegeId;
  final int? studyYear;
  final String email; // ← استبدال phone بـ email
  final String password;

  SignUpRequestParams({
    required this.fullName,
    required this.universityId,
    required this.collegeId,
    required this.studyYear,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'university_id': universityId,
      'college_id': collegeId,
      'study_year_id': studyYear,
      'email': email, // ← بدل phone
      'password': password,
    };
  }

  SignUpRequestParams copyWith({
    String? fullName,
    int? universityId,
    int? collegeId,
    int? studyYear,
    String? email,
    String? password,
  }) {
    return SignUpRequestParams(
      fullName: fullName ?? this.fullName,
      universityId: universityId ?? this.universityId,
      collegeId: collegeId ?? this.collegeId,
      studyYear: studyYear ?? this.studyYear,
      email: email ?? this.email, // ← بدل phone
      password: password ?? this.password,
    );
  }
}
