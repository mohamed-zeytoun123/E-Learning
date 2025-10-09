class SignUpRequestParams {
  final String fullName;
  final int? universityId;
  final int? collegeId;
  final int? studyYear;
  final String phone;
  final String password;

  SignUpRequestParams({
    required this.fullName,
    required this.universityId,
    required this.collegeId,
    required this.studyYear,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'university_id': universityId,
      'college_id': collegeId,
      'study_year': studyYear,
      'phone': phone,
      'password': password,
    };
  }

  SignUpRequestParams copyWith({
    String? fullName,
    int? universityId,
    int? collegeId,
    int? studyYear,
    String? phone,
    String? password,
  }) {
    return SignUpRequestParams(
      fullName: fullName ?? this.fullName,
      universityId: universityId ?? this.universityId,
      collegeId: collegeId ?? this.collegeId,
      studyYear: studyYear ?? this.studyYear,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
