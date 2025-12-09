class LoginInputParams {
  String? email, password;
  LoginInputParams({this.email, this.password});
}


class SignUpInputParams {
  String? phone, password, fullName, confirmPassword;
  int? universityId, collegeId;
  SignUpInputParams({
    this.phone,
    this.password,
    this.fullName,
    this.confirmPassword,
    this.universityId,
    this.collegeId,
  });
}

