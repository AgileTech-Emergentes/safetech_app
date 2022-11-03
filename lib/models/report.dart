import 'dart:convert';

import 'package:safetech_app/models/applianceInfo.dart';
import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));
String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  int id;
  ApplianceInfo applianceInfo;
  String applianceDiagnostic;
  String reparationDetails;  
  User user;
  Technical technical;
  Appointment appointment;

  Report({
    required this.id,
    required this.applianceInfo,
    required this.applianceDiagnostic,
    required this.reparationDetails,
    required this.user,
    required this.technical,
    required this.appointment,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"],
      applianceInfo: ApplianceInfo.fromJson(json["applianceInfo"]),
      applianceDiagnostic: json["applianceDiagnostic"],
      reparationDetails: json["reparationDetails"],
      user: User.fromJson(json["user"]),
      technical: Technical.fromJson(json["technical"]),
      appointment: Appointment.fromJson(json["appointment"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "applianceInfo": applianceInfo.toJson(),
      "applianceDiagnostic": applianceDiagnostic,
      "reparationDetails": reparationDetails,
      "user": user.toJson(),
      "technical": technical.toJson(),
      "appointment": appointment.toJson(),
    };
  }
}