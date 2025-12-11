import 'package:fala_doutor_challenge/app/core/builders/responsive_layout_builder.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/bloc/sign_in_events.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/pages/desktop/sign_in_desktop_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/pages/mobile/sign_in_mobile_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/pages/tablet/sign_in_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final bloc = Modular.get<SignInBloc>();
  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  Future<void> onSignIn({
    required String email,
    required String password,
    required bool keepLogged,
  }) async {
    if (formKey.currentState != null &&
        !(formKey.currentState as FormState).validate()) {
      return;
    }

    bloc.add(
      SignInWithEmailEvent(
        email: email,
      password: password,
        keepLoggedIn: keepLogged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void goToPasswordRecoveryPage() {
      Modular.to.pushNamed('password_recovery');
    }

    void goToSignUpPage() {
    Modular.to.pushNamed('sign_up');
    }

    String? validateField(String? value, String fieldType) {
      if (value == null || value.isEmpty) {
        return 'Este campo é obrigatório!';
      }

      switch (fieldType) {
        case 'email':
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Insira um formato de e-mail válido.';
          }
          break;

        case 'password':
          if (value.length < 8) {
            return 'A senha deve ter no mínimo 8 caracteres.';
          }
          break;
      }

      return null;
    }

    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: SignInMobilePage(
          signInBloc: bloc,
          goToPasswordRecoveryPage: goToPasswordRecoveryPage,
          goToSignUpPage: goToSignUpPage,
          onSignIn: onSignIn,
          formKey: formKey,
          emailTextController: emailTextController,
          passwordTextController: passwordTextController,
          validateField: validateField,
        ),
        tablet: SignInTabletPage(
          signInBloc: bloc,
          goToPasswordRecoveryPage: goToPasswordRecoveryPage,
          goToSignUpPage: goToSignUpPage,
          onSignIn: onSignIn,
          formKey: formKey,
          emailTextController: emailTextController,
          passwordTextController: passwordTextController,
          validateField: validateField,
        ),
        desktop: SignInDesktopPage(
          signInBloc: bloc,
          goToPasswordRecoveryPage: goToPasswordRecoveryPage,
          goToSignUpPage: goToSignUpPage,
          onSignIn: onSignIn,
          formKey: formKey,
          emailTextController: emailTextController,
          passwordTextController: passwordTextController,
          validateField: validateField,
        ),
      ),
    );
  }
}
