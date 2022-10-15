import 'package:formz/formz.dart';

enum RepeatPasswordValidation {
  empty,
  passwordUnmatch,
}

class PasswordPair {
  const PasswordPair({
    required this.password,
    required this.confirmPassword,
  });

  final String password;
  final String confirmPassword;

  PasswordPair copyWith({
    String? password,
    String? confirmPassword,
  }) {
    return PasswordPair(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  bool passwordsEqual() {
    return password == confirmPassword;
  }
}

class RepeatPasswordInput
    extends FormzInput<PasswordPair, RepeatPasswordValidation> {
  const RepeatPasswordInput.pure()
      : super.pure(const PasswordPair(
          password: '',
          confirmPassword: '',
        ));

  const RepeatPasswordInput.dirty([
    PasswordPair value =
        const PasswordPair(password: '', confirmPassword: ''),
  ]) : super.dirty(value);

  @override
  RepeatPasswordValidation? validator(PasswordPair? value) {
    if (value == null || value.confirmPassword.isEmpty) {
      return RepeatPasswordValidation.empty;
    }

    if (!value.passwordsEqual()) {
      return RepeatPasswordValidation.passwordUnmatch;
    }

    return null;
  }

  String? getErrorMessage() {
    if (pure || valid) {
      return null;
    }
    if (error == RepeatPasswordValidation.empty) {
      return 'Debe ingresar nuevamente la contraseña elegida';
    }
    if (error == RepeatPasswordValidation.passwordUnmatch) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
