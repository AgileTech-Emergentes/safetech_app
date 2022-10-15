import 'dart:convert';

import 'package:safetech_app/core/domain/domain.dart';


class LoginException implements SafetechException {
  final List<String> errors;
  final List<String> email;
  final List<String> password;

  const LoginException({
    required this.errors,
    required this.email,
    required this.password,
  });

  factory LoginException.fromMap(Map<String, dynamic> map) {
    return LoginException(
      email: List<String>.from(map['email'] ?? []),
      password: List<String>.from(map['password'] ?? []),
      errors: List<String>.from(map['errors'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'errors': errors,
    };
  }

  factory LoginException.fromJson(String source) =>
      LoginException.fromMap(json.decode(source));

  String toJson() => jsonEncode(toMap());

  @override
  String get firstError {
    if (errors.isNotEmpty) {
      return errors.first;
    }
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

  @override
  String toString() =>
      'LoginException{errors: $errors, email: $email, password: $password}';

}
