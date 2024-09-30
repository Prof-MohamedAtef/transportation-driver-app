class ResetPassword {
  final String? email;
  final String? password;
  final String? passwordConfirm;

  ResetPassword(this.email, this.password, this.passwordConfirm);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
    };
  }
}