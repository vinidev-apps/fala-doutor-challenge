import 'package:fala_doutor_challenge/app/modules/auth/data/datasource/auth_datasource.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/models/user_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final UserModel model = await _datasource.signIn(
      email: email,
      password: password,
    );

    return model.toEntity();
  }

  @override
  Future<UserEntity> signUp({
    required UserEntity user,
    required String password,
  }) async {
    // datasource recebe Model, então eu converto Entity → Model
    final UserModel model = UserModel.fromEntity(user);

    final UserModel createdUser = await _datasource.signUp(
      user: model,
      password: password,
    );

    return createdUser.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _datasource.signOut();
  }

  @override
  Future<UserEntity?> getLoggedUser() async {
    final UserModel? model = await _datasource.getLoggedUser();

    if (model == null) return null;

    return model.toEntity();
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _datasource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> sendEmailVerification() async {
    await _datasource.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    return await _datasource.isEmailVerified();
  }
}
