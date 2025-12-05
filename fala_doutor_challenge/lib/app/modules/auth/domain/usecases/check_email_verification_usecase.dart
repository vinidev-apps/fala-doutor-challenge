import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class CheckEmailVerificationUsecase {
  final AuthRepository repository;

  CheckEmailVerificationUsecase(this.repository);

  Future<bool> call() async {
    return await repository.isEmailVerified();
  }
}
