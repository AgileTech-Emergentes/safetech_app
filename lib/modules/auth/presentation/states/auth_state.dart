import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:equatable/equatable.dart';


class AuthState extends Equatable {

  final Status status;

  const AuthState({
    this.status = Status.unknown,
  });

  const AuthState.unknown(): this();

  const AuthState.authenticated(): this(status: Status.authenticated);

  const AuthState.unauthenticated(): this(status: Status.unauthenticated);

  @override
  List<Object?> get props => [status];
}
