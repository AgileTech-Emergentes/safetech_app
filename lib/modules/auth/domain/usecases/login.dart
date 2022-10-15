import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';

class LoginParams {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class Login extends UseCase<String, LoginParams> {
  const Login(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<SafetechException, String>> execute(LoginParams params) async {
    final either = await _repository.login(
      email: params.email,
      password: params.password,
    );

    return either.map((cookie) {
      Storage.setCookie(cookie);
      Storage.setUsername(params.email);
      return cookie;
    });
  }
}
