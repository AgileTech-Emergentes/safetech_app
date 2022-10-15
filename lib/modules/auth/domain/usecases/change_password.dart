import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';

class ChangePasswordParams {
  const ChangePasswordParams({
    required this.email,
  });

  final String email;
}

class ChangePasswordUseCase extends UseCase<bool, ChangePasswordParams> {
  const ChangePasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<SafetechException, bool>> execute(ChangePasswordParams params) {
    return _repository.changePassword(
      email: params.email
    );
  }
}
