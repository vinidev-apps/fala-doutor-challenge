import 'package:bloc/bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_locale_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_up_usecase.dart';

import 'sign_up_events.dart';
import 'sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUsecase signUpUsecase;

  SignUpBloc({required this.signUpUsecase})
    : super(
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
          currentStep: 0,
          totalSteps: 5,
        ),
      ) {
    on<SignUpUpdateUserEvent>(_onUpdateUser);
    on<SignUpNextStepEvent>(_onNextStep);
    on<SignUpPreviousStepEvent>(_onPreviousStep);
    on<SignUpSubmitEvent>(_onSubmit);
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

    emit(current.copyWith(user: event.user, totalSteps: totalSteps));
  }

  Future<void> _onNextStep(
    SignUpNextStepEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final current = state as SignUpFlowState;

    emit(
      current.copyWith(
        currentStep: (current.currentStep < current.totalSteps - 1)
            ? current.currentStep + 1
            : current.currentStep,
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
        currentStep: current.currentStep > 0 ? current.currentStep - 1 : 0,
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
}
