import 'dart:convert';

import 'package:safetech_app/models/applianceInfo.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));
String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  int id;
  ApplianceInfo applianceInfo;
  String applianceDiagnostic;
  String reparationDetails;

  Report({
    required this.id,
    required this.applianceInfo,
    required this.applianceDiagnostic,
    required this.reparationDetails,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"],
      applianceInfo: ApplianceInfo.fromJson(json["applianceInfo"]),
      applianceDiagnostic: json["applianceDiagnostic"],
      reparationDetails: json["reparationDetails"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "applianceInfo": applianceInfo.toJson(),
      "applianceDiagnostic": applianceDiagnostic,
      "reparationDetails": reparationDetails,
    };
  }
}