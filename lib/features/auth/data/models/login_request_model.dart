class LoginRequestModel {
  // "email":"m@m.com",
  // "password":"123456
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
