import 'package:dartz/dartz.dart';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';

class Logout extends UseCase<bool, NoParams> {
  @override
  Future<Either<SafetechException, bool>> execute(NoParams params) async {
    await Storage.removeCookie();
    return const Right(true);
  }
}
