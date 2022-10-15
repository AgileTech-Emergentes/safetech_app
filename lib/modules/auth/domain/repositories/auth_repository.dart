import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';

abstract class AuthRepository {
  Future<Either<SafetechException, String>> login({
    required String email,
    required String password,
  });

  Future<Either<SafetechException, bool>> register({
    required String email,
    required String password,
  });

  Future<Either<SafetechException, bool>> changePassword({
    required String email,
  });
}
