import 'dart:convert';

class FullName {
  String firstName;
  String lastName;

  FullName({
    required this.firstName,
    required this.lastName,
  });

  factory FullName.fromJson(Map<String, dynamic> json) {
    return FullName(
      firstName: json["firstName"],
      lastName: json["lastName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}