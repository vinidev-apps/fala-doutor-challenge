import 'package:fala_doutor_challenge/app/core/utils/constants.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/email_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/widgets/buttons/rounded_gradient_button_widget.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/bloc/sign_in_states.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/widgets/sign_in_icon_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInTabletPage extends StatefulWidget {
  final SignInBloc signInBloc;
  final void Function() goToPasswordRecoveryPage;
  final void Function() goToSignUpPage;
  final void Function({
    required String email,
    required String password,
    required bool keepLogged,
  })
  onSignIn;
  final GlobalKey formKey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final String? Function(String?, String) validateField;

  const SignInTabletPage({
    super.key,
    required this.signInBloc,
    required this.goToPasswordRecoveryPage,
    required this.goToSignUpPage,
    required this.onSignIn,
    required this.formKey,
    required this.emailTextController,
    required this.passwordTextController,
    required this.validateField,
  });

  @override
  State<SignInTabletPage> createState() => _SignInTabletPageState();
}

class _SignInTabletPageState extends State<SignInTabletPage> {
  bool hidePasswordField = true;
  bool hideConfirmatioPasswordField = true;
  bool keepLogged = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: widget.signInBloc,
      listener: (context, state) {
        if (state is SignInErrorState) {
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
        }
      },
      builder: (context, state) {
        if (state is SignInLoadingState) {
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
                          const SizedBox(height: 40),
                          Text(
                            "entrar com e-mail",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(height: 40),
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
                          DefaultTextFormFieldWidget(
                            hintText: 'Insira sua senha...',
                            verticalPadding: 0,
                            textEditingController:
                                widget.passwordTextController,
                            textStyle: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                            hintTextStyle: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                            obscureText: hidePasswordField,
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  hidePasswordField = !hidePasswordField;
                                });
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsetsGeometry.symmetric(
                                  vertical: 18,
                                  horizontal: 20,
                                ),
                                child: FaIcon(
                                  hidePasswordField
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  size: 20,
                                ),
                              ),
                            ),
                            validator: (value) =>
                                widget.validateField(value, 'password'),
                            onSubmit: (p0) {
                              widget.onSignIn;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  StatefulBuilder(
                                    builder: (context, setStateSB) {
                                      return Transform.scale(
                                        scale: 1.4,
                                        child: Checkbox(
                                          value: keepLogged,
                                          fillColor: WidgetStatePropertyAll(
                                            Theme.of(
                                              context,
                                            ).colorScheme.surfaceContainerLow,
                                          ),
                                          checkColor: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          overlayColor: WidgetStatePropertyAll(
                                            Colors.transparent,
                                          ),
                                          side: BorderSide.none,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,

                                          visualDensity: const VisualDensity(
                                            horizontal: -2,
                                            vertical: -4,
                                          ),

                                          onChanged: (value) {
                                            setState(() {
                                              keepLogged = value ?? false;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Mantenha-me logado",
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.outline,
                                        ),
                                  ),
                                ],
                              ),

                              InkWell(
                                onTap: () => widget.goToPasswordRecoveryPage(),
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Text(
                                  "Esqueceu a senha?",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        decorationThickness: 1,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          GradientTextButtonWidget(
                            labelText: 'entrar',
                            onTap: () {
                              widget.onSignIn(
                                email: widget.emailTextController.text.trim(),
                                password: widget.passwordTextController.text
                                    .trim(),
                                keepLogged: keepLogged,
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  radius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Text(
                                'ou',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      fontSize: 20,
                                    ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  radius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInIconButtonWidget(
                                imagePath: Constants.googleLogoImage,
                              ),
                              const SizedBox(width: 20),
                              SignInIconButtonWidget(
                                imagePath: Constants.appleLogoImage,
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
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
