class SignupRequestModel {
  //  "first_name": "Meskatul",
  //   "last_name": "Islam",
  //   "email": "meskatcse@gmail.com",
  //   "password": "123456",
  //   "phone": "01754658781",
  //   "city": "Chattogram"

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String city;

  SignupRequestModel(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.city,
  );

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
    };
  }
}
