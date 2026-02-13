import 'package:fala_doutor_challenge/app/core/utils/utils.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/doctor_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/patient_data_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_states.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/sign_up_step_view_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/dropdown_view_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/widgets/sign_up_flow_desktop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpDesktopPage extends StatefulWidget {
  final SignUpBloc signUpBloc;
  final GlobalKey formKey;
  final DropdownValueModel userTypeDropdownValue;

  // Methods
  final void Function(UserEntity user) updateUser;
  final void Function() goNextStep;
  final void Function() goPreviousStep;
  final Future<void> Function() submitSignUp;
  final Future<void> Function() loadHealthPlans;
  final void Function() goToSignInPage;

  final SignUpStepViewModel Function({
    required int stepIndex,
    required UserEntity user,
  })
  getStepViewModelFromIndexAndUser;

  const SignUpDesktopPage({
    super.key,
    required this.signUpBloc,
    required this.formKey,
    required this.userTypeDropdownValue,
    required this.updateUser,
    required this.goNextStep,
    required this.goPreviousStep,
    required this.submitSignUp,
    required this.loadHealthPlans,
    required this.goToSignInPage,
    required this.getStepViewModelFromIndexAndUser,
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
          SignUpStepViewModel signUpStepViewModel = widget
              .getStepViewModelFromIndexAndUser(
                stepIndex: state.currentStepIndex,
                user: state.user,
              );

          return SignUpFlowDesktopWidget(
            state: state,
            formKey: widget.formKey,
            progress: state.progress,
            stepIndex: state.currentStepIndex,
            signUpStepViewModel: signUpStepViewModel,
            onNextStep: () {
              void validateTextFields(void Function() onValid) {
                if ((widget.formKey.currentState as FormState).validate()) {
                  onValid();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Por favor, corrija os erros antes de continuar.",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              }

              switch (state.currentStepIndex) {
                case 0:
                  widget.updateUser(
                    state.user.copyWith(
                      type: signUpStepViewModel.stepDropdownValue?.value ?? "",
                    ),
                  );
                  widget.goNextStep();
                  break;
                case 1:
                  validateTextFields(() {
                    widget.updateUser(
                      state.user.copyWith(
                        name: signUpStepViewModel.stepTextEditingControler?.text
                            .trim(),
                      ),
                    );
                    widget.goNextStep();
                  });
                  break;
                case 2:
                  widget.updateUser(
                    state.user.copyWith(
                      sex: signUpStepViewModel.stepDropdownValue?.value ?? "",
                    ),
                  );
                  widget.goNextStep();
                  break;
                case 3:
                  validateTextFields(() {
                    final text = signUpStepViewModel
                        .stepTextEditingControler
                        ?.text
                        .trim();

                    final birthDate = text != null
                        ? Utils.parseBrazilianDate(text)
                        : null;

                    widget.updateUser(
                      state.user.copyWith(birthDate: birthDate),
                    );

                    widget.goNextStep();
                  });
                  break;
                case 4:
                  validateTextFields(() {
                    widget.updateUser(
                      state.user.copyWith(
                        email: signUpStepViewModel
                            .stepTextEditingControler
                            ?.text
                            .trim(),
                      ),
                    );
                    widget.goNextStep();
                  });
                  break;
                case 5:
                  if (state.user.type == 'patient') {
                    widget.updateUser(
                      state.user.copyWith(
                        patientData: PatientDataEntity(
                          hasHealthPlan:
                              signUpStepViewModel.stepDropdownValue?.value ??
                              false,
                          userHealthPlans: [],
                        ),
                      ),
                    );
                    widget.goNextStep();
                  } else {
                    validateTextFields(() {
                      widget.updateUser(
                        state.user.copyWith(
                          doctorData: DoctorDataEntity(
                            crm:
                                signUpStepViewModel
                                    .stepTextEditingControler
                                    ?.text ??
                                '',
                            specialities: [],
                            healthPlans: [],
                            webAppointments: false,
                          ),
                        ),
                      );
                      widget.goNextStep();
                    });
                  }
                  break;
                default:
                  widget.updateUser(state.user);
                  widget.goNextStep();
                  break;
              }
            },
          );
        }

        if (state is SignUpSuccessState) {
          return Center(child: Text("Cadastro realizado com sucesso!"));
        }

        return Center(child: Text("Estado desconhecido"));
      },
    );
  }
}
