import 'package:safetech_app/core/presentation/presentation.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(
              streamRepository:
                  RepositoryProvider.of<StreamRepository>(context),
            ),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.RED,
              ),
            );
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
              const SizedBox(height: 24),
              const _PasswordInput(),
              const SizedBox(height: 8),
              _buildForgotPasswordLink(context),
              const SizedBox(height: 24),
              const _LoginButton(),
              const SizedBox(height: 16),
              _buildRegistrationLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          text: '¿Olvidaste tu contraseña?',
          style: Theme.of(context).textTheme.headline5?.copyWith(
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).push(ChangePasswordPage.route());
            },
        ),
      ),
    );
  }

  Widget _buildRegistrationLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '¿No tienes cuenta? ',
        style: Theme.of(context).textTheme.headline5,
        children: [
          TextSpan(
            text: 'Regístrate',
            style: TextStyle(
              color: AppColors.BLUE_PRIMARY,
              fontWeight: FontWeight.bold
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(RegisterPage.route());
              },
          )
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChanged(value)),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.email, color: AppColors.BLACK),
            labelText: 'Email',
            hintText: 'Ingrese su email',
            errorText: state.email.getErrorMessage(),
            labelStyle: TextStyle(
              color: state.email.valid ? null : AppColors.RED,
            ),
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final visible = state.passwordVisible;
        final visibilityIcon = visible ? Icons.visibility : Icons.visibility_off;
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          obscureText: !visible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(visibilityIcon, color: AppColors.BLACK),
              onPressed: () {
                if (visible) {
                  context.read<LoginBloc>().add(const LoginPasswordHidden());
                } else {
                  context.read<LoginBloc>().add(const LoginPasswordShowed());
                }
              },
            ),
            labelText: 'Contraseña',
            hintText: 'Ingrese su contraseña',
            errorText: state.password.getErrorMessage(),
            labelStyle: TextStyle(
              color: state.password.valid ? null : AppColors.RED,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isSubmissionInProgress = state.status.isSubmissionInProgress;
        return isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  ElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    onPressed: state.status.isValidated ? () => context.read<LoginBloc>().add(const LoginSubmitted()): null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text('Iniciar Sesión'),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
