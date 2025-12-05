import 'package:equatable/equatable.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final UserEntity user;

  SignInSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class SignInErrorState extends SignInState {
  final String message;

  SignInErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
