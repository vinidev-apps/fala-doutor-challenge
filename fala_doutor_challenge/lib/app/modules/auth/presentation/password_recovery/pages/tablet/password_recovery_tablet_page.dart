import 'package:fala_doutor_challenge/app/core/utils/constants.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/email_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/widgets/buttons/rounded_gradient_button_widget.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/bloc/password_recovery_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/bloc/password_recovery_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordRecoveryTabletPage extends StatefulWidget {
  final PasswordRecoveryBloc passwordRecoveryBloc;
  final void Function() goToSignInPage;
  final void Function() goToSignUpPage;
  final void Function({required String email}) onSendPasswordRecoveryEmail;
  final GlobalKey formKey;
  final TextEditingController emailTextController;
  final String? Function(String?, String) validateField;

  const PasswordRecoveryTabletPage({
    super.key,
    required this.passwordRecoveryBloc,
    required this.goToSignInPage,
    required this.goToSignUpPage,
    required this.onSendPasswordRecoveryEmail,
    required this.formKey,
    required this.emailTextController,
    required this.validateField,
  });

  @override
  State<PasswordRecoveryTabletPage> createState() =>
      _PasswordRecoveryTabletPageState();
}

class _PasswordRecoveryTabletPageState
    extends State<PasswordRecoveryTabletPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.passwordRecoveryBloc,
      listener: (context, state) {
        if (state is PasswordRecoveryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state is PasswordRecoverySuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "E-mail de recuperação de senha enviado com sucesso! Verifique sua caixa de entrada.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.scrim,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PasswordRecoveryLoadingState) {
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 5,
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: widget.formKey,
                  child: Center(
                    child: SizedBox(
                      width: 800,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Constants.logoTypeImage,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 60),
                          Text(
                            "recuperação de senha",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Insira o e-mail da sua conta do Fala, doutor! no campo de texto abaixo e clique no botão de envio e um e-mail lhe será enviado para que você possa redefinir sua senha.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 60),
                          DefaultTextFormFieldWidget(
                            verticalPadding: 0,
                            hintText: 'Insira seu e-mail...',
                            textEditingController: widget.emailTextController,
                            textInputType: TextInputType.emailAddress,
                            textStyle: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                            hintTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                            suffix: Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                vertical: 20,
                                horizontal: 25,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.solidUser,
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 18,
                              ),
                            ),
                            inputFormatters: [EmailInputFormatter()],
                            validator: (value) =>
                                widget.validateField(value, 'email'),
                          ),
                          const SizedBox(height: 20),
                          GradientTextButtonWidget(
                            labelText: 'enviar e-mail',
                            onTap: () {
                              widget.onSendPasswordRecoveryEmail(
                                email: widget.emailTextController.text.trim(),
                              );
                            },
                          ),
                          const SizedBox(height: 60),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Senha recuperada? ",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              children: [
                                TextSpan(
                                  text: "Clique aqui para entrar",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => widget.goToSignInPage(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Não possui uma conta? ",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              children: [
                                TextSpan(
                                  text: "Clique aqui para começar",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => widget.goToSignUpPage(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
