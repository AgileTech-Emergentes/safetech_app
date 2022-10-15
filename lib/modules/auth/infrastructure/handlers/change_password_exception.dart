import 'dart:convert';

import 'package:safetech_app/core/domain/domain.dart';

class ChangePasswordException implements SafetechException {

  final List<String> email;

  const ChangePasswordException({
    required this.email,
  });

  factory ChangePasswordException.fromMap(Map<String, dynamic> map) {
    return ChangePasswordException(
      email: List<String>.from(map['email'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory ChangePasswordException.fromJson(String source) =>
      ChangePasswordException.fromMap(jsonDecode(source));


  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ChangePasswordException{email: $email}';

  @override
  String get firstError {
    if (email.isNotEmpty) {
      return email.first;
    }

    return '';
  }

  @override
  String get error => firstError;
}
