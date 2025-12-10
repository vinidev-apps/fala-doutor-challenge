import 'package:equatable/equatable.dart';

abstract class PasswordRecoveryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPasswordRecoveryEmailEvent extends PasswordRecoveryEvent {
  final String email;

  SendPasswordRecoveryEmailEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
