import 'package:equatable/equatable.dart';

abstract class PasswordRecoveryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordRecoveryInitialState extends PasswordRecoveryState {}

class PasswordRecoveryLoadingState extends PasswordRecoveryState {}

class PasswordRecoverySuccessState extends PasswordRecoveryState {
  PasswordRecoverySuccessState();

  @override
  List<Object?> get props => [];
}

class PasswordRecoveryErrorState extends PasswordRecoveryState {
  final String message;

  PasswordRecoveryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
