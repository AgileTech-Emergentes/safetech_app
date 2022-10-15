import 'package:formz/formz.dart';

enum EmailValidation {
  empty,
  invalidEmail,
}

class EmailInput extends FormzInput<String, EmailValidation> {

  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidation? validator(String? value) {
    if (value == null || value.isEmpty) {
      return EmailValidation.empty;
    }

    //https://stackoverflow.com/questions/16800540/how-should-i-check-if-the-input-is-an-email-address-in-flutter
    final regex = RegExp(r'''^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+''');
    if (!regex.hasMatch(value)) {
      return EmailValidation.invalidEmail;
    }

    return null;
  }

  String? getErrorMessage() {
    if (pure || valid) {
      return null;
    }
    if (error == EmailValidation.empty) {
      return 'El correo no debe estar vacio';
    }
    if (error == EmailValidation.invalidEmail) {
      return 'Debe ingresar un correo valido';
    }
    return null;
  }
}
