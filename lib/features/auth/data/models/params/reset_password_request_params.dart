class ResetPasswordRequestParams {
  final String email;
  final String resetToken;
  final String newPassword;

  ResetPasswordRequestParams({
    required this.email,
    required this.resetToken,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'reset_token': resetToken,
      'new_password': newPassword,
    };
  }

  ResetPasswordRequestParams copyWith({
    String? email,
    String? resetToken,
    String? newPassword,
  }) {
    return ResetPasswordRequestParams(
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
