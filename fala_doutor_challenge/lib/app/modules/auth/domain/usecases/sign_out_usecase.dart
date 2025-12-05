import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository repository;

  SignOutUsecase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
