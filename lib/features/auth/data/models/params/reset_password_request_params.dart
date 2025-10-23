class ResetPasswordRequestParams {
  final String phone;
  final String resetToken;
  final String newPassword;

  ResetPasswordRequestParams({
    required this.phone,
    required this.resetToken,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'reset_token': resetToken,
      'new_password': newPassword,
    };
  }

  ResetPasswordRequestParams copyWith({
    String? phone,
    String? resetToken,
    String? newPassword,
  }) {
    return ResetPasswordRequestParams(
      phone: phone ?? this.phone,
      resetToken: resetToken ?? this.resetToken,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
