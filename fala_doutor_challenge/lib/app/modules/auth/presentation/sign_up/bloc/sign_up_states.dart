import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpFlowState extends SignUpState {
  final UserEntity user;
  final int currentStepIndex;
  final int totalSteps;
  final double progress;
  final List<HealthPlanEntity> availableHealthPlans;
  final bool isLoadingHealthPlans;

  SignUpFlowState({
    required this.user,
    required this.currentStepIndex,
    required this.totalSteps,
    this.availableHealthPlans = const [],
    this.isLoadingHealthPlans = false,
  }) : progress = currentStepIndex / totalSteps;

  SignUpFlowState copyWith({
    UserEntity? user,
    int? currentStep,
    int? totalSteps,
    List<HealthPlanEntity>? availableHealthPlans,
    bool? isLoadingHealthPlans,
  }) {
    return SignUpFlowState(
      user: user ?? this.user,
      currentStepIndex: currentStep ?? this.currentStepIndex,
      totalSteps: totalSteps ?? this.totalSteps,
      availableHealthPlans: availableHealthPlans ?? this.availableHealthPlans,
      isLoadingHealthPlans: isLoadingHealthPlans ?? this.isLoadingHealthPlans,
    );
  }

  @override
  List<Object?> get props => [
    user,
    currentStepIndex,
    totalSteps,
    progress,
    availableHealthPlans,
    isLoadingHealthPlans,
  ];
}

class SignUpLoadingState extends SignUpState {}

class SignUpSubmittingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final UserEntity user;

  SignUpSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
