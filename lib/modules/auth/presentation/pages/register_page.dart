import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: BlocProvider<RegisterBloc>(
            create: (_) => RegisterBloc(),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Registro exitoso'),
                backgroundColor: Colors.green,
              ),
            );

          await Future.delayed(const Duration(seconds: 1), (){});

          Navigator.of(context).pop();
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset('assets/logo/app_logo.png'),
              Image.network('https://media.discordapp.net/attachments/761432652347211826/1010405809248809040/dentasisIcon.png?width=697&height=702'),
              const SizedBox(height: 24),
              const _EmailInput(),
              const SizedBox(height: 12),
              const _PasswordInput(),
              const SizedBox(height: 12),
              const _RepeatPasswordInput(),
              const SizedBox(height: 12),
              const _RegisterButton(),
              const SizedBox(height: 16),
              _buildReturnButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReturnButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Text('Regresar'),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          key: const Key('registerForm_emailInput_textField'),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.email),
              onPressed: (){},
            ),
            labelText: 'Correo',
            hintText: 'Ingrese su email',
            errorText: state.email.getErrorMessage(),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final isVisible = state.passwordVisible;
        final visibilityIcon =
            isVisible ? Icons.visibility : Icons.visibility_off;

        return TextField(
          key: const Key('registerForm_emailInput_textField'),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
          obscureText: !isVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(visibilityIcon),
              onPressed: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterPasswordToggled());
              },
            ),
            labelText: 'Contraseña',
            hintText: 'Ingrese su contraseña',
            errorText: state.password.getErrorMessage(),
          ),
        );
      },
    );
  }
}

class _RepeatPasswordInput extends StatelessWidget {
  const _RepeatPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final isVisible = state.repeatPasswordVisible;
        final visibilityIcon =
            isVisible ? Icons.visibility : Icons.visibility_off;

        return TextField(
          key: const Key('registerForm_passwordConfirmationInput_textField'),
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(RegisterRepeatPasswordChanged(value)),
          obscureText: !isVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(visibilityIcon),
              onPressed: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterRepeatPasswordToggled());
              },
            ),
            labelText: 'Repetir contraseña',
            hintText: 'Ingrese nuevamente su contraseña',
            errorText: state.repeatPassword.getErrorMessage(),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final isSubmissionInProgress = state.status.isSubmissionInProgress;

        return isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  ElevatedButton(
                    key: const Key('registerForm_continue_raisedButton'),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<RegisterBloc>()
                                .add(const RegisterSubmitted());
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text('Registrarse'),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
