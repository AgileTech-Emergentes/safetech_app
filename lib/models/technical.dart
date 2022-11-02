import 'dart:convert';
import 'dart:ffi';

import 'package:safetech_app/models/fullname.dart';

Technical technicalFromJson(String str) => Technical.fromJson(json.decode(str));
String technicalModelToJson(Technical data) => json.encode(data.toJson());

class Technical {
  int id;
  FullName fullName;
  String dni;
  String email;
  String password;
  String profilePictureUrl;
  String address;
  String phone;
  String birthdayDate;
  double score;
  String aboutMe;

  Technical({
    required this.id,
    required this.fullName,
    required this.dni,
    required this.email,
    required this.password,
    required this.profilePictureUrl,
    required this.address,
    required this.phone,
    required this.birthdayDate,
    required this.score,
    required this.aboutMe,
  });

  factory Technical.fromJson(Map<String, dynamic> json) {
    return Technical(
      id: json["id"],
      fullName: FullName.fromJson(json["fullName"]),
      dni: json["dni"],
      email: json["email"],
      password: json["password"],
      profilePictureUrl: json["profilePictureUrl"],
      address: json["address"],
      phone: json["phone"],
      birthdayDate: json["birthdayDate"],
      score: json["score"],
      aboutMe: json["aboutMe"],
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
      "score": score,
      "aboutMe": aboutMe,
    };
  }
}
