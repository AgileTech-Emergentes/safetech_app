import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/infrastructure/infrastructure.dart';
import 'package:injector/injector.dart';


void initializeDependencies() {
  final injector = Injector.appInstance;

  injector
    // repositories
    ..registerSingleton<AuthRepository>(() => AuthRepositoryImpl())

    // usecases
    ..registerSingleton<Login>(() {
      final repository = injector.get<AuthRepository>();
      return Login(repository);
    })
    ..registerSingleton<Register>(() {
      final repository = injector.get<AuthRepository>();
      return Register(repository);
    })
    ..registerSingleton<Logout>(() {
      return Logout();
    })
    ..registerSingleton<ChangePasswordUseCase>(() {
      final repository = injector.get<AuthRepository>();
      return ChangePasswordUseCase(repository);
    });
}
