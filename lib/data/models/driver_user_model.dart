class Driver{
  final String? name;
  final String? email;
  final String password;

  Driver({
    this.name,
    required this.email,
    required this.password,
  });

  // Convert the Driver object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}