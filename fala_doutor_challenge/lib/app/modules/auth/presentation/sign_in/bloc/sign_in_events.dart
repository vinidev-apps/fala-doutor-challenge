import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithEmailEvent extends SignInEvent {
  final String email;
  final String password;
  final bool? keepLoggedIn;

  SignInWithEmailEvent({
    required this.email,
    required this.password,
    this.keepLoggedIn = false,
  });

  @override
  List<Object?> get props => [email, password];
}
