import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:safetech_app/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvents, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordState());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvents event,
  ) async* {
    if (event is ChangePasswordEmailChanged) {
      yield* _mapChangePasswordEmailChangedToState(event);
    } else if (event is ChangePasswordSubmitted) {
      yield* _mapChangePasswordSubmittedToState(event);
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordEmailChangedToState(
    ChangePasswordEmailChanged event,
  ) async* {
    final email = EmailInput.dirty(event.email);

    yield state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<ChangePasswordState> _mapChangePasswordSubmittedToState(
    ChangePasswordSubmitted event,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
      );

      final useCase = Injector.appInstance.get<ChangePasswordUseCase>();
      final either = await useCase.execute(ChangePasswordParams(
        email: state.email.value.trim(),
      ));

      yield* either.fold(
        (errors) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            error: errors.firstError,
          );
        },
        (token) async* {
          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );
        },
      );
    }
  }
}
