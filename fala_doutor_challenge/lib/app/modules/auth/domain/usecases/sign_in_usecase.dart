import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(email: email, password: password);
  }
}
