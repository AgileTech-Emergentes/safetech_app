import 'dart:async';
import 'package:safetech_app/core/domain/domain.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final StreamRepository _streamRepository;
  late StreamSubscription<Status> _authStatusSubscription;

  AuthBloc({required StreamRepository streamRepository})
  : _streamRepository = streamRepository,
    super(const AuthState.unknown()) {
    _authStatusSubscription = _streamRepository.status.listen((status) => add(StatusChanged(status)));
  }


  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    if (event is StatusChanged) {
      yield* _mapAuthStatusChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      yield* _mapAuthLogoutRequestedToState(event);
    }
  }

  Stream<AuthState> _mapAuthStatusChangedToState(
    StatusChanged event,
  ) async* {
    if (event.status.isUnauthenticated) {
      yield const AuthState.unauthenticated();
    } else if (event.status.isAuthenticated) {
      yield const AuthState.authenticated();
    } else {
      yield const AuthState.unknown();
    }
  }

  Stream<AuthState> _mapAuthLogoutRequestedToState(
    AuthLogoutRequested event,
  ) async* {
    final usecase = Injector.appInstance.get<Logout>();
    await usecase.execute(const NoParams());
    yield const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _streamRepository.dispose();
    return super.close();
  }
}
