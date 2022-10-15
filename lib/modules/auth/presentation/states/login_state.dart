import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {

  final FormzStatus status;
  final EmailInput email;
  final PasswordInput password;
  final bool passwordVisible;
  final String error;

  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.passwordVisible = false,
    this.error = '',
  });

  LoginState copyWith({
    String? error,
    FormzStatus? status,
    EmailInput? email,
    PasswordInput? password,
    bool? passwordVisible,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [status, email, password, passwordVisible, error];
}
