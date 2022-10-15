import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object?> get props => [];
}

class LoginEmailChanged extends LoginEvents {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvents {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginPasswordShowed extends LoginEvents {
  const LoginPasswordShowed();

  @override
  List<Object?> get props => [];
}

class LoginPasswordHidden extends LoginEvents {
  const LoginPasswordHidden();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvents {
  const LoginSubmitted();
}
