import 'dart:convert';

import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));
String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  int id;
  String text;
  double score;
  double magnitude;
  User user;
  Technical technical;
  Appointment appointment;

  Review({
    required this.id,
    required this.text,
    required this.score,
    required this.magnitude,
    required this.user,
    required this.technical,
    required this.appointment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      text: json["text"],
      score: json["score"],
      magnitude: json["magnitude"],
      user: User.fromJson(json["user"]),
      technical: Technical.fromJson(json["technical"]),
      appointment: Appointment.fromJson(json["appointment"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "score": score,
      "magnitude": magnitude,
      "user": user.toJson(),
      "technical": technical.toJson(),
      "appointment": appointment.toJson(),
    };
  }

}