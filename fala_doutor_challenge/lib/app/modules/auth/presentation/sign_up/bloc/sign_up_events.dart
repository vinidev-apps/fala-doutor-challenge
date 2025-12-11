import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Atualiza o usuário parcialmente via copyWith
class SignUpUpdateUserEvent extends SignUpEvent {
  final UserEntity user;

  SignUpUpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

/// Avança step
class SignUpNextStepEvent extends SignUpEvent {}

/// Volta step
class SignUpPreviousStepEvent extends SignUpEvent {}

/// Finaliza e envia o cadastro
class SignUpSubmitEvent extends SignUpEvent {
  final String password;

  SignUpSubmitEvent(this.password);

  @override
  List<Object?> get props => [password];
}
