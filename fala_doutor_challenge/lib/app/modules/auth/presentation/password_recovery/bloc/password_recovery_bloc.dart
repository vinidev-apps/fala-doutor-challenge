import 'package:bloc/bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/send_password_reset_email_usecase.dart';

import 'password_recovery_events.dart';
import 'password_recovery_states.dart';

class PasswordRecoveryBloc
    extends Bloc<PasswordRecoveryEvent, PasswordRecoveryState> {
  final SendPasswordResetEmailUsecase sendPasswordResetEmailUsecase;

  PasswordRecoveryBloc({required this.sendPasswordResetEmailUsecase})
    : super(PasswordRecoveryInitialState()) {
    on<SendPasswordRecoveryEmailEvent>(_onSendRecoveryEmail);
  }

  Future<void> _onSendRecoveryEmail(
    SendPasswordRecoveryEmailEvent event,
    Emitter<PasswordRecoveryState> emit,
  ) async {
    emit(PasswordRecoveryLoadingState());

    try {
      await sendPasswordResetEmailUsecase(email: event.email);

      emit(PasswordRecoverySuccessState());
    } catch (e) {
      emit(PasswordRecoveryErrorState(e.toString()));
    }
  }
}
