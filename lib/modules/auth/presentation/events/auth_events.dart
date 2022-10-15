import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {
  const AuthEvents();

  @override
  List<Object?> get props => [];
}

class StatusChanged extends AuthEvents {
  const StatusChanged(this.status);

  final Status status;

  @override
  List<Object?> get props => [status];
}

class AuthLogoutRequested extends AuthEvents {
  const AuthLogoutRequested();

  @override
  List<Object?> get props => [];
}
