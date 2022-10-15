import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvents extends Equatable {
  const ChangePasswordEvents();

  @override
  List<Object?> get props => [];
}

class ChangePasswordEmailChanged extends ChangePasswordEvents {
  const ChangePasswordEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class ChangePasswordSubmitted extends ChangePasswordEvents {
  const ChangePasswordSubmitted();

  @override
  List<Object?> get props => [];
}
