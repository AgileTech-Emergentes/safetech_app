import 'dart:convert';

import 'package:safetech_app/models/fullname.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String useModelToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  FullName fullName;
  String dni;
  String email;
  String password;
  String profilePictureUrl;
  String address;
  String phone;
  String birthdayDate;

  User({
    required this.id,
    required this.fullName,
    required this.dni,
    required this.email,
    required this.password,
    required this.profilePictureUrl,
    required this.address,
    required this.phone,
    required this.birthdayDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      fullName: FullName.fromJson(json["fullName"]),
      dni: json["dni"],
      email: json["email"],
      password: json["password"],
      profilePictureUrl: json["profilePictureUrl"],
      address: json["address"],
      phone: json["phone"],
      birthdayDate: json["birthdayDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName.toJson(),
      "dni": dni,
      "email": email,
      "password": password,
      "profilePictureUrl": profilePictureUrl,
      "address": address,
      "phone": phone,
      "birthdayDate": birthdayDate,
    };
  }
}
