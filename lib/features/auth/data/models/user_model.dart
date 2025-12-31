class UserModel {
  // {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.
  //,"user":{"_id":"6953ddf4735c8919732f5e4d",
  //"first_name":"mr",
  //"last_name":"t",
  //"email":"tt@tt.tt",
  //"email_verified":true,
  //"phone":"012435654562",
  //"phone_verified":false,
  //"avatar_url":null,
  //"city":"Dhaka",
  //"role":0

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String city;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.city,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      "last_name": lastName,
      "email": email,
      "phone": phone,
      "avatar_url": avatarUrl,
      "city": city,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      city: json['city'],
    );
  }
}
