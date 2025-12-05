import 'package:bloc/bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_in_usecase.dart';
import 'sign_in_events.dart';
import 'sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUsecase signInUsecase;

  SignInBloc({required this.signInUsecase}) : super(SignInInitialState()) {
    on<SignInWithEmailEvent>(_onSignIn);
  }

  Future<void> _onSignIn(
    SignInWithEmailEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadingState());

    try {
      final user = await signInUsecase(
        email: event.email,
        password: event.password,
      );

      emit(SignInSuccessState(user));
    } catch (e) {
      emit(SignInErrorState(e.toString()));
    }
  }
}
