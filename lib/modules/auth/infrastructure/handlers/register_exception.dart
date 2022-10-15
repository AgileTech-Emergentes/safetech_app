import 'dart:convert';

import 'package:safetech_app/core/domain/domain.dart';

class RegisterException implements SafetechException {

  final List<String> email;
  final List<String> password;

  const RegisterException({
    required this.email,
    required this.password,
  });

  factory RegisterException.fromMap(Map<String, dynamic> map) {
    return RegisterException(
      email: List<String>.from(map['email'] ?? []),
      password: List<String>.from(map['password'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory RegisterException.fromJson(String source) =>
      RegisterException.fromMap(jsonDecode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RegisterException{email: $email, password: $password}';

  @override
  String get firstError {
    if (email.isNotEmpty) {
      return email.first;
    }
    if (password.isNotEmpty) {
      return password.first;
    }

    return '';
  }

  @override
  String get error => firstError;
}
