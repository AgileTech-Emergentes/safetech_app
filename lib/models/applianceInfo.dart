import 'dart:convert';

class ApplianceInfo {
  String type;
  String model;
  String brand;

  ApplianceInfo({
    required this.type,
    required this.model,
    required this.brand,
  });

  factory ApplianceInfo.fromJson(Map<String, dynamic> json) {
    return ApplianceInfo(
      type: json["type"],
      model: json["model"],
      brand: json["brand"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "model": model,
      "brand": brand,
    };
  }
}