import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final FormzStatus status;
  final EmailInput email;
  final PasswordInput password;
  final RepeatPasswordInput repeatPassword;
  final bool passwordVisible;
  final bool repeatPasswordVisible;
  final String error;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.repeatPassword = const RepeatPasswordInput.pure(),
    this.passwordVisible = false,
    this.repeatPasswordVisible = false,
    this.error = '',
  });

  RegisterState copyWith({
    FormzStatus? status,
    EmailInput? email,
    PasswordInput? password,
    RepeatPasswordInput? repeatPassword,
    bool? passwordVisible,
    bool? repeatPasswordVisible,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      repeatPasswordVisible: repeatPasswordVisible ?? this.repeatPasswordVisible,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, email, password, repeatPassword, passwordVisible, repeatPasswordVisible, error];
}
