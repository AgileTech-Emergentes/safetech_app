import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/money.dart';

class Appointment {
  int id;
  String problemDescription;
  DateTime scheduledAt;
  Address address;
  String status;
  Money reparationCost;
  String paymentStatus;

  Appointment({
    required this.id,
    required this.problemDescription,
    required this.scheduledAt,
    required this.address,
    required this.status,
    required this.reparationCost,
    required this.paymentStatus
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
      "paymentStatus": paymentStatus
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