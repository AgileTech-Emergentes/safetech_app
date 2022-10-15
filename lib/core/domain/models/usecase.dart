import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<SafetechException, Type>> execute(Params params);
}

class NoParams {
  const NoParams();
}
