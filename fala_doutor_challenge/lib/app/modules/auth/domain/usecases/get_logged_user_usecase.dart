import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class GetLoggedUserUsecase {
  final AuthRepository repository;

  GetLoggedUserUsecase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getLoggedUser();
  }
}
