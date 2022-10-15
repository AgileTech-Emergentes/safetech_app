import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc({
    required StreamRepository streamRepository,
  })  : _streamRepository = streamRepository,
        super(const LoginState());

  final StreamRepository _streamRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event);
    } else if (event is LoginPasswordShowed) {
      yield* _mapLoginPasswordShowedToState(event);
    } else if (event is LoginPasswordHidden) {
      yield* _mapLoginPasswordHiddenToState(event);
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(
    LoginEmailChanged event,
  ) async* {
    final email = EmailInput.dirty(event.email);

    yield state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(
    LoginPasswordChanged event,
  ) async* {
    final password = PasswordInput.dirty(event.password);

    yield state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
      );

      final useCase = Injector.appInstance.get<Login>();
      final either = await useCase.execute(LoginParams(
        email: state.email.value,
        password: state.password.value,
      ));

      yield* either.fold(
        (errors) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            error: errors.firstError,
          );
        },
        (cookie) async* {
          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );

          _streamRepository.login();
        },
      );
    }
  }

  Stream<LoginState> _mapLoginPasswordShowedToState(
    LoginPasswordShowed event,
  ) async* {
    yield state.copyWith(passwordVisible: true);
  }

  Stream<LoginState> _mapLoginPasswordHiddenToState(
    LoginPasswordHidden event,
  ) async* {
    yield state.copyWith(passwordVisible: false);
  }
}
