class OtpVerificationResponse {
  final String? resetToken;

  const OtpVerificationResponse({this.resetToken});

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(resetToken: json['reset_token'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'reset_token': resetToken};
  }

  OtpVerificationResponse copyWith({String? resetToken}) {
    return OtpVerificationResponse(resetToken: resetToken ?? this.resetToken);
  }
}
