import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/core/presentation/utils/constants.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/infrastructure/infrastructure.dart';
import 'package:http/http.dart' as http;


class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<SafetechException, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      // final url = '$API_URL/auth/login';
      // final uri = Uri.parse(url);
      // final response = await http.post(
      //   uri,
      //   body: {
      //     'email': email,
      //     'password': password,
      //   },
      // );

      // final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      // if (response.statusCode != HttpStatus.ok) {
      //   return Left(LoginException.fromMap(decoded['errors']));
      // }
      //TODO: sera boolean o un string
      //return Right(decoded['auth'] as String);
      return Right('TRUE');

    } catch (e) {
      return const Left(SafetechException('INTERNAL SERVER ERROR!'));
    }
  }

  @override
  Future<Either<SafetechException, bool>> register({
    required String email,
    required String password,
  }) async {
    try {
      final url = '$API_URL/auth/register';
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: {
          'email': email,
          'password': password,
        },
      );

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != HttpStatus.ok) {
        final registerErrors = RegisterException.fromMap(decoded['errors']);
        return Left(registerErrors);
      }
      //TODO: que traera el response
      return const Right(true);
    } catch (e) {
      return const Left(SafetechException('INTERNAL SERVER ERROR!'));
    }
  }

  @override
  Future<Either<SafetechException, bool>> changePassword({
    required String email,
  }) async {
    try {
      final url = '$API_URL/auth/forgot-password';
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: {
          'email': email,
        },
      );
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != HttpStatus.created) {
        final errors = decoded['errors'];
        final registerErrors = ChangePasswordException.fromMap(errors);
        return Left(registerErrors);
      }
      //TODO: VER FLUJO DE CAMBIO DE PASSWORD
      return const Right(true);

    } catch (e) {
      return const Left(SafetechException('INTERNAL SERVER ERROR!'));
    }
  }
}
