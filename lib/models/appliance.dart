import 'dart:convert';

import 'package:safetech_app/models/money.dart';

Appliance applianceFromJson(String str) => Appliance.fromJson(json.decode(str));
String applianceModelToJson(Appliance data) => json.encode(data.toJson());

class Appliance {
  int id;
  String name;
  Money diagnosisCost;
  String imgUrl;

  Appliance({
    required this.id,
    required this.name,
    required this.diagnosisCost,
    required this.imgUrl,
  });

  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(
      id: json["id"],
      name: json["name"],
      diagnosisCost: Money.fromJson(json["diagnosisCost"]),
      imgUrl: json["imgUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "diagnosisCost": diagnosisCost.toJson(),
      "imgUrl": imgUrl,
    };
  }
}
