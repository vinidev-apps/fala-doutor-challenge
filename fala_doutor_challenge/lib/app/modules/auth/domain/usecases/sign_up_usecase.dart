import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase(this.repository);

  Future<UserEntity> call({
    required UserEntity user,
    required String password,
  }) async {
    return await repository.signUp(user: user, password: password);
  }
}
