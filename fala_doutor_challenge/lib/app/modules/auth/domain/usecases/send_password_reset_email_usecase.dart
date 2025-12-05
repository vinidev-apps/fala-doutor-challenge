import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class SendPasswordResetEmailUsecase {
  final AuthRepository repository;

  SendPasswordResetEmailUsecase(this.repository);

  Future<void> call({required String email}) async {
    return await repository.sendPasswordResetEmail(email: email);
  }
}
