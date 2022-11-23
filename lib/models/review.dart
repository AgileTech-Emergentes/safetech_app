import 'dart:convert';

import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));
String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  int id;
  String text;
  User user;
  Technical technical;
  Appointment appointment;

  Review({
    required this.id,
    required this.text,
    required this.user,
    required this.technical,
    required this.appointment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      text: json["text"],
      user: User.fromJson(json["user"]),
      technical: Technical.fromJson(json["technical"]),
      appointment: Appointment.fromJson(json["appointment"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "user": user.toJson(),
      "technical": technical.toJson(),
      "appointment": appointment.toJson(),
    };
  }

}