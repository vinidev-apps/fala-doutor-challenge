import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // Sign In
  Future<UserEntity> signIn({required String email, required String password});

  // Sign up
  Future<UserEntity> signUp({
    required UserEntity user,
    required String password,
  });

  // Sign out
  Future<void> signOut();

  // Get logged user
  Future<UserEntity?> getLoggedUser();

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email});

  // Send email verification (NÃO precisa de email)
  Future<void> sendEmailVerification();

  // Check email verification
  Future<bool> isEmailVerified();
}
