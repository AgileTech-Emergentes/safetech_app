import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ChangePasswordState extends Equatable {

  final FormzStatus status;
  final EmailInput email;
  final String error;

  const ChangePasswordState({
    this.status = FormzStatus.pure,
    this.email = const EmailInput.pure(),
    this.error = '',
  });

  ChangePasswordState copyWith({
    FormzStatus? status,
    EmailInput? email,
    String? error,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, email, error];
}
