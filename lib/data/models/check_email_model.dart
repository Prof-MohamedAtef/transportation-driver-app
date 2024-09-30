class Email {
  final String? email;

  Email(this.email);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}