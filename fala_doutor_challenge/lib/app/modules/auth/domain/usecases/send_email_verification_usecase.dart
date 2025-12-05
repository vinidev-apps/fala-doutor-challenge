import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class SendEmailVerificationUsecase {
  final AuthRepository repository;

  SendEmailVerificationUsecase(this.repository);

  Future<void> call() async {
    return await repository.sendEmailVerification();
  }
}
