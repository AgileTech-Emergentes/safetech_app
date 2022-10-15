import 'package:equatable/equatable.dart';

abstract class RegisterEvents extends Equatable {
  const RegisterEvents();

  @override
  List<Object?> get props => [];
}

class RegisterEmailChanged extends RegisterEvents {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvents {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class RegisterRepeatPasswordChanged extends RegisterEvents {
  const RegisterRepeatPasswordChanged(this.repeatPassword);

  final String repeatPassword;

  @override
  List<Object?> get props => [repeatPassword];
}

class RegisterSubmitted extends RegisterEvents {
  const RegisterSubmitted();
}

class RegisterPasswordToggled extends RegisterEvents {
  const RegisterPasswordToggled();
}

class RegisterRepeatPasswordToggled extends RegisterEvents {
  const RegisterRepeatPasswordToggled();
}
