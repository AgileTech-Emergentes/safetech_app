import 'package:formz/formz.dart';

enum PasswordValidation {
  empty,
  invalidLength,
}

const _MIN_LENGTH = 8;
const _MAX_LENGTH = 32;

class PasswordInput extends FormzInput<String, PasswordValidation> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidation? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidation.empty;
    }

    if (value.length < _MIN_LENGTH ||
        value.length > _MAX_LENGTH) {
      return PasswordValidation.invalidLength;
    }

    return null;
  }

  String? getErrorMessage() {
    if (pure || valid) {
      return null;
    }
    if (error == PasswordValidation.empty) {
      return 'Debe ingresar una contraseña';
    }
    if (error == PasswordValidation.invalidLength) {
      return 'La contraseña ingresada no es segura';
    }
    return null;
  }
}
