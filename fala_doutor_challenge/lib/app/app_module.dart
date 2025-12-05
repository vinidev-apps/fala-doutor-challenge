import 'package:fala_doutor_challenge/app/core/presentation/pages/not_found_page.dart';
import 'package:fala_doutor_challenge/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: AuthModule(), transition: TransitionType.fadeIn);
    WildcardRoute(child: (context) => NotFoundPage());
  }
}
