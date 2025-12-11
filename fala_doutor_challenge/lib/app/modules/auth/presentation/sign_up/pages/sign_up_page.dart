import 'package:fala_doutor_challenge/app/core/builders/responsive_layout_builder.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_events.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/desktop/sign_up_desktop_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/mobile/sign_up_mobile_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/tablet/sign_up_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // BLOC
  final bloc = Modular.get<SignUpBloc>();

  /// Form global
  final GlobalKey formKey = GlobalKey<FormState>();

  /// Controllers globais
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validator
  String? validateField(String? value, String type) {
    if (value == null || value.trim().isEmpty) {
      return "Campo obrigatório";
    }

    switch (type) {
      case "email":
        if (!RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(value.trim())) {
          return "E-mail inválido";
        }
        break;

      case "password":
        if (value.length < 8) {
          return "A senha deve ter ao menos 8 caracteres.";
        }
        break;
    }
    return null;
  }

  // BLOC METHODS

  /// Atualiza campos do usuário via copyWith
  void updateUser(UserEntity newUser) {
    bloc.add(SignUpUpdateUserEvent(newUser));
  }

  /// Avança step
  void goNextStep() {
    if (formKey.currentState != null &&
        !(formKey.currentState as FormState).validate()) {
      return;
    }
    bloc.add(SignUpNextStepEvent());
  }

  /// Volta step
  void goPreviousStep() {
    bloc.add(SignUpPreviousStepEvent());
  }

  /// Confirma cadastro final
  Future<void> submitSignUp() async {
    final password = passwordController.text.trim();

    if (password.isEmpty) return;

    bloc.add(SignUpSubmitEvent(password));
  }

  /// Volta para o Sign In
  void goToSignInPage() {
    Modular.to.pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: SignUpMobilePage(),
        tablet: SignUpTabletPage(),
        desktop: SignUpDesktopPage(
          signUpBloc: bloc,
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          validateField: validateField,
          updateUser: updateUser,
          goNextStep: goNextStep,
          goPreviousStep: goPreviousStep,
          submitSignUp: submitSignUp,
          goToSignInPage: goToSignInPage,
        ),
      ),
    );
  }
}
