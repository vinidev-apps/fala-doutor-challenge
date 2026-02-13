import 'package:bloc/bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_locale_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/get_available_health_plans_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/widgets.dart';

import 'sign_up_events.dart';
import 'sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUsecase signUpUsecase;
  final GetAvailableHealthPlansUsecase getAvailableHealthPlansUsecase;

  SignUpBloc({
    required this.signUpUsecase,
    required this.getAvailableHealthPlansUsecase,
  }) : super(
         SignUpFlowState(
           user: UserEntity(
             id: "",
             type: "",
             name: "",
             email: "",
             phone: null,
             birthDate: DateTime.now(),
             sex: "",
             cpf: null,
             avatarUrl: null,
             userLocale: UserLocaleEntity(country: "", state: "", city: ""),
             patientData: null,
             doctorData: null,
             emailVerified: false,
             createdAt: DateTime.now(),
             updatedAt: DateTime.now(),
           ),
           currentStepIndex: 0,
           totalSteps: 5,
         ),
       ) {
    on<SignUpUpdateUserEvent>(_onUpdateUser);
    on<SignUpNextStepEvent>(_onNextStep);
    on<SignUpPreviousStepEvent>(_onPreviousStep);
    on<SignUpSubmitEvent>(_onSubmit);
    on<SignUpLoadHealthPlansEvent>(_onLoadHealthPlans);
  }

  Future<void> _onUpdateUser(
    SignUpUpdateUserEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    int totalSteps = current.totalSteps;

    // Ajusta steps conforme o tipo
    if (event.user.type == "patient") {
      totalSteps = 5 + 3 + 2;
    } else if (event.user.type == "doctor") {
      totalSteps = 5 + 5 + 2;
    }

    debugPrint("User atualizado! ${event.user.toString()}");
    emit(current.copyWith(user: event.user, totalSteps: totalSteps));
  }

  Future<void> _onNextStep(
    SignUpNextStepEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    emit(
      current.copyWith(
        currentStep: (current.currentStepIndex < current.totalSteps - 1)
            ? current.currentStepIndex + 1
            : current.currentStepIndex,
      ),
    );
  }

  Future<void> _onPreviousStep(
    SignUpPreviousStepEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    emit(
      current.copyWith(
        currentStep: current.currentStepIndex > 0
            ? current.currentStepIndex - 1
            : 0,
      ),
    );
  }

  Future<void> _onSubmit(
    SignUpSubmitEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    emit(SignUpSubmittingState());

    try {
      final createdUser = await signUpUsecase(
        user: current.user,
        password: event.password,
      );

      emit(SignUpSuccessState(createdUser));
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }

  Future<void> _onLoadHealthPlans(
    SignUpLoadHealthPlansEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    // Evita refetch desnecessário
    if (current.availableHealthPlans.isNotEmpty) return;
    emit(current.copyWith(isLoadingHealthPlans: true));

    try {
      final plans = await getAvailableHealthPlansUsecase();

      debugPrint("Chegaram ${plans?.length ?? 0} no BLoC");

      emit(
        current.copyWith(
          availableHealthPlans: plans ?? [],
          isLoadingHealthPlans: false,
        ),
      );
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }
}
