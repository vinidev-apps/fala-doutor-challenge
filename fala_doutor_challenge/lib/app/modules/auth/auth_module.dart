import 'package:fala_doutor_challenge/app/modules/auth/data/datasource/auth_datasource.dart';
import 'package:fala_doutor_challenge/app/modules/auth/data/repository/auth_repository_impl.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/check_email_verification_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_in_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/bloc/password_recovery_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/password_recovery/pages/password_recovery_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_in/pages/sign_in_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/pages/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    // DATASOURCE
    i.addLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());

    // REPOSITORY
    i.addLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(i.get<AuthDatasource>()),
    );

    // USECASES
    i.addLazySingleton<SignInUsecase>(
      () => SignInUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<GetLoggedUserUsecase>(
      () => GetLoggedUserUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<SendPasswordResetEmailUsecase>(
      () => SendPasswordResetEmailUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<SendEmailVerificationUsecase>(
      () => SendEmailVerificationUsecase(i.get<AuthRepository>()),
    );
    i.addLazySingleton<CheckEmailVerificationUsecase>(
      () => CheckEmailVerificationUsecase(i.get<AuthRepository>()),
    );

    // BLOC
    i.addLazySingleton<SignInBloc>(SignInBloc.new);
    i.addLazySingleton<PasswordRecoveryBloc>(PasswordRecoveryBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => SignInPage());
    r.child('/sign_up', child: (context) => SignUpPage());
    r.child('/password_recovery', child: (context) => PasswordRecoveryPage());
  }
}
