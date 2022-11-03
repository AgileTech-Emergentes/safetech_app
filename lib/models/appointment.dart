import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));
String appointmentToJson(Appointment data) => json.encode(data.toJson());

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));
String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  int id;
  String problemDescription;
  DateTime scheduledAt;
  Address address;
  String status;
  Money reparationCost;
  String paymentStatus;
  User user;
  Technical technical;
  Appliance appliance;

  Appointment({
    required this.id,
    required this.problemDescription,
    required this.scheduledAt,
    required this.address,
    required this.status,
    required this.reparationCost,
    required this.paymentStatus,
    required this.user,
    required this.technical,
    required this.appliance,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["id"],
      problemDescription: json["problemDescription"],
      scheduledAt: DateTime.parse(json["scheduledAt"]),
      address: Address.fromJson(json["address"]),
      status: json["status"],
      reparationCost: Money.fromJson(json["reparationCost"]),
      paymentStatus: json["paymentStatus"],
      user: User.fromJson(json["user"]),
      technical: Technical.fromJson(json["technical"]),
      appliance: Appliance.fromJson(json["appliance"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "problemDescription": problemDescription,
      "scheduledAt": DateFormat('yyyy-MM-ddTHH:mm:ss').format(scheduledAt),
      "address": address.toJson(),
      "status": status,
      "reparationCost": reparationCost.toJson(),
      "paymentStatus": paymentStatus,
      "user": user.toJson(),
      "technical": technical.toJson(),
      "appliance": appliance.toJson(),
    };
  }

}

enum Status { 
  SCHEDULED,
  FINISHED,
  CANCELED
}

enum PaymentStatus { 
  SUCCEED,
  FAILED,
  PROCESSING,
  REFUNDED
}