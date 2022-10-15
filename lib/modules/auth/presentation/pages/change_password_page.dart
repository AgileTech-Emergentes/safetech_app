import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChangePasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: BlocProvider<ChangePasswordBloc>(
            create: (_) => ChangePasswordBloc(),
            child: const ChangePasswordForm(),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
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
                content: Text('Correo de recuperación enviado!'),
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
              const SizedBox(height: 24),
              const _RecoverPasswordButton(),
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
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return TextField(
          key: const Key('changePasswordForm_emailInput_textField'),
          onChanged: (value) => context
              .read<ChangePasswordBloc>()
              .add(ChangePasswordEmailChanged(value)),
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            hintText: 'Ingrese su correo electrónico',
            errorText: state.email.getErrorMessage(),
          ),
        );
      },
    );
  }
}

class _RecoverPasswordButton extends StatelessWidget {
  const _RecoverPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        final isSubmissionInProgress = state.status.isSubmissionInProgress;

        return isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  ElevatedButton(
                    key: const Key('changePasswordForm_submit_raisedButton'),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<ChangePasswordBloc>()
                                .add(const ChangePasswordSubmitted());
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text('Recuperar contraseña'),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
