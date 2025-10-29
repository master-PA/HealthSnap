class User {
  final String id;
  final String fullname;
  final String email;
  final String? token;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      token: json['token'],
    );
  }
}
