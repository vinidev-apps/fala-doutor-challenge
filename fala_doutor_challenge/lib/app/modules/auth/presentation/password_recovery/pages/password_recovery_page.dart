import 'package:fala_doutor_challenge/app/core/builders/responsive_layout_builder.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/bloc/password_recovery_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/bloc/password_recovery_events.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/pages/desktop/password_recovery_desktop_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/pages/mobile/password_recovery_mobile_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/pages/tablet/password_recovery_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final bloc = Modular.get<PasswordRecoveryBloc>();
  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();

  Future<void> onSendPasswordRecoveryEmail({required String email}) async {
    if (formKey.currentState != null &&
        !(formKey.currentState as FormState).validate()) {
      return;
    }

    bloc.add(SendPasswordRecoveryEmailEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    void goToSignInPage() {
      Modular.to.pushNamed('/');
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
      }

      return null;
    }

    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: PasswordRecoveryMobilePage(
          passwordRecoveryBloc: bloc,
          goToSignInPage: goToSignInPage,
          goToSignUpPage: goToSignUpPage,
          onSendPasswordRecoveryEmail: onSendPasswordRecoveryEmail,
          formKey: formKey,
          emailTextController: emailTextController,
          validateField: validateField,
        ),
        tablet: PasswordRecoveryTabletPage(
          passwordRecoveryBloc: bloc,
          goToSignInPage: goToSignInPage,
          goToSignUpPage: goToSignUpPage,
          onSendPasswordRecoveryEmail: onSendPasswordRecoveryEmail,
          formKey: formKey,
          emailTextController: emailTextController,
          validateField: validateField,
        ),
        desktop: PasswordRecoveryDesktopPage(
          passwordRecoveryBloc: bloc,
          goToSignInPage: goToSignInPage,
          goToSignUpPage: goToSignUpPage,
          onSendPasswordRecoveryEmail: onSendPasswordRecoveryEmail,
          formKey: formKey,
          emailTextController: emailTextController,
          validateField: validateField,
        ),
      ),
    );
  }
}
