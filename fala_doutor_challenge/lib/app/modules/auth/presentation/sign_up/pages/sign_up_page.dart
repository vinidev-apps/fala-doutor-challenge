import 'package:fala_doutor_challenge/app/core/builders/responsive_layout_builder.dart';
import 'package:fala_doutor_challenge/app/core/utils/constants.dart';
import 'package:fala_doutor_challenge/app/core/utils/extensions/string_extensions.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_events.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_states.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/desktop/sign_up_desktop_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/mobile/sign_up_mobile_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/tablet/sign_up_tablet_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/sign_up_step_view_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/dropdown_view_model.dart';
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
  DropdownValueModel userTypeDropdownValue = userTypeValues.first;
  final TextEditingController nameTextController = TextEditingController();
  final DropdownValueModel sexDropdownValue = sexValues.first;
  final TextEditingController birthDateTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  // Controllers do type "patient"
  final DropdownValueModel hasHealthPlanDropdownValue =
      hasHealthPlanValues.first;
  final TextEditingController healthPlanCodeCard = TextEditingController();
  final DropdownValueModel cityDropdownValue = DropdownValueModel(
    value: 'Fortaleza',
    label: 'Fortaleza/Ceará',
  );

  // Controllers do type "doctor"
  final TextEditingController crmTextController = TextEditingController();
  final DropdownValueModel specialityDropdownValue = specialityValues.first;
  final List<String> availableHealthPlans = [];
  final DropdownValueModel webAppointmentsDropdownValue =
      webAppointmentsValues.first;
  final DropdownValueModel doctorCityDropdownValue = DropdownValueModel(
    value: 'Fortaleza',
    label: 'Fortaleza/Ceará',
  );

  SignUpStepViewModel getStepViewModelFromIndexAndUser({
    required int stepIndex,
    required UserEntity user,
  }) {
    switch (stepIndex) {
      case 0:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpWalkingImage,
          stepHeadlineText:
              "Olá! Vamos começar!\n Você deseja criar sua conta como paciente ou médico?",
          stepDropdownValue: userTypeDropdownValue,
        );
      case 1:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpAnalyzingImage,
          stepHeadlineText: "Ótimo! E como eu posso te chamar?",
          stepTextEditingControler: nameTextController,
        );
      case 2:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpTalkingImage,
          stepHeadlineText:
              "Muito prazer em te conhecer, ${user.name.firstName}! Me fala como você se identifica?",
          stepDropdownValue: sexDropdownValue,
        );
      case 3:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpHappyImage,
          stepHeadlineText:
              "Incrível! Agora, me diz por favor a sua data de nascimento?",
          stepTextEditingControler: birthDateTextController,
        );
      case 4:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpTalkingImage,
          stepHeadlineText: "E ${user.name.firstName}, qual o seu e-mail?",
          stepTextEditingControler: emailTextController,
        );
      case 5:
        if (user.type == 'patient') {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText: "Você possui plano de Saúde?",
            stepDropdownValue: hasHealthPlanDropdownValue,
          );
        } else {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText: "Qual o seu CRM?",
            stepTextEditingControler: crmTextController,
          );
        }
      case 6:
        if (user.type == 'patient') {
          List<DropdownValueModel> healthPlanDropdownItems =
              bloc.state is SignUpFlowState
              ? (bloc.state as SignUpFlowState).availableHealthPlans
                    .map(
                      (plan) => DropdownValueModel(
                        value: plan,
                        label: plan.displayName,
                      ),
                    )
                    .toList()
              : [];

          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText: "Qual é o seu principal plano de saúde?",
            stepDropdownItems: healthPlanDropdownItems,
            stepDropdownValue: healthPlanDropdownItems.isNotEmpty
                ? healthPlanDropdownItems.first
                : null,
          );
        } else {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpHappyImage,
            stepHeadlineText:
                "Poderia selecionar os planos de saúde que você atende?",
            healthPlansDoctor: bloc.state is SignUpFlowState
                ? (bloc.state as SignUpFlowState).availableHealthPlans
                : [],
          );
        }
      case 7:
        if (user.type == 'patient') {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText:
                "Poderia digitar o código da carteirinha do seu plano${user.patientData?.userHealthPlans.first.healthPlan.name ?? ''}?",
            stepTextEditingControler: healthPlanCodeCard,
          );
        } else {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText: "E você deseja atender em qual especialidade?",
            stepDropdownValue: specialityDropdownValue,
          );
        }
      case 8:
        if (user.type == 'patient') {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpHappyImage,
            stepHeadlineText: "Para finalizar, em qual cidade você reside?",
            stepDropdownValue: cityDropdownValue,
          );
        } else {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpAnalyzingImage,
            stepHeadlineText: "E você atende teleconsultas?",
            stepDropdownValue: webAppointmentsDropdownValue,
          );
        }
      case 9:
        if (user.type == 'doctor') {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpHappyImage,
            stepHeadlineText: "Para finalizar, em qual cidade você atende?",
            stepDropdownValue: doctorCityDropdownValue,
          );
        } else {
          return SignUpStepViewModel(
            stepDisplayImage: Constants.signUpHappyImage,
            stepHeadlineText:
                "Ótimo! Agora é só criar uma senha para sua conta.",
            stepTextEditingControler: passwordTextController,
          );
        }
      default:
        return SignUpStepViewModel(
          stepDisplayImage: Constants.signUpWalkingImage,
          stepHeadlineText: "Olá! Vamos começar?\nComo eu posso te chamar?",
          stepTextEditingControler: nameTextController,
        );
    }
  }

  // BLOC METHODS
  // Atualiza campos do usuário via copyWith
  void updateUser(UserEntity newUser) {
    bloc.add(SignUpUpdateUserEvent(newUser));
  }

  // Avança step
  void goNextStep() {
    bloc.add(SignUpNextStepEvent());
  }

  // Volta step
  void goPreviousStep() {
    bloc.add(SignUpPreviousStepEvent());
  }

  // Confirma cadastro final
  Future<void> submitSignUp() async {
    final password = passwordTextController.text.trim();

    if (password.isEmpty) return;

    bloc.add(SignUpSubmitEvent(password));
  }

  // Carrega planos de saúde disponíveis
  Future<void> loadHealthPlans() async {
    bloc.add(SignUpLoadHealthPlansEvent());
  }

  // Volta para o Sign In
  void goToSignInPage() {
    Modular.to.pushReplacementNamed("/");
  }

  @override
  void initState() {
    loadHealthPlans();
    super.initState();
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
          userTypeDropdownValue: userTypeDropdownValue,
          updateUser: updateUser,
          goNextStep: goNextStep,
          goPreviousStep: goPreviousStep,
          submitSignUp: submitSignUp,
          loadHealthPlans: loadHealthPlans,
          goToSignInPage: goToSignInPage,
          getStepViewModelFromIndexAndUser: getStepViewModelFromIndexAndUser,
        ),
      ),
    );
  }
}
