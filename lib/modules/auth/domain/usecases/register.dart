import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';

class RegisterParams {
  const RegisterParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class Register extends UseCase<bool, RegisterParams> {
  const Register(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<SafetechException, bool>> execute(RegisterParams params) {
    return _repository.register(
      email: params.email,
      password: params.password
    );
  }
}
