import 'package:fala_doutor_challenge/app/core/utils/constants.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpDesktopPage extends StatefulWidget {
  final SignUpBloc signUpBloc;
  final GlobalKey formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  // Methods
  final String? Function(String?, String) validateField;
  final void Function(UserEntity user) updateUser;
  final void Function() goNextStep;
  final void Function() goPreviousStep;
  final Future<void> Function() submitSignUp;
  final void Function() goToSignInPage;

  const SignUpDesktopPage({
    super.key,
    required this.signUpBloc,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.validateField,
    required this.updateUser,
    required this.goNextStep,
    required this.goPreviousStep,
    required this.submitSignUp,
    required this.goToSignInPage,
  });

  @override
  State<SignUpDesktopPage> createState() => _SignUpDesktopPageState();
}

class _SignUpDesktopPageState extends State<SignUpDesktopPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: widget.signUpBloc,
      listener: (context, state) {
        if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignUpLoadingState || state is SignUpSubmittingState) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 5,
            ),
          );
        }

        if (state is SignUpFlowState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(child: _leftSideImage(context)),
                Expanded(child: _rightSideForm(context, state)),
              ],
            ),
          );
        }

        if (state is SignUpSuccessState) {
          return Center(child: Text("Cadastro realizado com sucesso!"));
        }

        return Center(child: Text("Estado desconhecido"));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // LEFT SIDE (imagem com gradiente)
  Widget _leftSideImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: Image.asset(Constants.signInDisplayImage, fit: BoxFit.contain),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // RIGHT SIDE (conteúdo dinâmico)
  Widget _rightSideForm(BuildContext context, SignUpFlowState state) {
    return Center(
      child: SizedBox(
        width: 700,
        child: Form(
          key: widget.formKey,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _buildStepContent(context, state),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DEFINIR QUAL STEP RENDERIZAR
  Widget _buildStepContent(BuildContext context, SignUpFlowState state) {
    switch (state.currentStep) {
      case 0:
        return _stepAccountType(context, state);
      case 1:
        return _stepUserData(context, state);
      case 2:
        return _stepSecurity(context, state);
      case 3:
        return _stepReview(context, state);
      default:
        return SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // STEP 0 — Tipo de conta
  Widget _stepAccountType(BuildContext context, SignUpFlowState state) {
    return Column(
      key: ValueKey("step0"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Quem é você?", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            _typeButton(
              context,
              label: "Sou Paciente",
              icon: FontAwesomeIcons.user,
              selected: state.user.type == "patient",
              onTap: () {
                widget.updateUser(state.user.copyWith(type: "patient"));
                widget.goNextStep();
              },
            ),
            _typeButton(
              context,
              label: "Sou Médico",
              icon: FontAwesomeIcons.userDoctor,
              selected: state.user.type == "doctor",
              onTap: () {
                widget.updateUser(state.user.copyWith(type: "doctor"));
                widget.goNextStep();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _typeButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            FaIcon(icon, size: 28),
            const SizedBox(height: 15),
            Text(label, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 1 — Nome + Email
  Widget _stepUserData(BuildContext context, SignUpFlowState state) {
    return Column(
      key: ValueKey("step1"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dados Pessoais",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 40),

        // NOME
        TextFormField(
          controller: widget.nameController,
          validator: (v) => widget.validateField(v, "name"),
          decoration: InputDecoration(
            labelText: "Nome completo",
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (value) {
            widget.updateUser(state.user.copyWith(name: value.trim()));
          },
        ),

        const SizedBox(height: 20),

        // EMAIL
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) => widget.validateField(v, "email"),
          decoration: InputDecoration(
            labelText: "E-mail",
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: (value) {
            widget.updateUser(state.user.copyWith(email: value.trim()));
          },
        ),

        const SizedBox(height: 40),
        _bottomNavButtons(context, showBack: true),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 2 — Senha + Confirmar
  Widget _stepSecurity(BuildContext context, SignUpFlowState state) {
    return Column(
      key: ValueKey("step2"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Segurança da Conta",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 40),

        // SENHA
        TextFormField(
          controller: widget.passwordController,
          obscureText: hidePassword,
          validator: (v) => widget.validateField(v, "password"),
          decoration: InputDecoration(
            labelText: "Senha",
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: FaIcon(
                hidePassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              ),
              onPressed: () => setState(() {
                hidePassword = !hidePassword;
              }),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // CONFIRMAR SENHA
        TextFormField(
          obscureText: hideConfirmPassword,
          validator: (v) {
            if (v == null || v.isEmpty) return "Confirme sua senha";
            if (v != widget.passwordController.text.trim()) {
              return "As senhas não coincidem";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Confirmar senha",
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: FaIcon(
                hideConfirmPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
              ),
              onPressed: () => setState(() {
                hideConfirmPassword = !hideConfirmPassword;
              }),
            ),
          ),
        ),

        const SizedBox(height: 40),
        _bottomNavButtons(context, showBack: true),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 3 — Revisão final + Confirmar
  Widget _stepReview(BuildContext context, SignUpFlowState state) {
    return Column(
      key: ValueKey("step3"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Revise suas informações",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 40),

        _reviewTile(Icons.person, "Nome", state.user.name),
        _reviewTile(Icons.email, "Email", state.user.email),
        _reviewTile(
          Icons.assignment_ind,
          "Tipo de Conta",
          state.user.type == "doctor" ? "Médico" : "Paciente",
        ),

        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: widget.submitSignUp,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
          ),
          child: Text("Finalizar Cadastro"),
        ),

        const SizedBox(height: 30),
        _bottomNavButtons(context, showBack: true, showNext: false),
      ],
    );
  }

  // WIDGET DE LINHAS DE REVISÃO
  Widget _reviewTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 20),
          Expanded(child: Text("$label: $value")),
        ],
      ),
    );
  }

  // BOTÕES DE NAVEGAÇÃO ENTRE STEPS
  Widget _bottomNavButtons(
    BuildContext context, {
    bool showBack = false,
    bool showNext = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBack)
          TextButton(onPressed: widget.goPreviousStep, child: Text("Voltar")),
        const SizedBox(width: 20),
        if (showNext)
          ElevatedButton(
            onPressed: widget.goNextStep,
            child: Text("Continuar"),
          ),
      ],
    );
  }
}
