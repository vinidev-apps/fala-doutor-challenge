import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpFlowState extends SignUpState {
  final UserEntity user;
  final int currentStep;
  final int totalSteps;
  final double progress;

  SignUpFlowState({
    required this.user,
    required this.currentStep,
    required this.totalSteps,
  }) : progress = currentStep / totalSteps;

  SignUpFlowState copyWith({
    UserEntity? user,
    int? currentStep,
    int? totalSteps,
  }) {
    return SignUpFlowState(
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }

  @override
  List<Object?> get props => [user, currentStep, totalSteps, progress];
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
