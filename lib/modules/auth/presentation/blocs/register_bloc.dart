import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterState> {
  RegisterBloc() : super(const RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvents event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event);
    } else if (event is RegisterRepeatPasswordChanged) {
      yield* _mapRegisterRepeatPasswordChangedToState(event);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event);
    } else if (event is RegisterPasswordToggled) {
      yield* _mapRegisterPasswordToggledToState(event);
    } else if (event is RegisterRepeatPasswordToggled) {
      yield* _mapRegisterRepeatPasswordToggledToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(
    RegisterEmailChanged event,
  ) async* {
    final email = EmailInput.dirty(event.email);

    yield state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.repeatPassword,
      ]),
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
    RegisterPasswordChanged event,
  ) async* {
    final password = PasswordInput.dirty(event.password);
    final repeatPassword = RepeatPasswordInput.dirty(
      state.repeatPassword.value.copyWith(
        password: event.password,
      ),
    );

    yield state.copyWith(
      password: password,
      repeatPassword: repeatPassword,
      status: Formz.validate([
        state.email,
        password,
        repeatPassword,
      ]),
    );
  }

  Stream<RegisterState> _mapRegisterRepeatPasswordChangedToState(
    RegisterRepeatPasswordChanged event,
  ) async* {
    final repeatPassword = RepeatPasswordInput.dirty(
      state.repeatPassword.value.copyWith(
        confirmPassword: event.repeatPassword,
      ),
    );

    yield state.copyWith(
      repeatPassword: repeatPassword,
      status: Formz.validate([
        state.email,
        state.password,
        repeatPassword,
      ]),
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
      );

      final useCase = Injector.appInstance.get<Register>();
      final either = await useCase.execute(
        RegisterParams(
          email: state.email.value,
          password: state.password.value,
        ),
      );

      yield* either.fold(
        (error) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            error: error.firstError,
          );
        },
        (r) async* {
          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );
        },
      );
    }
  }

  Stream<RegisterState> _mapRegisterPasswordToggledToState(
    RegisterPasswordToggled event,
  ) async* {
    if (state.passwordVisible) {
      yield state.copyWith(passwordVisible: false);
    } else {
      yield state.copyWith(passwordVisible: true);
    }
  }

  Stream<RegisterState> _mapRegisterRepeatPasswordToggledToState(
    RegisterRepeatPasswordToggled event,
  ) async* {
    if (state.repeatPasswordVisible) {
      yield state.copyWith(repeatPasswordVisible: false);
    } else {
      yield state.copyWith(repeatPasswordVisible: true);
    }
  }
}
