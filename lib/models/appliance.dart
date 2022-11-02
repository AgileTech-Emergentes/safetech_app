import 'package:safetech_app/models/diagnosis_cost.dart';

class Appliance{
  int id;
  String name;
  String imgUrl;
  DiagnosisCost diagnosisCost;

  Appliance({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.diagnosisCost,
  });

  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(
      id: json["id"],
      name: json["name"],
      imgUrl: json["imgUrl"],
      diagnosisCost: DiagnosisCost.fromJson(json["diagnosisCost"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imgUrl": imgUrl,
      "diagnosisCost": diagnosisCost.toJson(),
    };
  }
}